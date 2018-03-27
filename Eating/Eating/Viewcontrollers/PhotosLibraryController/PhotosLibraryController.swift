//
//  PhotosLibraryController.swift
//  Eating
//
//  Created by Dai Pham on 3/15/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit
import Photos

fileprivate let column = UIDevice.current.userInterfaceIdiom == .pad ? CGFloat(6) : CGFloat(3)
fileprivate let space = CGFloat(10)

enum PhotosLibraryControllerType {
    case select // use for write review page
    case view // use show list photo for url
}

class PhotosLibraryController: BasePresentController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    // MARK: - api
    
    // MARK: - private
    private func config() {
        
        if type == .select {
            menuView.controller = self
        } else {
            menuView.removeFromSuperview()
        }
        
        collectView.register(UINib(nibName: "PhotoLibraryCollectCell", bundle: Bundle.main), forCellWithReuseIdentifier: "cell")
        collectView.delegate = self
        collectView.dataSource = self
    }
    
    func loadPhotos(_ selectFirst:Bool = false) {
        self.listPhotos.removeAll()
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status
            {
            case .authorized:
                let fetchOptions = PHFetchOptions()
                fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
                let allPhotos = PHAsset.fetchAssets(with: fetchOptions)
                allPhotos.enumerateObjects({ (asset, idx, _) in
//                    if selectFirst && idx == 0{
//                        self.listSelectedPhotos.append(asset)
//                    }
                    self.listPhotos.append(asset)
                    if idx == allPhotos.count - 1 {
                        
                        // check asset is deleted or remove
                        for (i,item) in self.listSelectedPhotos.reversed().enumerated() {
                            if !self.listPhotos.contains(item) {
                                self.listSelectedPhotos.remove(at: self.listSelectedPhotos.count - 1 - i)
                            }
                        }
                        
                        DispatchQueue.main.async {
                            self.collectView.reloadData()
                            self.onListSelectedPhotos?(self.listSelectedPhotos)
                        }
                    }
                    
                })
            case .denied, .restricted:
                print("Not allowed")
            case .notDetermined:
                print("Not determined yet")
            }
        }
    }
    
    func openCamera(view:UIView? = nil) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        imagePickerController.modalPresentationStyle = .fullScreen
        imagePickerController.delegate = self
        if isIpad {
            imagePickerController.popoverPresentationController?.sourceView = self.view
            var point = self.view.center
            if let view = view {
                point = view.convert(view.frame, to: self.view).center
            }
            imagePickerController.popoverPresentationController?.sourceRect.origin = point
        }
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        if type == .select {
            loadPhotos()
        } else if type == .view {
            collectView.reloadData()
        }
    }
   
    // MARK: - closures
    var onListSelectedPhotos:(([PHAsset])->Void)?
    var onNeedReloadPhotos:((Bool)->Void)?
    
    // MARK: - properties
    var listPhotos:[PHAsset] = []
    var listSelectedPhotos:[PHAsset] = []
    var listUrls:[String] = []
    var type:PhotosLibraryControllerType = .select
    
    // MARK: - outlet
    @IBOutlet weak var menuView: HeaderPresentControllerView!
    @IBOutlet weak var collectView: UICollectionView!
    @IBOutlet weak var stackContainer: UIStackView!
    
}

// MARK: -
fileprivate var PICKER = "PIKCER"
extension PhotosLibraryController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            objc_setAssociatedObject(self, &PICKER, picker, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
             UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
        } else {
            picker.dismiss(animated: true) {
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: {timer in
                    timer.invalidate()
                    self.loadPhotos()
                })
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //        print("START SYNC DATA WHEN UIImagePickerController CLOSED")
        //        LocalService.shared.startSyncData()
        picker.dismiss(animated: true)
    }
    
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let _ = error {
            // we got back an error!
//            Support.popup.showAlert(message: "error_save_to_photo".localized(), buttons: ["ok".localized()], vc: self.navigationController!, onAction: {index in
            
//            },nil)
        } else {
            if let picker = objc_getAssociatedObject(self, &PICKER) as? UIImagePickerController {
                self.loadPhotos()
                picker.dismiss(animated: true, completion: nil)
            }
//            Support.popup.showAlert(message: "photo_saved_success".localized(), buttons: ["ok".localized()], vc: self.navigationController!, onAction: {index in
    
//            },nil)
        }
    }
}

// MARK: -
extension PhotosLibraryController:UICollectionViewDelegate,
    UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if type == .select {
            return self.listPhotos.count + 1
        } else {
            return listUrls.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoLibraryCollectCell
        if type == .select {
            cell.load(asset: indexPath.row == 0 ? nil : listPhotos[indexPath.row - 1], (indexPath.row != 0 &&  listSelectedPhotos.contains(listPhotos[indexPath.row - 1])))
        } else {
            // load url
            cell.load(url: listUrls[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if type == .view {
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "galleryController") as! GalleryController
            vc.listUrls = listUrls
            vc.viewedIndex = indexPath.row
            
            let attributes = collectionView.layoutAttributesForItem(at: indexPath)
            let cellRect = attributes!.frame
            var cellFrameInSuperview =  collectionView.convert(cellRect, to: self.view)
            cellFrameInSuperview.origin.x = cellFrameInSuperview.origin.x - cellFrameInSuperview.size.width
            cellFrameInSuperview.origin.y = cellFrameInSuperview.origin.y - cellFrameInSuperview.size.height
            vc.startFrame = cellFrameInSuperview
            
            self.parent?.navigationController?.present(vc, animated: false, completion: nil)
            return
        }
        
        if indexPath.row == 0 {
            openCamera(view: collectionView.cellForItem(at: indexPath))
        } else {
            let item = listPhotos[indexPath.row - 1]
            if !listSelectedPhotos.contains(item) {
                listSelectedPhotos.append(item)
            } else {
                for (i,v) in self.listSelectedPhotos.reversed().enumerated() {
                    if v.isEqual(item) {
                        self.listSelectedPhotos.remove(at: (listSelectedPhotos.count - 1) - i)
                    }
                }
            }
            collectionView.reloadItems(at: [indexPath])
            self.onListSelectedPhotos?(listSelectedPhotos)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let realspace = space * (column-1)
        let width = (collectionView.frame.size.width - 20 - realspace)/column - 5/3
        return CGSize(width:width, height:width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 10, 0, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(space)
    }
    
}

// MARK: -
extension PhotosLibraryController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // hide/show bottom line on header controller
        if type == .select {
            menuView.effect(with: scrollView)
        }
    }
}

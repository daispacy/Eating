//
//  AddPhotosView.swift
//  Eating
//
//  Created by Dai Pham on 3/16/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit
import Photos

fileprivate let numberItems:CGFloat = UI_USER_INTERFACE_IDIOM() == .pad ? 8 : 4
fileprivate let spacing:CGFloat = 5

class AddPhotosView: UIView {

    // MARK: - api
    func load(data:[PHAsset]) {
        self.listAsset = data
        
        reset()
        
        for (i,item) in data.enumerated() {
            if CGFloat(i) == numberItems {break}
            let imageV = imageMenu(asset: item, index: (i+1), i == Int(numberItems - 2) && listAsset.count > 3) // 2: because we have a default image to open photos controller
            stackImages.addArrangedSubview(imageV)
            imageV.translatesAutoresizingMaskIntoConstraints = false
            let width = (UIScreen.main.bounds.size.width - 20  - (numberItems - 1)*spacing) / numberItems
            imageV.widthAnchor.constraint(equalToConstant: width).isActive = true
            imageV.heightAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
    
    // MARK: - action
    func touchImage(_ sender:UITapGestureRecognizer) {
        if let imv = sender.view as? UIImageView {
            if imv.tag == 0 {
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "photosLibrary") as! PhotosLibraryController
                controller?.present(vc, animated: true, completion: nil)
                vc.listSelectedPhotos = self.listAsset
                vc.onListSelectedPhotos = {[weak self] listAsset in
                    guard let _self = self else {return}
                    _self.load(data: listAsset)
                }
            } else {
                // open list controller editable photos
                
            }
        }
    }
    
    // MARK: - private
    private func reset() {
        
        for (i,imv) in stackImages.arrangedSubviews.reversed().enumerated() {
            if imv.tag != 0 {
                let tap = listTapGesture.reversed()[i]
                imv.removeGestureRecognizer(tap)
                imv.removeFromSuperview()
            }
        }
        
        for (i,_) in listTapGesture.reversed().enumerated() {
            if i < listTapGesture.count - 1 {
                listTapGesture.remove(at: i)
            }
        }
        
        listImages.removeAll()
    }
    
    private func imageMenu(asset:PHAsset,index:Int ,_ isShowMore:Bool = false) -> UIImageView{
        let imageView = UIImageView(frame: self.frame)
        imageView.tag = index
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 3
        asset.getImage(size: CGSize(width: 100, height: 100)) {[weak self] image in
            guard let _ = self, let image = image else {return}
            imageView.image = image
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(touchImage(_:)))
        imageView.addGestureRecognizer(tap)
        listTapGesture.append(tap)
        
        if isShowMore {
            let label = UILabel(frame: self.frame)
            label.backgroundColor = #colorLiteral(red: 0.09019607843, green: 0.1921568627, blue: 0.262745098, alpha: 0.4)
            label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            label.adjustsFontSizeToFitWidth = true
            imageView.addSubview(label)
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            label.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
            imageView.trailingAnchor.constraint(equalTo: label.trailingAnchor).isActive = true
            label.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
            label.text = " +\(listAsset.count - Int(numberItems - 1)) PHOTO "
            label.font = UIFont.systemFont(ofSize: fontSize13)
            imageView.bringSubview(toFront: label)
        }
        
        return imageView
    }
    
    private func config() {
        // add menu for this
        let imageView = UIImageView(frame: self.frame)
        imageView.tag = 0
        imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6)
        imageView.contentMode = .center
        imageView.isUserInteractionEnabled = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 3
        imageView.image = #imageLiteral(resourceName: "ic_add_photo").resizeImageWith(newSize: CGSize(width: 35, height: 35)).tint(with: #colorLiteral(red: 0.05098039216, green: 0.6392156863, blue: 0.07843137255, alpha: 1))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(touchImage(_:)))
        imageView.addGestureRecognizer(tap)
        listTapGesture.append(tap)
        
        stackImages.addArrangedSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let width = (UIScreen.main.bounds.size.width - 20  - (numberItems-CGFloat(1))*spacing) / numberItems
        imageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func loadNIb() {
        Bundle.main.loadNibNamed("AddPhotosView", owner: self, options: nil)
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    // MARK: - init
    override func awakeFromNib() {
        super.awakeFromNib()
        
        config()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNIb()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNIb()
    }
    
    // MARK: - closures
    
    // MARK: - properties
    var listAsset:[PHAsset] = []
    weak var controller:UIViewController?
    var listImages:[UIImage] = []
    var listTapGesture:[UITapGestureRecognizer] = []
    
    // MARK: - outlet
    @IBOutlet weak var view:UIView!
    @IBOutlet weak var stackImages: UIStackView!
    
}

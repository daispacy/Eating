//
//  PhotosLibraryController.swift
//  Eating
//
//  Created by Dai Pham on 3/15/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit
import Photos

class PhotosLibraryController: BasePresentController {

    // MARK: - api
    
    // MARK: - private
    private func config() {
        menuView.controller = self
        
        collectView.delegate = self
        collectView.dataSource = self
    }
    
    func loadPhotos() {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status
            {
            case .authorized:
                let fetchOptions = PHFetchOptions()
                let assets = PHAsset.fetchAssets(in: PHAssetCollection(), options: fetchOptions)
                let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                print("Found \(allPhotos.count) images")
            case .denied, .restricted:
                print("Not allowed")
            case .notDetermined:
                print("Not determined yet")
            }
        }
    }
    
    // MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    // MARK: - closures
    
    // MARK: - properties
    var listPhotos:[UIImage] = []
    
    // MARK: - outlet
    @IBOutlet weak var menuView: HeaderPresentControllerView!
    @IBOutlet weak var collectView: UICollectionView!
    
}

extension PhotosLibraryController:UICollectionViewDelegate,
    UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}


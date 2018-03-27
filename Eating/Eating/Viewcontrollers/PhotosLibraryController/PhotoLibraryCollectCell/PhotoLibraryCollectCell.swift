//
//  PhotoLibraryCollectCell.swift
//  Eating
//
//  Created by Dai Pham on 3/16/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit
import Photos

class PhotoLibraryCollectCell: UICollectionViewCell {

    // MARK: - api
    func load(url:String) {
        imageView.contentMode = .scaleAspectFill
        imageView.loadImageUsingCacheWithURLString(url)
    }
    
    func load(asset:PHAsset? = nil,_ isSelected:Bool = false) {
        if let asset = asset {
            imageView.contentMode = .scaleAspectFill
            asset.getImage(size: CGSize(width: 250, height: 250), {[weak self] (image) in
                guard let _self = self, let image = image else {return}
                _self.imageView.image = image
            })
        } else {
            imageView.contentMode = .center
            imageView.image = #imageLiteral(resourceName: "ic_camera").resizeImageWith(newSize: CGSize(width: 40, height: 40)).tint(with: #colorLiteral(red: 0.05098039216, green: 0.6392156863, blue: 0.07843137255, alpha: 1))
        }
        if isSelected {
            imageView.addMask(color: #colorLiteral(red: 0, green: 0.6745098039, blue: 0.9294117647, alpha: 1), 0.25, false)
        } else {
            imageView.removeMask()
        }
    }
    
    // MARK: - private
    private func config() {
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 3
    }
    
    // MARK: - init
    override func awakeFromNib() {
        super.awakeFromNib()
        
        config()
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        imageView.removeMask()
    }
    
    // MARK: - closures
    
    // MARK: - properties
    
    // MARK: - outlet
    @IBOutlet weak var imageView: UIImageView!
    
}

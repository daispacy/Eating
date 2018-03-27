//
//  GalleryView.swift
//  Eating
//
//  Created by Dai Pham on 3/26/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit
import Photos

class GalleryView: BaseUIView {

    // MARK: - api
    func load(url:String) {
        imageView.loadImageUsingCacheWithURLString(url)
    }
    
    func load(asset:PHAsset) {
        asset.getImage(size: UIScreen.main.bounds.size) {[weak self] image in
            guard let _self = self, let image = image else {return}
            _self.imageView.image = image
        }
    }
    
    // MARK: - action
    func touchButton(_ sender:UIButton) {
        if sender.isEqual(btnClose) {
            controller?.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - private
    override func config() {
        
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 2
        
        btnClose.addTarget(self, action: #selector(touchButton(_:)), for: .touchUpInside)
    }
    
    // MARK: - closures
    var onZoom:((CGFloat,UIView)->Void)?
    
    // MARK: - properties
    weak var controller:UIViewController?
    
    var _scale:CGFloat = 1
    var previousScale:CGFloat = 1
    
    // MARK: - outlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
}

extension GalleryView:UIScrollViewDelegate {
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        onZoom?(scrollView.zoomScale,self)
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        onZoom?(scale,self)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

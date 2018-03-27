//
//  GalleryController.swift
//  Eating
//
//  Created by Dai Pham on 3/26/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit
import Photos

class GalleryController: BasePresentController {

    // MARK: - api
    func load(data:[String]) {
        
    }
    
    func load(assets:[PHAsset]) {
        
    }
    
    func setViewFromIndex(index:Int) {
        var max = 0
        if listUrls.count > 0 {
            max = listUrls.count - 1
        } else if listAssets.count > 0 {
            max = listAssets.count - 1
        }
        
        if index < 0 || index > max {
            return
        }
        
        viewedIndex = index
        
        scrollView.scrollRectToVisible(CGRect(x: (scrollView.frame.size.width) * CGFloat(index + 1), y: scrollView.frame.size.height - 1, width: 1, height: 1), animated: false)
    }
    
    // MARK: - private
    private func config() {
        
        self.view.layoutIfNeeded()
        
        scrollView.delegate = self
        
        _ = stackGalleryView.arrangedSubviews.map{$0.removeFromSuperview()}
        if listUrls.count > 0 {
            for (i,url) in listUrls.enumerated() {
                let view = GalleryView(frame: self.view.frame)
                view.tag = i
                view.controller = self
                view.load(url: url)
                stackGalleryView.addArrangedSubview(view)
                view.translatesAutoresizingMaskIntoConstraints = false
                view.widthAnchor.constraint(equalToConstant: scrollView.frame.size.width).isActive = true
                view.onZoom = {[weak self] scale, galleryView in
                    guard let _self = self else {return}
                    _self.scrollView.isScrollEnabled = scale == 1
                }
            }
            
        } else if listAssets.count > 0 {
            for asset in listAssets {
                let view = GalleryView(frame: self.view.frame)
                view.controller = self
                view.load(asset: asset)
                stackGalleryView.addArrangedSubview(view)
                view.translatesAutoresizingMaskIntoConstraints = false
                view.widthAnchor.constraint(equalToConstant: scrollView.frame.size.width).isActive = true
            }
        }
    }
    
    // MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setViewFromIndex(index: viewedIndex)
        view.backgroundColor = UIColor.clear
        view.frame = startFrame
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.view.frame = UIScreen.main.bounds
        }, completion: nil)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.view.backgroundColor = UIColor.black
        }, completion: nil)
    }
    
    // MARK: - closures
    
    // MARK: - properties
    var listUrls:[String] = []
    var listAssets:[PHAsset] = []
    var viewedIndex:Int = 0
    var startFrame:CGRect = CGRect.zero
    
    // MARK: - outlet
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackGalleryView: UIStackView!
}

extension GalleryController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        _ = self.stackGalleryView.arrangedSubviews.map{($0 as! GalleryView).imageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)}
        (self.stackGalleryView.arrangedSubviews[self.viewedIndex] as! GalleryView).imageView.transform = .identity
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        viewedIndex = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        if viewedIndex < 0 {viewedIndex = 0}
        if viewedIndex > listUrls.count - 1 {viewedIndex = listUrls.count - 1}
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            _ = self.stackGalleryView.arrangedSubviews.map{($0 as! GalleryView).imageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)}
            (self.stackGalleryView.arrangedSubviews[self.viewedIndex] as! GalleryView).imageView.transform = .identity
        }, completion: nil)
    }
}

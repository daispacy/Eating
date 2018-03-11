//
//  SlideImageView.swift
//  Eating
//
//  Created by Dai Pham on 2/28/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class SlideImageView: UIView {

    // MARK: - api
    func load(data:Any? = nil) {
        if (data == nil) {
            loadFakeData()
        }
    }
    
    // MARK: - private
    private func config() {
        // add scrollview
        scrollView = UIScrollView(frame: bounds)
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        
        // add stackview
        stackImages = UIStackView(frame: bounds)
        stackImages.axis = .horizontal
        scrollView.addSubview(stackImages)
        stackImages.translatesAutoresizingMaskIntoConstraints = false
        stackImages.topAnchor.constraint(equalTo: stackImages.superview!.topAnchor, constant: 0).isActive = true
        stackImages.leadingAnchor.constraint(equalTo: stackImages.superview!.leadingAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: stackImages.bottomAnchor, constant: 0).isActive = true
        scrollView.heightAnchor.constraint(equalTo: stackImages.heightAnchor, multiplier: 1).isActive = true
        let trSI = stackImages.trailingAnchor.constraint(equalTo: stackImages.superview!.trailingAnchor)
        trSI.priority = 250
        stackImages.superview?.addConstraint(trSI)
    }
    
    private func loadFakeData() {
        for item in ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCde9ByZhZbfzmgC6dejFPA3uG4uwzhtKMylAIl6NPo8uuUn1UdA","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZ9S3o8jHYRrCRG_G1O7qLqKj3XI0nnZfdf-lhr0aiN6MHQbE1JQ","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSd6zlG1TTU-hKsQhvvImS7Je0kdc3u1DrafmaWSthxeDrqevGGzw"] {
            let imageView = UIImageView(frame: bounds)
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            imageView.loadImageUsingCacheWithURLString(item)
            stackImages.addArrangedSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height*25/100).isActive = true
        }
    }
    
    // MARK: - init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    // MARK: - closures
    
    // MARK: - properties
    
    // MARK: - outlet
    var scrollView:UIScrollView!
    var stackImages:UIStackView!
    

}

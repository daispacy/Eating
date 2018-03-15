//
//  BlockListImageSquardView.swift
//  Eating
//
//  Created by Dai Pham on 3/13/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

fileprivate let numberItems:CGFloat = UI_USER_INTERFACE_IDIOM() == .pad ? 8 : 4
fileprivate let spacing:CGFloat = 5

class BlockListImageSquardView: UIView {

    // MARK: - api
    func loadFakeImages() {
        
        self.layoutIfNeeded()
        self.setNeedsDisplay()
        for i in 0..<7 {
            if CGFloat(i) == numberItems {break}
            let imageV = imageMenu(url: ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCde9ByZhZbfzmgC6dejFPA3uG4uwzhtKMylAIl6NPo8uuUn1UdA","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZ9S3o8jHYRrCRG_G1O7qLqKj3XI0nnZfdf-lhr0aiN6MHQbE1JQ","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSd6zlG1TTU-hKsQhvvImS7Je0kdc3u1DrafmaWSthxeDrqevGGzw"].chooseOne, index: i, i == Int(numberItems - 1))
            stackImages.addArrangedSubview(imageV)
            imageV.translatesAutoresizingMaskIntoConstraints = false
            let width = (UIScreen.main.bounds.size.width - 20  - (numberItems-CGFloat(1))*spacing) / numberItems
            imageV.widthAnchor.constraint(equalToConstant: width).isActive = true
            imageV.heightAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
    
    // MARK: - action
    func touchImage(_ sender:UITapGestureRecognizer) {
        
    }
    
    // MARK: - private
    private func config() {
        
    }
    
    private func imageMenu(url:String,index:Int ,_ isShowMore:Bool = false) -> UIImageView{
        let imageView = UIImageView(frame: self.frame)
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 3
        imageView.loadImageUsingCacheWithURLString(url,
                                                   size: nil,
                                                   placeHolder: nil, false) {[weak self] (image) in
                                                    guard let _self = self, let img = image else {return}
                                                    _self.listImages.append(img)
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
            label.text = " +6 PHOTO "
            label.font = UIFont.systemFont(ofSize: fontSize13)
            imageView.bringSubview(toFront: label)
        }
        
        return imageView
    }

    // MARK: - init
    override func awakeFromNib() {
        super.awakeFromNib()
        
        config()
    }
    
    // MARK: - closures
    
    // MARK: - properties
    var listImages:[UIImage] = []
    var listTapGesture:[UITapGestureRecognizer] = []
    
    // MARK: - outlet
    @IBOutlet weak var stackImages: UIStackView!
    
}

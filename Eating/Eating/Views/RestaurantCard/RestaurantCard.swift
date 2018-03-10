//
//  RestaurantCard.swift
//  Eating
//
//  Created by Dai Pham on 2/27/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class RestaurantCard: UIView {

    // MARK: - api
    func load(data:Any? = nil) {
        guard (data != nil) else {
            loadFakeData()
            return
        }
    }
    
    // MARK: - action
    func touchDown(_ sender:UIButton) {
        shouldActionEventTouchInside = false
        if isAnimationing {
            return
        }
        isAnimationing = true
        UIView.animate(withDuration: 0.25, delay: 0,
                       options: .allowUserInteraction,
                       animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: {finished in
            self.isAnimationing = false
            if self.shouldActionEventTouchInside {
                self.onTouchCard?(nil)
                UIView.animate(withDuration: 0.25, delay: 0,
                               options: .allowUserInteraction,
                               animations: {
                                self.transform = .identity
                }, completion: nil)
            }
        })
    }
    
    func touchUpInside(_ sender:UIButton) {
       shouldActionEventTouchInside = true
        if isAnimationing {
//            self.transform = .identity
        } else {
            self.onTouchCard?(nil)
            UIView.animate(withDuration: 0.25, delay: 0,
                           options: .allowUserInteraction,
                           animations: {
                            self.transform = .identity
            }, completion: nil)
        }
    }
    
    func touchUpOutSide(_ sender:UIButton) {
        print("outside")
        isAnimationing = true
        UIView.animate(withDuration: 0.25, delay: 0,
                       options: .allowUserInteraction,
                       animations: {
                        self.transform = .identity
        }, completion: {finisehd in
            self.isAnimationing = false
        })
    }
    
    // MARK: - private
    private func config() {
        
        layer.cornerRadius  = Restaurant_Card_Radius
        layer.shadowColor   = Restaurant_Card_Shadow_Color
        layer.shadowOffset  = Restaurant_Card_Shadow_Offset
        layer.shadowOpacity = Restaurant_Card_Shadow_Opacity
        layer.shadowRadius  = Restaurant_Card_Shadow_Radius
        
        lblTitle.font = Restaurant_Card_Title_Font
        lblTitle.textColor = Restaurant_Card_Title_TextColor
        
        lblSubtitle.font = Restaurant_Card_Subtitle_Font
        lblSubtitle.textColor = Restaurant_Card_Subtitle_TextColor
        
        lblRate.font = Restaurant_Card_Rate_Font
        lblRate.textColor = Restaurant_Card_Rate_TextColor
        
        lblRate.backgroundColor = Restaurant_Card_Rate_BG_Colors.chooseOne.values.first as? UIColor
        
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = UIColor.clear
        
        btnAction.addTarget(self, action: #selector(touchDown(_:)), for: .touchDown)
        btnAction.addTarget(self, action: #selector(touchUpInside(_:)), for: .touchUpInside)
        btnAction.addTarget(self, action: #selector(touchUpOutSide(_:)), for: .touchDragOutside)
    }
    
    private func loadFakeData() {
        lblTitle.text = ["RuxBin","Pequod's Pizza","vai ca lon","oi cai dit con me"].chooseOne
        lblSubtitle.text = ["WEST TOWN, CHICAGO New American"].chooseOne
        imageView.loadImageUsingCacheWithURLString(["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCde9ByZhZbfzmgC6dejFPA3uG4uwzhtKMylAIl6NPo8uuUn1UdA","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZ9S3o8jHYRrCRG_G1O7qLqKj3XI0nnZfdf-lhr0aiN6MHQbE1JQ","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSd6zlG1TTU-hKsQhvvImS7Je0kdc3u1DrafmaWSthxeDrqevGGzw"].chooseOne)
    }
    
    // MARK: - init
    override func awakeFromNib() {
        super.awakeFromNib()
        
        config()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.roundCorners(corners: [.topLeft, .topRight], radius: Restaurant_Card_Radius)
        blurView.roundCorners(corners: [.topLeft, .topRight], radius: Restaurant_Card_Radius)
    }
    
    // MARK: - closures
    var onTouchCard:((Any?)->Void)?
    
    // MARK: - properties
    var shouldActionEventTouchInside:Bool = false
    var isAnimationing:Bool = false
    
    // MARK: - outlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var btnAction: UIButton!
    @IBOutlet weak var blurView: UIView!
}

//
//  DetailsRestaurantView.swift
//  Eating
//
//  Created by Dai Pham on 3/13/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class DetailsRestaurantView: UIView {

    // MARK: - api
    
    // MARK: - private
    private func config() {
        lblTitle.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lblTitle.font = UIFont.boldSystemFont(ofSize: fontSize18)
        
        lblCall.textColor = #colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6156862745, alpha: 1)
        lblCall.font = UIFont.systemFont(ofSize: fontSize13)
        
        lblTextAdress.textColor = #colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6156862745, alpha: 1)
        lblTextAdress.font = UIFont.systemFont(ofSize: fontSize13)
        
        btnPhone.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize16)
        btnPhone.setTitleColor(#colorLiteral(red: 0.05098039216, green: 0.6392156863, blue: 0.07843137255, alpha: 1), for: UIControlState())
        
        lblAddress.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lblAddress.font = UIFont.systemFont(ofSize: fontSize14)
        lblAddress.numberOfLines = 0
        
        btnCall.layer.masksToBounds = true
        btnCall.layer.cornerRadius = min(btnCall.frame.size.height,btnCall.frame.size.width)/2
        btnCall.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.6392156863, blue: 0.07843137255, alpha: 1)
        btnCall.setImage(#imageLiteral(resourceName: "ic_call").resizeImageWith(newSize: CGSize(width: 20, height: 20)).tint(with: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), for: UIControlState())
        
        btnDirection.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize15)
        btnDirection.setTitleColor(#colorLiteral(red: 0.05098039216, green: 0.6392156863, blue: 0.07843137255, alpha: 1), for: UIControlState())
    }
    
    // MARK: - init
    override func awakeFromNib() {
        super.awakeFromNib()
        
        config()
    }
    
    // MARK: - closures
    
    // MARK: - properties
    
    // MARK: - outlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCall: UILabel!
    @IBOutlet weak var btnPhone: UIButton!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var lblTextAdress: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var btnDirection: UIButton!
    
}

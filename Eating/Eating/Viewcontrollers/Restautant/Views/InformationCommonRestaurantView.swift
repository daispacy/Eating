//
//  InformationCommonRestaurantView.swift
//  Eating
//
//  Created by Dai Pham on 3/10/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class InformationCommonRestaurantView: UIView {

    // MARK: - api
    func load(data:Any?) {
        
    }
    
    // MARK: - private
    private func config() {
        lblName.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lblName.font = UIFont.boldSystemFont(ofSize: fontSize20)
        
        lblRate.font = Restaurant_Card_Rate_Font
        lblRate.textColor = Restaurant_Card_Rate_TextColor
        
        lblRate.backgroundColor = Restaurant_Card_Rate_BG_Colors.chooseOne.values.first as? UIColor
        
        lblCuisine.textColor = #colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6156862745, alpha: 1)
        lblCuisine.font = UIFont.systemFont(ofSize: fontSize16)
        
        lblStatus.textColor = #colorLiteral(red: 0.8862745098, green: 0.2156862745, blue: 0.2666666667, alpha: 1)
        lblStatus.font = UIFont.systemFont(ofSize: fontSize16)
        
        btnOpenHours.titleLabel?.font = UIFont.systemFont(ofSize: fontSize16)
        btnOpenHours.setTitleColor(#colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6156862745, alpha: 1), for: UIControlState())
        btnOpenHours.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10)
        btnOpenHours.setImage(#imageLiteral(resourceName: "arrow_down").resizeImageWith(newSize: CGSize(width: 15, height: 15)).tint(with: #colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6156862745, alpha: 1)), for: UIControlState())
        
        lblOpenMap.attributedText = getAttributeUnderline(text: "map".localized().capitalizingFirstLetter())
        lblOpenPhotos.attributedText = getAttributeUnderline(text: "50 Photos".localized().capitalizingFirstLetter())
        lblOpenReviews.attributedText = getAttributeUnderline(text: "17 Reviews".localized().capitalizingFirstLetter())
        
        vwBottomLine.backgroundColor = #colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6156862745, alpha: 0.1408450704)
    }
    
    private func getAttributeUnderline(text:String)->NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.patternDash.rawValue | NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttributes([NSUnderlineColorAttributeName:#colorLiteral(red: 0.05098039216, green: 0.6392156863, blue: 0.07843137255, alpha: 1),NSFontAttributeName:UIFont.boldSystemFont(ofSize: fontSize16),NSForegroundColorAttributeName:#colorLiteral(red: 0.05098039216, green: 0.6392156863, blue: 0.07843137255, alpha: 1),NSBackgroundColorAttributeName:UIColor.white], range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
    
    // MARK: - init
    override func awakeFromNib() {
        super.awakeFromNib()
        
        config()
    }
    
    // MARK: - closures
    
    // MARK: - properties
    weak var controller:UIViewController?
    
    // MARK: - outlet
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblCuisine: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var btnOpenHours: UIButton!
    @IBOutlet weak var lblOpenMap: UILabel!
    @IBOutlet weak var lblOpenReviews: UILabel!
    @IBOutlet weak var lblOpenPhotos: UILabel!
    @IBOutlet weak var vwBottomLine: UIView!
    
}

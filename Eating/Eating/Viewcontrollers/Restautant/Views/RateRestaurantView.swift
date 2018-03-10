//
//  RateRestaurantView.swift
//  Eating
//
//  Created by Dai Pham on 3/11/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class RateRestaurantView: UIView {

    // MARK: - api
    
    // MARK: - action
    func touchButton(_ sender:UIButton) {
        if sender.isEqual(btnReset) {
            sender.startAnimation(activityIndicatorStyle: .gray)
            if sender.isSelected {
                // cal api reset rate restaurant then
                // reset state for all button
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: {timer in
                    sender.stopAnimation()
                    sender.isSelected = false
                    for button in self.stackRates.arrangedSubviews {
                        if let button = button as? UIButton {
                            let borderColor = #colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6156862745, alpha: 1).cgColor
                            let titleColor = #colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6156862745, alpha: 1)
                            let backgroundColor = UIColor.white
                            let image = #imageLiteral(resourceName: "star").tint(with: #colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6156862745, alpha: 1)).resizeImageWith(newSize: CGSize(width: 12, height: 12))
                            button.setTitleColor(titleColor, for: .selected)
                            button.layer.borderColor = borderColor
                            button.backgroundColor = backgroundColor
                            button.setImage(image, for: .selected)
                            button.isSelected = false
                            self.btnAddReview.isHidden = true
                            self.lblCongrateRate.isHidden = true
                        }
                    }
                })
            } else {
                // call api rate then set isSelected for btnReset
                // fake request
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: {timer in
                    sender.stopAnimation()
                    sender.isSelected = true
                    self.btnAddReview.isHidden = false
                    self.lblCongrateRate.isHidden = false
                })
            }
        }
    }
    
    func touchRate(_ sender:UIButton) {
        let star = sender.tag
        var shouldSave = false
        for (i,button) in stackRates.arrangedSubviews.enumerated() {
            if let button = button as? UIButton {
                var selected = false
                var borderColor = #colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6156862745, alpha: 1).cgColor
                var titleColor = #colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6156862745, alpha: 1)
                var backgroundColor = UIColor.white
                var image = #imageLiteral(resourceName: "star").tint(with: #colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6156862745, alpha: 1)).resizeImageWith(newSize: CGSize(width: 12, height: 12))
                
                if button.tag <= star {
                    let index = star - 1
                    if index < 0 || index > Restaurant_Card_Rate_BG_Colors.count - 1 {return}
                    let js = Restaurant_Card_Rate_BG_Colors[index]
                    if let color = js.values.first as? UIColor{
                        borderColor = color.cgColor
                        backgroundColor = color.withAlphaComponent(0.2)
                        titleColor = color
                        image = #imageLiteral(resourceName: "star").tint(with: color).resizeImageWith(newSize: CGSize(width: 12, height: 12))
                        selected = true
                    }
                }
                
                button.setTitleColor(titleColor, for: .selected)
                button.layer.borderColor = borderColor
                button.backgroundColor = backgroundColor
                button.setImage(image, for: .selected)
                button.isSelected = selected
                if i == stackRates.arrangedSubviews.count - 1 {shouldSave = true}
            }
        }
        
        if shouldSave {
            // virtual touch button reset
            btnReset.isSelected = false
            touchButton(btnReset)
        }
    }
    
    // MARK: - private
    private func config() {
        lblTitle.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lblTitle.font = UIFont.boldSystemFont(ofSize: fontSize18)
        
        for (i,button) in stackRates.arrangedSubviews.enumerated() {
            if let button = button as? UIButton {
                button.tag = i + 1
                button.setImage(#imageLiteral(resourceName: "star").tint(with: #colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6156862745, alpha: 1)).resizeImageWith(newSize: CGSize(width: 12, height: 12)), for: .normal)
                button.setImage(#imageLiteral(resourceName: "star").tint(with: #colorLiteral(red: 0.05098039216, green: 0.6392156863, blue: 0.07843137255, alpha: 1)).resizeImageWith(newSize: CGSize(width: 12, height: 12)), for: .selected)
                
                button.setTitleColor(#colorLiteral(red: 0.05098039216, green: 0.6392156863, blue: 0.07843137255, alpha: 1), for: .selected)
                button.setTitleColor(#colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6156862745, alpha: 1), for: .normal)
                
                button.setTitle("\(button.tag)", for: UIControlState())
                
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize16)
                
                button.layer.cornerRadius = button.frame.size.height/2
                button.layer.borderWidth = 2
                button.layer.borderColor = #colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6156862745, alpha: 1)
                
                button.addTarget(self, action: #selector(touchRate(_:)), for: .touchUpInside)
            }
        }
        
        lblCongrateRate.textColor = #colorLiteral(red: 0.09019607843, green: 0.1921568627, blue: 0.2588235294, alpha: 1)
        lblCongrateRate.font = UIFont.systemFont(ofSize: fontSize16)
        lblCongrateRate.isHidden = true
        
        btnAddReview.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize16)
        btnAddReview.setTitleColor(#colorLiteral(red: 0.05098039216, green: 0.6392156863, blue: 0.07843137255, alpha: 1), for: UIControlState())
        
        btnReset.titleLabel?.font = UIFont.systemFont(ofSize: fontSize13)
        btnReset.setTitle("reset".localized().uppercased(), for: .selected)
        btnReset.setTitle("   ".localized().uppercased(), for: .normal)
        btnReset.setTitleColor(UIColor.clear, for: .normal)
        btnReset.setTitleColor(#colorLiteral(red: 0.9176470588, green: 0.1764705882, blue: 0.1411764706, alpha: 1), for: .selected)
        
        btnAddReview.addTarget(self, action: #selector(touchButton(_:)), for: .touchUpInside)
        btnAddReview.isHidden = true
        
        btnReset.addTarget(self, action: #selector(touchButton(_:)), for: .touchUpInside)
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
    @IBOutlet weak var stackRates: UIStackView!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var lblCongrateRate: UILabel!
    @IBOutlet weak var btnAddReview: UIButton!
    
}

//
//  RateRestaurantView.swift
//  Eating
//
//  Created by Dai Pham on 3/11/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

enum RateRestaurantType {
    case lite
    case full
}

protocol RateRestaurantViewDelegate: class {
    func rateRestaurant(assign view:RateRestaurantView)
}

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
                    self.star = 0
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
                            self.setState()
                        }
                    }
                })
            } else {
                // call api rate then set isSelected for btnReset
                // fake request
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: {timer in
                    sender.stopAnimation()
                    sender.isSelected = true
                    self.setState()
                })
            }
        } else if sender.isEqual(btnAddReview) {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "writeReview") as! WriteReviewController
            vc.rateRestaurantView = self
            controller?.navigationController?.present(vc, animated: true, completion: nil)
            vc.onDissmiss = {[weak self] in
                guard let _self = self else {return}
                _self.delegate?.rateRestaurant(assign: _self)
            }
        }
    }
    
    func touchRate(_ sender:UIButton) {
        star = sender.tag
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
    private func setState() {
        if type == .lite {return}
        UIView.animate(withDuration: 0.1, animations: {
            self.btnAddReview.isHidden = !self.btnReset.isSelected
            self.lblCongrateRate.isHidden =  !self.btnReset.isSelected
            self.lblTitle.text = !self.btnReset.isSelected ? "Rate this place" : "Your rate!"
        }, completion: nil)
    }
    
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
    
    private func changeType() {
        lblTitle.isHidden = type == .lite
        leadingConstrant.constant = type == .lite ? 0 : 10
        trailingConstrant.constant = type == .lite ? 0 : 10
        
        if type == .lite {
            btnAddReview.isHidden = true
            lblCongrateRate.isHidden = true
        } else {
            btnAddReview.isHidden = star == 0
            lblCongrateRate.isHidden = star == 0
        }
    }
    
    // MARK: - init
    override func awakeFromNib() {
        super.awakeFromNib()
        
        config()
    }
    
    // MARK: - closures
    
    // MARK: - properties
    var star:Int = 0
    weak var delegate:RateRestaurantViewDelegate?
    weak var controller:UIViewController?
    var type:RateRestaurantType = .full {
        didSet {
            changeType()
        }
    }
    
    // MARK: - outlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var stackRates: UIStackView!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var lblCongrateRate: UILabel!
    @IBOutlet weak var btnAddReview: UIButton!
    
    // MARK: - Constraint
    @IBOutlet weak var trailingConstrant: NSLayoutConstraint!
    @IBOutlet weak var leadingConstrant: NSLayoutConstraint!
}

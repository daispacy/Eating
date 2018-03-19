//
//  ReviewsRestaurantView.swift
//  Eating
//
//  Created by Dai Pham on 3/13/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class ReviewsRestaurantView: UIView {

    // MARK: - api
    
    // MARK: - action
    func touchButton(_ sender:UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "reviewsManager") as! ReviewsManagerController
        controller?.present(vc, animated: true, completion: nil)
    }
    
    // MARK: - private
    private func config() {
        lblTitle.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lblTitle.font = UIFont.boldSystemFont(ofSize: fontSize18)
        
        btnReadAllOne.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize15)
        btnReadAllOne.setTitleColor(#colorLiteral(red: 0.05098039216, green: 0.6392156863, blue: 0.07843137255, alpha: 1), for: UIControlState())
        
        btnReadAllTwo.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize15)
        btnReadAllTwo.setTitleColor(#colorLiteral(red: 0.05098039216, green: 0.6392156863, blue: 0.07843137255, alpha: 1), for: UIControlState())
        
        for _ in 0..<2 {
            let view = BlockReviewView()
            stackReviews.addArrangedSubview(view)
        }
        
        btnReadAllOne.addTarget(self, action: #selector(touchButton(_:)), for: .touchUpInside)
        btnReadAllTwo.addTarget(self, action: #selector(touchButton(_:)), for: .touchUpInside)
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
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnReadAllOne: UIButton!
    @IBOutlet weak var btnReadAllTwo: UIButton!
    @IBOutlet weak var stackReviews: UIStackView!
    
}

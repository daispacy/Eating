//
//  OtherRestaurantsView.swift
//  Eating
//
//  Created by Dai Pham on 3/13/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class OtherRestaurantsView: UIView {

    // MARK: - api
    
    // MARK: - private
    private func config() {
        lblTitle.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lblTitle.font = UIFont.boldSystemFont(ofSize: fontSize18)
        
        btnSeeAll.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize15)
        btnSeeAll.setTitleColor(#colorLiteral(red: 0.05098039216, green: 0.6392156863, blue: 0.07843137255, alpha: 1), for: UIControlState())
    }
    
    private func loadFakeData() {
        for _ in 0..<5 {
            let view = Bundle.main.loadNibNamed("BlockNameRestaurantView", owner: self, options: nil)?.first as! BlockNameRestaurantView
            stackContainer.addArrangedSubview(view)
        }
    }
    
    // MARK: - init
    override func awakeFromNib() {
        super.awakeFromNib()
        
        config()
        loadFakeData()
    }
    
    // MARK: - closures
    
    // MARK: - properties
    
    // MARK: - outlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var stackContainer: UIStackView!
    @IBOutlet weak var btnSeeAll: UIButton!
    
}

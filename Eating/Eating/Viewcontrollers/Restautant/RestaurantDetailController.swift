//
//  RestaurantDetailController.swift
//  Eating
//
//  Created by Dai Pham on 2/25/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class RestaurantDetailController: UIViewController {

    // MARK: - api
    
    // MARK: - private
    private func config() {
        // add InformationCommonRestaurantView
        informationCommonView = Bundle.main.loadNibNamed("InformationCommonRestaurantView", owner: self, options: nil)?.first as! InformationCommonRestaurantView
        stackContainer.addArrangedSubview(informationCommonView)
        
        // add rate restaurant view
        rateRestaurantView = Bundle.main.loadNibNamed("RateRestaurantView", owner: self, options: nil)?.first as! RateRestaurantView
        stackContainer.addArrangedSubview(rateRestaurantView)
        
    }
    
    // MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slideImageView.load()
        
        config()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - closures
    
    // MARK: - properties
    var blurView: UIVisualEffectView!
    var informationCommonView:InformationCommonRestaurantView! // load name, address, openhours of restaurant
    var rateRestaurantView:RateRestaurantView! // load rate restaurant
    
    // MARK: - outlet
    @IBOutlet weak var slideImageView: SlideImageView!
    @IBOutlet weak var stackContainer: UIStackView!
    
}

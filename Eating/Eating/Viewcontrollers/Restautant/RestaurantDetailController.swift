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
        
        // add menu restaurant view
        menuRestaurant = Bundle.main.loadNibNamed("MenuRestaurantView", owner: self, options: nil)?.first as! MenuRestaurantView
        stackContainer.addArrangedSubview(menuRestaurant)
        menuRestaurant.loadFakeImages()
        
        // add menu restaurant view
        imageRestaurant = Bundle.main.loadNibNamed("ImageRestaurantView", owner: self, options: nil)?.first as! ImageRestaurantView
        stackContainer.addArrangedSubview(imageRestaurant)
        imageRestaurant.loadFakeImages()
        
        // add details restaurant view
        detailsRestaurant = Bundle.main.loadNibNamed("DetailsRestaurantView", owner: self, options: nil)?.first as! DetailsRestaurantView
        stackContainer.addArrangedSubview(detailsRestaurant)
        
        // add reviews restaurant view
        reviewsRestaurant = Bundle.main.loadNibNamed("ReviewsRestaurantView", owner: self, options: nil)?.first as! ReviewsRestaurantView
        stackContainer.addArrangedSubview(reviewsRestaurant)
        
        // add reviews restaurant view
        otherRestaurant = Bundle.main.loadNibNamed("OtherRestaurantsView", owner: self, options: nil)?.first as! OtherRestaurantsView
        stackContainer.addArrangedSubview(otherRestaurant)
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
    var menuRestaurant:MenuRestaurantView! // load menus image restaurant
    var imageRestaurant:ImageRestaurantView! // load photos restaurant
    var detailsRestaurant:DetailsRestaurantView! // load details restaurant
    var reviewsRestaurant:ReviewsRestaurantView! // load reviews restaurant
    var otherRestaurant:OtherRestaurantsView! // load other restaurants
    
    // MARK: - outlet
    @IBOutlet weak var slideImageView: SlideImageView!
    @IBOutlet weak var stackContainer: UIStackView!
    
}

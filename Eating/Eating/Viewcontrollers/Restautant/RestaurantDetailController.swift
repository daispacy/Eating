//
//  RestaurantDetailController.swift
//  Eating
//
//  Created by Dai Pham on 2/25/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class RestaurantDetailController: BaseController {

    // MARK: - api
    
    // MARK: - private
    private func config() {
        // add InformationCommonRestaurantView
        informationCommonView = Bundle.main.loadNibNamed("InformationCommonRestaurantView", owner: self, options: nil)?.first as! InformationCommonRestaurantView
        stackContainer.addArrangedSubview(informationCommonView)
        
        // add rate restaurant view
        rateRestaurantView = Bundle.main.loadNibNamed("RateRestaurantView", owner: self, options: nil)?.first as! RateRestaurantView
        rateRestaurantView.controller = self
        rateRestaurantView.delegate = self
        stackContainer.addArrangedSubview(rateRestaurantView)
        
        // add menu restaurant view
        menuRestaurant = Bundle.main.loadNibNamed("MenuRestaurantView", owner: self, options: nil)?.first as! MenuRestaurantView
        stackContainer.addArrangedSubview(menuRestaurant)
        menuRestaurant.loadFakeImages()

        // add menu restaurant view
        imageRestaurant = Bundle.main.loadNibNamed("ImageRestaurantView", owner: self, options: nil)?.first as! ImageRestaurantView
        imageRestaurant.controller = self
        stackContainer.addArrangedSubview(imageRestaurant)
        imageRestaurant.loadFakeImages()

        // add details restaurant view
        detailsRestaurant = Bundle.main.loadNibNamed("DetailsRestaurantView", owner: self, options: nil)?.first as! DetailsRestaurantView
        stackContainer.addArrangedSubview(detailsRestaurant)

        // add reviews restaurant view
        reviewsRestaurant = Bundle.main.loadNibNamed("ReviewsRestaurantView", owner: self, options: nil)?.first as! ReviewsRestaurantView
        reviewsRestaurant.controller = self
        stackContainer.addArrangedSubview(reviewsRestaurant)

        // add restaurant view
        otherRestaurant = OtherRestaurantsView(frame:view.bounds)
        otherRestaurant.controller = self
        otherRestaurant.delegate = self
        stackContainer.addArrangedSubview(otherRestaurant)
    }
    
    // MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarController?.tabBar.isHidden = true
        
        slideImageView.load()
        
        config()
    }
    
    deinit {
        print(NSStringFromClass(RestaurantDetailController.self) + " dealloc")
        tabBarController?.tabBar.isHidden = false
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

// MARK: -
extension RestaurantDetailController:RateRestaurantViewDelegate {
    func rateRestaurant(assign view: RateRestaurantView) {
        rateRestaurantView = view
        rateRestaurantView.type = .full
        rateRestaurantView.controller = self
        rateRestaurantView.delegate = self
        stackContainer.insertArrangedSubview(rateRestaurantView, at: 2)
    }
}

// MARK: -
extension RestaurantDetailController:OtherRestaurantsViewDelegate {
    func otherRestaurantsView(assign view: OtherRestaurantsView) {
        otherRestaurant = view
        otherRestaurant.type = .lite
        otherRestaurant.controller = self
        otherRestaurant.delegate = self
        stackContainer.addArrangedSubview(rateRestaurantView)
    }
}

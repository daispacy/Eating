//
//  RecentViewedRestaurantListController.swift
//  Eating
//
//  Created by Dai Pham on 3/19/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class RecentViewedRestaurantListController: BaseController {

    // MARK: - api
    
    // MARK: - private
    private func config() {
        // list all
        otherRestaurantView.type = .full
        
        // mark to pop
        menuHeader.controller = self
        menuHeader.isPresent = false
        
        scrollView.delegate = self
    }
    
    // MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    // MARK: - closures
    
    // MARK: - properties
    
    // MARK: - outlet
    @IBOutlet weak var otherRestaurantView: OtherRestaurantsView!
    @IBOutlet weak var menuHeader: HeaderPresentControllerView!
    @IBOutlet weak var scrollView: UIScrollView!
    
}

// MARK: -
extension RecentViewedRestaurantListController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // hide/show bottom line on header controller
        menuHeader.effect(with: scrollView)
    }
}

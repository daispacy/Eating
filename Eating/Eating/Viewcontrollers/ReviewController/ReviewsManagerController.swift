//
//  ReviewsListController.swift
//  Eating
//
//  Created by Dai Pham on 3/19/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class ReviewsManagerController: BasePresentController {

    // MARK: - api
    
    // MARK: - private
    private func config() {
        
        // set delegate for controls
        scrollView.delegate = self

        // set controller for custom view
        vwHeader.controller = self

        // add name restaurant view
        
        
        // listern event tabbar Slider
        tabbarMenuSlide.onSelectIndex = {[weak self] index in
            guard let _self = self else {return}
            _self.scrollView.scrollRectToVisible(CGRect(origin: CGPoint(x: CGFloat(index) * _self.scrollView.frame.size.width, y: 0), size: _self.scrollView.frame.size), animated: true)
        }
        
        self.view.layoutIfNeeded()
        // add reviews list
        var listMenu:[String] = []
        for _ in 0..<5 {
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "reviewsList") as! ReviewsListController
            addChildViewController(vc)
            stackContainer.addArrangedSubview(vc.view)
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            vc.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1).isActive = true
//            vc.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1).isActive = true
            listMenu.append("testtestts")
        }
        tabbarMenuSlide.load(data: listMenu)
        
    }
    
    // MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    // MARK: - closures
    
    // MARK: - properties
    var currentOffset:CGFloat = 0
    
    // MARK: - outlet
    
    @IBOutlet weak var vwHeaderRestaurantView: HeaderRestaurantView!
    @IBOutlet weak var vwHeader: HeaderPresentControllerView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackContainer: UIStackView!
    @IBOutlet weak var tabbarMenuSlide: TabbarMenuSlider!
}

// MARK: -
extension ReviewsManagerController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tabbarMenuSlide == nil {return}
        
        tabbarMenuSlide.scrollDidView(scrollView)
        currentOffset = scrollView.contentOffset.x
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > 0 {
            tabbarMenuSlide.selectIndex(Int(scrollView.contentOffset.x/scrollView.frame.size.width))
        } else {
            tabbarMenuSlide.selectIndex(0)
        }
    }
}


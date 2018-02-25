//
//  HomeController.swift
//  Eating
//
//  Created by Dai Pham on 2/25/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class HomeController: BaseController {

    // MARK: - api
    
    // MARK: - private
    
    // MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        iconTest.addEvent {
            let vc = RestaurantDetailController(nibName: "RestaurantDetailController", bundle: Bundle.main)
            transitionThumbnail = iconTest
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        iconTest.removeEvent()
    }
    
    // MARK: - closures
    
    // MARK: - properties
    var thumbnailZoomTransitionAnimator: PushZoomTransitionAnimator?
    var transitionThumbnail: UIImageView?
    
    // MARK: - outlet
    @IBOutlet weak var iconTest: UIImageView!
}

extension HomeController: UINavigationControllerDelegate {
   
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            // Pass the thumbnail frame to the transition animator.
            guard let transitionThumbnail = transitionThumbnail, let transitionThumbnailSuperview = transitionThumbnail.superview else { return nil }
            thumbnailZoomTransitionAnimator = PushZoomTransitionAnimator()
            thumbnailZoomTransitionAnimator?.thumbnailFrame = transitionThumbnailSuperview.convert(transitionThumbnail.frame, to: nil)
        }
        thumbnailZoomTransitionAnimator?.operation = operation
        
        return thumbnailZoomTransitionAnimator
    }
}

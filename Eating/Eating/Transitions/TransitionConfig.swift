//
//  TransitionDeleage.swift
//  Eating
//
//  Created by Dai Pham on 4/21/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

protocol TransitionDelegate:class {
    func animateTransition(via transitionContext: UIViewControllerContextTransitioning,type:AnimatedTransitioning.TransitionType)
    func transitionEnd(end:Bool)
}

class TransitionConfig: NSObject, UIViewControllerTransitioningDelegate {
    /// Interaction controller
    ///
    /// If gesture triggers transition, it will set will manage its own
    /// `UIPercentDrivenInteractiveTransition`, but it must set this
    /// reference to that interaction controller here, so that this
    /// knows whether it's interactive or not.
    
    override init() {
        super.init()
        trasitioning.delegate = self
    }
    
    // MARK: - action
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        trasitioning.transitionType = .presenting
        return trasitioning
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        trasitioning.transitionType = .dismissing
        return trasitioning
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }
    
    // MARK: - properties
    weak var interactionController: UIPercentDrivenInteractiveTransition?
    weak var delegate:TransitionDelegate?
    var trasitioning:AnimatedTransitioning = AnimatedTransitioning(transitionType: .presenting)
}

extension TransitionConfig:TransitionDelegate {
    func animateTransition(via transitionContext: UIViewControllerContextTransitioning, type: AnimatedTransitioning.TransitionType) {
        delegate?.animateTransition(via: transitionContext, type: type)
    }
    
    func transitionEnd(end: Bool) {
        delegate?.transitionEnd(end: end)
    }
}

class PresentationController: UIPresentationController {
    override var shouldRemovePresentersView: Bool { return true }
}

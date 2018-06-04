//
//  PulldownTransition.swift
//  Eating
//
//  Created by Dai Pham on 4/21/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class AnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {

    enum TransitionType {
        case presenting
        case dismissing
    }
    
    // MARK: - override
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let inView   = transitionContext.containerView
        let toView   = transitionContext.view(forKey: .to)!

        let fromView = transitionContext.view(forKey: .from)!
        let frame = inView.bounds
        
        switch transitionType {
        case .presenting:
            toView.frame = frame
            toView.insertSubview(fromView.snapshotView(afterScreenUpdates: true)!, at: 0) // make background toview from fromview
            inView.addSubview(toView)
        case .dismissing:
            toView.frame = frame
            inView.insertSubview(toView, belowSubview: fromView)
        }
        delegate?.animateTransition(via: transitionContext, type: transitionType)
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        delegate?.transitionEnd(end: transitionCompleted)
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    // MARK: - init
    init(transitionType: TransitionType) {
        self.transitionType = transitionType
        
        super.init()
    }
    
    // MARK: - properties
    var transitionType: TransitionType = .presenting
    weak var delegate:TransitionDelegate?
}

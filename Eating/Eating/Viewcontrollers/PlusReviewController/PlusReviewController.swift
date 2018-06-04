//
//  PlusReviewController.swift
//  Eating
//
//  Created by Dai Pham on 4/1/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class PlusReviewController: UIViewController {

    // MARK: - api
    
    // MARK: - action
    func touchButton(_ sender:UIButton) {
        
        btnSelected = sender
        self.dismiss(animated: true, completion: nil)
    }
    
    func touchVWBG(_ gesture:UITapGestureRecognizer) {
        startAnimationShow(isShow: false) {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    // MARK: - private
    func handleGesture(_ gesture: UIPanGestureRecognizer) {
        let translate = gesture.translation(in: gesture.view)
        let percent   = -translate.y / gesture.view!.bounds.size.height
        
        if gesture.state == .began {
            interactionController = UIPercentDrivenInteractiveTransition()
            customTransitionDelegate.interactionController = interactionController
            
            dismiss(animated: true)
        } else if gesture.state == .changed {
            interactionController?.update(percent)
        } else if gesture.state == .ended || gesture.state == .cancelled {
//            let velocity = gesture.velocity(in: gesture.view)
            interactionController?.completionSpeed = 0.999  // https://stackoverflow.com/a/42972283/1271826
            if percent > 0.4 {
                interactionController?.finish()
            } else {
                interactionController?.cancel()
                resetStateView()
            }
            interactionController = nil
        }
    }
    
    private func config() {
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
//        panDown.delegate = self
        view.addGestureRecognizer(panGesture)
        
        self.vwBlur.backgroundColor = UIColor.clear
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchVWBG(_:)))
        vwBlur.addGestureRecognizer(tapGesture)
        
        vwContainer.bringSubview(toFront: btnClose)
        
        btnClose.layer.masksToBounds = false
        btnClose.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        btnClose.layer.shadowOffset = CGSize(width:-0.1, height:0.1)
        btnClose.layer.shadowOpacity = 1
        btnClose.layer.shadowRadius = 2
        btnClose.layer.cornerRadius = btnClose.frame.size.width/2
        btnClose.setImage(#imageLiteral(resourceName: "ic_plus"), for: UIControlState())
        
        btnReview.setImage(#imageLiteral(resourceName: "star_line").resizeImageWith(newSize: CGSize(width: 20, height: 20)).tint(with: #colorLiteral(red: 0.7843137255, green: 0.6745098039, blue: 0.2941176471, alpha: 1)), for: UIControlState())
        btnAddPhoto.setImage(#imageLiteral(resourceName: "ic_camera").resizeImageWith(newSize: CGSize(width: 20, height: 20)).tint(with: #colorLiteral(red: 0.2862745098, green: 0.5647058824, blue: 0.8784313725, alpha: 1)), for: UIControlState())
        
        btnReview.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: UIControlState())
        btnAddPhoto.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: UIControlState())
        btnReview.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btnAddPhoto.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        addActionButton(btnClose)
        addActionButton(btnAddPhoto)
        addActionButton(btnReview)
        
        _ = vwHeader.constraints.map{
            if $0.firstAttribute == .height {
                $0.constant = 54 + UIApplication.shared.statusBarFrame.size.height
            }
        }
    }
    
    fileprivate func resetStateView() {
        self.topConstraintVwContainer.constant = 0
//        view.layoutIfNeeded()
    }
    
    private func addActionButton(_ sender:UIButton) {
        sender.addTarget(self, action: #selector(touchButton(_:)), for: .touchUpInside)
    }
    
    fileprivate func startAnimationShow(isShow:Bool,_ completion:(()->Void)? = nil) {
        self.vwBlur.bringSubview(toFront: self.vwHeader)
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut,.allowUserInteraction], animations: {
            self.btnClose.transform = isShow ? CGAffineTransform(rotationAngle: 22.5 * (180 / CGFloat.pi)) : .identity
            self.topConstraintVwContainer.constant = isShow ? 0 : -self.vwContainer.frame.maxY
            self.view.layoutIfNeeded()
        }) { (done) in
            completion?()
        }
        UIView.animate(withDuration: 0.2, delay: isShow ? 0.15 : 0, options: [.curveEaseInOut,.allowUserInteraction], animations: {
            self.vwBlur.backgroundColor = isShow ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7) : UIColor.clear
        },completion:nil)
    }
    
    // MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        transitioningDelegate = customTransitionDelegate
        customTransitionDelegate.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    deinit {
        debugPrint("invoked method: \(#function). : \(String(describing: type(of: PlusReviewController.self)))")
        vwBlur.removeGestureRecognizer(tapGesture)
        self.view.removeGestureRecognizer(panGesture)
    }
    
    // MARK: - closures
    var onGotoWriteReview: (() -> Void)?
    var onGotoAddPhoto: (() -> Void)?
    
    // MARK: - properties
    var tapGesture:UITapGestureRecognizer!
    var panGesture:UIPanGestureRecognizer!
    var interactionController: UIPercentDrivenInteractiveTransition?
    var customTransitionDelegate = TransitionConfig()
    var btnSelected:UIButton?
    
    // MARK: - outlet
    @IBOutlet weak var vwBlur: UIView!
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var vwInforRestaurant: UIView!
    @IBOutlet weak var vwBlockNameRestaurant: BlockNameRestaurantView!
    @IBOutlet weak var btnReview: UIButton!
    @IBOutlet weak var btnAddPhoto: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var vwActionReview: UIView!
    @IBOutlet weak var vwActionAddPhoto: UIView!
    @IBOutlet weak var vwHeader: UIView!
    
    @IBOutlet weak var topConstraintVwContainer: NSLayoutConstraint!
}

extension PlusReviewController:TransitionDelegate {
    func animateTransition(via transitionContext: UIViewControllerContextTransitioning, type: AnimatedTransitioning.TransitionType) {
        self.view.layoutIfNeeded()
        switch type {
        case .presenting:
            startAnimationShow(isShow: true) {
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        case .dismissing:
            startAnimationShow(isShow: false) {
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
    func transitionEnd(end: Bool) {
        if end && btnSelected != nil{
            if let sender = self.btnSelected {
                switch sender {
                case self.btnClose:
                    print("Close")
                case self.btnReview:
                    self.onGotoWriteReview?()
                case self.btnAddPhoto:
                    self.onGotoAddPhoto?()
                default:
                    print("Dont Know")
                }
            }
        }
    }
}

//
//  FloatView.swift
//  Eating
//
//  Created by Dai Pham on 3/28/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class FloatView: BaseUIView {

    // MARK: - api
    
    // MARK: - action
    func touchDown(_ sender:UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            sender.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: nil)
    }
    
    func touchUp(_ sender:UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            sender.transform = .identity
        }, completion: nil)
    }
    
    
    
    // MARK: - private
    private func startAnimations() {
        let options: UIViewKeyframeAnimationOptions = [.curveEaseInOut, .repeat]
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: options, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                self.targetRippleView.alpha = self.aniRippleScale
//                self.targetHolderView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.targetRippleView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
//                self.targetHolderView.transform = CGAffineTransform.identity
                self.targetRippleView.alpha = 0
                self.targetRippleView.transform = CGAffineTransform(scaleX: self.aniRippleScale, y: self.aniRippleScale)
            })
            
        }, completion: nil)
    }
    
    private func addTargetRipple(at center: CGPoint) {
        targetRippleView = UIView(frame: CGRect(x: 0, y: 0, width: targetHolderRadius * 2,height: targetHolderRadius * 2))
        targetRippleView.center = center
        targetRippleView.backgroundColor = #colorLiteral(red: 0.1862120447, green: 0.680355408, blue: 0.0503034011, alpha: 0.4017660651)
        targetRippleView.alpha = 0.0 //set it invisible
        targetRippleView.asCircle()
        view.addSubview(targetRippleView)
        view.bringSubview(toFront: btnCenter)
    }
    
    // MARK: - init
    override func config() {
        super.config()
        
        self.layoutIfNeeded()
        
        btnCenter.addTarget(self, action: #selector(touchDown(_:)), for: .touchDown)
        btnCenter.addTarget(self, action: #selector(touchUp(_:)), for: .touchUpInside)
        
        btnCenter.asCircle()
        btnCenter.setImage(#imageLiteral(resourceName: "ic_call").resizeImageWith(newSize: CGSize(width: 30, height: 30)).tint(with: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), for: .normal)
        btnCenter.setImage(#imageLiteral(resourceName: "ic_call").resizeImageWith(newSize: CGSize(width: 30, height: 30)).tint(with: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)), for: .highlighted)
        btnCenter.backgroundColor = #colorLiteral(red: 0.1862120447, green: 0.680355408, blue: 0.0503034011, alpha: 1)
        
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        view.layer.shadowOffset = CGSize(width:-0.5, height:1.0)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 5.0
        view.layer.cornerRadius = 5
        
        addTargetRipple(at: btnCenter.center)
        
        startAnimations()
    }
    
    // MARK: - closures
    
    // MARK: - properties
    var targetRippleView:UIView!
    var targetHolderRadius:CGFloat = 30
    var aniRippleScale:CGFloat = 1.2
    weak var controller:UIViewController?
    
    // MARK: - outlet
    @IBOutlet weak var btnCenter: UIButton!
    
}

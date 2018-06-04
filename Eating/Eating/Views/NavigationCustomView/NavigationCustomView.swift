//
//  HeaderPresentControllerView.swift
//  Eating
//
//  Created by Dai Pham on 3/14/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class NavigationCustomView: BaseUIView {

    // MARK: - api
    func effect(with scrollView:UIScrollView) {
        UIView.animate(withDuration: 0.1, animations: {[weak self] in
            guard let _self = self else {return}
            _self.bottomLine.alpha = scrollView.contentOffset.y > 0 ? 1 : 0
        })
    }
    
    // MARK: - action
    func touchButton(_ sender:UIButton) {
        switch sender {
        case btnClose:
            if let vc = controller, let v = vc as? BasePresentController {
                v.onDissmiss?()
            }
            if isPresent {
                controller?.dismiss(animated: true, completion: nil)
            } else {
                controller?.navigationController?.popViewController(animated: true)
            }
        case btnPlus:
            let vc = PlusReviewController(nibName: "PlusReviewController", bundle: Bundle.main)
            vc.interactionController = UIPercentDrivenInteractiveTransition()
            
            vc.onGotoAddPhoto = {[weak self] in
                guard let _self = self else {return}
                _self.gotoSearchRestaurant()
            }
            vc.onGotoWriteReview = {[weak self] in
                guard let _self = self else {return}
                _self.gotoSearchRestaurant()
            }
            
            var con:UIViewController?
            if let nv = controller?.navigationController {
                if let tb = nv.tabBarController {
                    con = tb
                } else {
                    con = nv
                }
            }
            if con == nil {
                con = controller
            }
            con?.present(vc, animated: true,completion: {
                vc.interactionController = nil
            })
        default:
            print("test")
        }
    }
    
    // MARK: - private
    private func gotoSearchRestaurant() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "searchRestaurantController") as! SearchRestaurantController
        let nv = UINavigationController(rootViewController: vc)
        
        var con:UIViewController?
        if let nv = controller?.navigationController {
            if let tb = nv.tabBarController {
                con = tb
            } else {
                con = nv
            }
        }
        if con == nil {
            con = controller
        }
        
        con?.dismiss(animated: false, completion: nil)
        con?.present(nv, animated: false, completion: nil)
    }
    
    override func config() {
        
        bottomLine.alpha = 0
        
        btnClose.setImage(#imageLiteral(resourceName: "ic_close_down").resizeImageWith(newSize: CGSize(width: 25, height: 25)).tint(with: #colorLiteral(red: 0.8862745098, green: 0.2196078431, blue: 0.2705882353, alpha: 1)), for: UIControlState())
        
        btnPlus.layer.masksToBounds = false
        btnPlus.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        btnPlus.layer.shadowOffset = CGSize(width:-0.1, height:0.1)
        btnPlus.layer.shadowOpacity = 1
        btnPlus.layer.shadowRadius = 2
        btnPlus.layer.cornerRadius = btnClose.frame.size.width/2
        btnPlus.setImage(#imageLiteral(resourceName: "ic_plus"), for: UIControlState())
        
        btnClose.addTarget(self, action: #selector(touchButton(_:)), for: .touchUpInside)
        btnPlus.addTarget(self, action: #selector(touchButton(_:)), for: .touchUpInside)
        
        _ = self.constraints.map{
            if $0.firstAttribute == .height {
                $0.constant = 54 + UIApplication.shared.statusBarFrame.size.height
            }
        }
    }
    
    // MARK: - closures
    
    // MARK: - properties
    var isPresent:Bool = true {
        didSet {
            if isPresent {
                btnClose.imageView?.transform = .identity
            } else {
                btnClose.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
            }
        }
    }
    
    var isShowButtonBack:Bool = true {
        didSet {
            btnClose.isHidden = !isShowButtonBack
        }
    }
    
    weak var controller:UIViewController?
    
    // MARK: - outlet
    @IBOutlet weak var bottomLine: UIView!
    @IBOutlet weak var stackLeft: UIStackView!
    @IBOutlet weak var stackRight: UIStackView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    
}

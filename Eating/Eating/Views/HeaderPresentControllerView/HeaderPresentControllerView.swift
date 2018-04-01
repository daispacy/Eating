//
//  HeaderPresentControllerView.swift
//  Eating
//
//  Created by Dai Pham on 3/14/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class HeaderPresentControllerView: BaseUIView {

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
            if let nv = controller?.navigationController {
                if let tb = nv.tabBarController {
                    tb.present(vc, animated: false, completion: nil)
                    return
                } else {
                    nv.present(vc, animated: false, completion: nil)
                    return
                }
            }
            controller?.present(vc, animated: false, completion: nil)
        default:
            print("test")
        }
    }
    
    // MARK: - private
    override func config() {
        
        bottomLine.alpha = 0
        
        btnClose.setImage(#imageLiteral(resourceName: "ic_close_down").resizeImageWith(newSize: CGSize(width: 25, height: 25)).tint(with: #colorLiteral(red: 0.8862745098, green: 0.2196078431, blue: 0.2705882353, alpha: 1)), for: UIControlState())
        
        btnClose.addTarget(self, action: #selector(touchButton(_:)), for: .touchUpInside)
        btnPlus.addTarget(self, action: #selector(touchButton(_:)), for: .touchUpInside)
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

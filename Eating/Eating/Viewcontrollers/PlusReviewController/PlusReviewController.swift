//
//  PlusReviewController.swift
//  Eating
//
//  Created by Dai Pham on 4/1/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class PlusReviewController: BasePresentController {

    // MARK: - api
    
    // MARK: - action
    func touchButton(_ sender:UIButton) {
        switch sender {
        case btnClose:
            print("Close")
            startAnimationShow(isShow: false) {
                self.dismiss(animated: false, completion: nil)
            }
        case btnReview:
            print("Close")
        case btnAddPhoto:
            print("Close")
        default:
            print("Dont Know")
        }
    }
    
    func touchVWBG(_ gesture:UITapGestureRecognizer) {
        startAnimationShow(isShow: false) {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    // MARK: - private
    private func config() {
        
//        self.vwContainer.transform = CGAffineTransform(translationX: 0, y: -self.vwContainer.frame.size.height - 60)
        self.vwBlur.backgroundColor = UIColor.clear
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchVWBG(_:)))
        vwBlur.addGestureRecognizer(tapGesture)
        
        btnClose.layer.masksToBounds = true
        btnClose.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        btnClose.layer.shadowOffset = CGSize(width:-0.5, height:0.5)
        btnClose.layer.shadowOpacity = 1
        btnClose.layer.shadowRadius = btnClose.frame.size.width/2
        btnClose.layer.cornerRadius = btnClose.frame.size.width/2
        btnClose.setImage(#imageLiteral(resourceName: "ic_plus"), for: UIControlState())
        
        btnReview.setImage(#imageLiteral(resourceName: "star_line").resizeImageWith(newSize: CGSize(width: 30, height: 30)).tint(with: #colorLiteral(red: 0.7843137255, green: 0.6745098039, blue: 0.2941176471, alpha: 1)), for: UIControlState())
        btnAddPhoto.setImage(#imageLiteral(resourceName: "ic_camera").resizeImageWith(newSize: CGSize(width: 30, height: 30)).tint(with: #colorLiteral(red: 0.2862745098, green: 0.5647058824, blue: 0.8784313725, alpha: 1)), for: UIControlState())
        
        addActionButton(btnClose)
        addActionButton(btnAddPhoto)
        addActionButton(btnReview)
        
        _ = vwHeader.constraints.map{
            if $0.firstAttribute == .height {
                $0.constant = 54 + UIApplication.shared.statusBarFrame.size.height
            }
        }
        self.topConstraintVwContainer.constant = -self.vwContainer.frame.maxY
    }
    
    private func addActionButton(_ sender:UIButton) {
        sender.addTarget(self, action: #selector(touchButton(_:)), for: .touchUpInside)
    }
    
    private func startAnimationShow(isShow:Bool,_ completion:(()->Void)? = nil) {
        self.vwBlur.bringSubview(toFront: self.vwHeader)
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
            self.btnClose.transform = isShow ? CGAffineTransform(rotationAngle: 22.5 * (180 / CGFloat.pi)) : .identity
            self.topConstraintVwContainer.constant = isShow ? 0 : -self.vwContainer.frame.maxY
            self.view.layoutIfNeeded()
        }) { (done) in
            if done {completion?()}
        }
        UIView.animate(withDuration: 0.2, delay: isShow ? 0.15 : 0, options: [.curveEaseInOut,.allowUserInteraction], animations: {
            self.vwBlur.backgroundColor = isShow ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6047260123) : UIColor.clear
        },completion:nil)
    }
    
    // MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        vwContainer.bringSubview(toFront: btnClose)
        startAnimationShow(isShow: true)
    }
    
    deinit {
        vwBlur.removeGestureRecognizer(tapGesture)
    }
    
    // MARK: - closures
    
    // MARK: - properties
    var tapGesture:UITapGestureRecognizer!
    
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

//
//  BaseController.swift
//  BUUP
//
//  Created by Dai Pham on 11/15/17.
//  Copyright © 2017 Sunrise Software Solutions. All rights reserved.
//

import UIKit

import CoreData
import Localize_Swift

class BaseController: UIViewController {

    // MARK: - closures
    var onDissmiss:(()->Void)?
    
    // MARK: - properties
    var btnProfile:UIButton!
    var btnNotification:UIButton!
    var btnSearch:UIButton!
    var btnBack:UIButton!
    var floatView:FloatView!
    
    // MARK: - override
    func layout() {}
    
    // MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        UIApplication.shared.statusBarStyle = .default
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let items = tabBarController?.tabBar.items {
            for item in items {
                item.title = ""
            }
        }
        
        if floatView != nil {
            view.bringSubview(toFront: floatView)
        }
    }
    
    deinit {
        #if DEBUG
            print("\(self.description) dealloc")
        #endif
    }

    // MARK: - interface
    func showFloatView() {
        if floatView == nil {
            floatView = FloatView(frame:CGRect(x: 50, y: 100, width: 50, height: 50))
            floatView.controller = self
            view.addSubview(floatView)
            view.bringSubview(toFront: floatView)
            floatView.translatesAutoresizingMaskIntoConstraints = false
            floatView.widthAnchor.constraint(equalToConstant: 50).isActive = true
            floatView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            floatView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
            if #available(iOS 11.0, *) {
                floatView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
            } else {
                floatView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
            }
            
        }
    }
    
    func addDefaultMenu () {
        
        let widthAvatar = CGFloat(40)
        // add right menu
        // profile
        btnProfile = UIButton(type: .custom)
        btnProfile.frame = CGRect(x: 0, y: 0, width: widthAvatar, height: widthAvatar)
        
        let imageView:UIImageView = UIImageView(image: UIImage(named: "menu_profile_white_76"))
        imageView.tag = 1111
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = widthAvatar / 2
//        if let user = Account.current {
//            btnProfile.imageView!.layer.cornerRadius = widthAvatar / 2
//            imageView.loadImageUsingCacheWithURLString(user.avatar,size:nil, placeHolder: nil)
//            NotificationCenter.default.addObserver(self, selector: #selector(self.updateBtnProfile), name: NSNotification.Name(rawValue: "UpdateButtonProfile"), object: nil)
//        }
        btnProfile.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: widthAvatar).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: widthAvatar).isActive = true
        imageView.centerXAnchor.constraint(equalTo: btnProfile.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: btnProfile.centerYAnchor).isActive = true
        imageView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        imageView.layer.borderWidth = 1
        
        btnProfile.addTarget(self, action: #selector(self.menuPress(sender:)), for: .touchUpInside)
        let itemProfile = UIBarButtonItem(customView: btnProfile)
        
        // back
        btnBack = UIButton(type: .custom)
        btnBack.frame = CGRect(x: 0, y: 0, width: widthAvatar*70/100, height: widthAvatar)
        btnBack.contentMode = .scaleAspectFill
        btnBack.clipsToBounds = true
        btnBack.semanticContentAttribute = .forceLeftToRight
        btnBack.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        btnBack.setImage(UIImage(named:"arrow_left_white_48")?.tint(with: UIColor.white), for: UIControlState())
        btnBack.addTarget(self, action: #selector(self.menuPress(sender:)), for: .touchUpInside)
        let itemBack = UIBarButtonItem(customView: btnBack)
        self.navigationItem.leftBarButtonItems = [itemProfile]
        if let vc = self.navigationController {
            if vc.viewControllers.count > 1 {
                self.navigationItem.leftBarButtonItems = [itemBack,itemProfile]
            }
        }
        
            
        // notification
        btnNotification = UIButton(type: .custom)
        btnNotification.frame = CGRect(x: 0, y: 0, width: widthAvatar, height: widthAvatar)
        btnNotification.contentMode = .right
        btnNotification.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10)
        btnNotification.clipsToBounds = true
        btnNotification.setImage(UIImage(named:"ic_bell_blue_76")?.tint(with: UIColor.white), for: UIControlState())
        btnNotification.addTarget(self, action: #selector(self.menuPress(sender:)), for: .touchUpInside)
        let itemNotification = UIBarButtonItem(customView: btnNotification)
        
        // search
        btnSearch = UIButton(type: .custom)
        btnSearch.frame = CGRect(x: 0, y: 0, width: widthAvatar, height: widthAvatar)
        btnSearch.contentMode = .right
        btnSearch.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10)
        btnSearch.clipsToBounds = true
        btnSearch.setImage(UIImage(named:"ic_search")?.tint(with: UIColor.white), for: UIControlState())
        btnSearch.addTarget(self, action: #selector(self.menuPress(sender:)), for: .touchUpInside)
        let itemSearch = UIBarButtonItem(customView: btnSearch)
        
        self.navigationItem.rightBarButtonItems  = [itemNotification,itemSearch]
    }
    
    // MARK: - action
    @objc func menuPress(sender:UIButton) {
        
        if sender.isEqual(btnProfile) {
            let storyBoard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            let nv = UINavigationController(rootViewController: storyBoard.instantiateViewController(withIdentifier: "ProfileController"))
            Support.topVC!.present(nv, animated: true, completion: nil)
        } else if sender.isEqual(btnBack) {
            if let vc = self.navigationController {
                if vc.viewControllers.count > 1 {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.navigationController?.dismiss(animated: true, completion: nil)
                }
            }
        } else if sender.isEqual(btnSearch) {
            return
        }
    }
}

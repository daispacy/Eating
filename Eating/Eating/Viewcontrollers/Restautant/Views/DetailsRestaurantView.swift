//
//  DetailsRestaurantView.swift
//  Eating
//
//  Created by Dai Pham on 3/13/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class DetailsRestaurantView: UIView {

    // MARK: - api
    
    // MARK: - private
    private func config() {
        lblTitle.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lblTitle.font = UIFont.boldSystemFont(ofSize: fontSize18)
        
        lblCall.textColor = #colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6156862745, alpha: 1)
        lblCall.font = UIFont.systemFont(ofSize: fontSize13)
        
        lblTextAdress.textColor = #colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6156862745, alpha: 1)
        lblTextAdress.font = UIFont.systemFont(ofSize: fontSize13)
        
        btnPhone.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize16)
        btnPhone.setTitleColor(#colorLiteral(red: 0.05098039216, green: 0.6392156863, blue: 0.07843137255, alpha: 1), for: UIControlState())
        
        lblAddress.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lblAddress.font = UIFont.systemFont(ofSize: fontSize14)
        lblAddress.numberOfLines = 0
        
        btnCall.layer.masksToBounds = true
        btnCall.layer.cornerRadius = min(btnCall.frame.size.height,btnCall.frame.size.width)/2
        btnCall.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.6392156863, blue: 0.07843137255, alpha: 1)
        btnCall.setImage(#imageLiteral(resourceName: "ic_call").resizeImageWith(newSize: CGSize(width: 20, height: 20)).tint(with: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), for: UIControlState())
        
        btnDirection.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize15)
        btnDirection.setTitleColor(#colorLiteral(red: 0.05098039216, green: 0.6392156863, blue: 0.07843137255, alpha: 1), for: UIControlState())
        
        vwMap.isUserInteractionEnabled = true
        mapController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "mapController") as! MapController
        mapController.type = .lite
        controller?.addChildViewController(mapController)
        vwMap.addSubview(mapController.view)
        mapController.didMove(toParentViewController: controller)
        mapController.view.fullConstraintWithParent()
        vwMap.addEvent {[weak self] in
            guard let _self = self else {return}
            _self.mapController.removeFromParentViewController()
            _self.mapController.view.removeFromSuperview()
            let vc = ContainerMapController()
            vc.mapController = _self.mapController
            _self.controller?.navigationController?.pushViewController(vc, animated: true)
            vc.onBack = {[weak _self] mapVC in
                guard let _self = _self, let mapVC = mapVC else {return}
                mapVC.removeFromParentViewController()
                mapVC.view.removeFromSuperview()
                _self.mapController = mapVC
                _self.mapController.type = .lite
                _self.controller?.addChildViewController(_self.mapController)
                _self.vwMap.addSubview(_self.mapController.view)
                _self.mapController.view.fullConstraintWithParent()
                _self.mapController.didMove(toParentViewController: _self.controller)
            }
        }
    }
    
    // MARK: - init
    override func awakeFromNib() {
        super.awakeFromNib()
        
        config()
    }
    
    // MARK: - closures
    
    // MARK: - properties
    var mapController:MapController!
    weak var controller:UIViewController?
    
    // MARK: - outlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCall: UILabel!
    @IBOutlet weak var btnPhone: UIButton!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var lblTextAdress: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var btnDirection: UIButton!
    @IBOutlet weak var vwMap: UIView!
    
}

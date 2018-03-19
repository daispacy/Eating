//
//  OtherRestaurantsView.swift
//  Eating
//
//  Created by Dai Pham on 3/13/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

enum OtherRestaurantsViewType {
    case lite
    case full
}

protocol OtherRestaurantsViewDelegate: class {
    func otherRestaurantsView(assign view:OtherRestaurantsView)
}

class OtherRestaurantsView: UIView {

    // MARK: - api
    
    // MARK: - action
    func touchButton(_ sender:UIButton) {
        let vc = RecentViewedRestaurantListController(nibName: "RecentViewedRestaurantListController", bundle: Bundle.main)
        controller?.navigationController?.pushViewController(vc, animated: true)
//        vc.onDissmiss = {[weak self] in
//            guard let _self = self else {return}
////            _self.delegate?.otherRestaurantsView(assign: _self)
//        }
    }
    
    // MARK: - private
    private func config() {
        lblTitle.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lblTitle.font = UIFont.boldSystemFont(ofSize: fontSize18)
        
        btnSeeAll.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize15)
        btnSeeAll.setTitleColor(#colorLiteral(red: 0.05098039216, green: 0.6392156863, blue: 0.07843137255, alpha: 1), for: UIControlState())
        btnSeeAll.addTarget(self, action: #selector(touchButton(_:)), for: .touchUpInside)
    }
    
    private func loadFakeData() {
        _ = stackContainer.arrangedSubviews.map{$0.removeFromSuperview()}
        for _ in 0..<(type == .lite ? 5 : 10) {
            let view = BlockNameRestaurantView(frame:bounds)
            stackContainer.addArrangedSubview(view)
        }
    }
    
    func loadNib() {
        Bundle.main.loadNibNamed("OtherRestaurantsView", owner: self, options: nil)
        self.addSubview(self.view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    // MARK: - init
    override func awakeFromNib() {
        super.awakeFromNib()
        
        config()
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        config()
        loadFakeData()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
        config()
    }
    
    // MARK: - closures
    
    // MARK: - properties
    weak var delegate:OtherRestaurantsViewDelegate?
    weak var controller:UIViewController?
    var type:OtherRestaurantsViewType = .lite {
        didSet {
            loadFakeData()
            btnSeeAll.isHidden = type == .full
        }
    }
    
    // MARK: - outlet
    @IBOutlet weak var view:UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var stackContainer: UIStackView!
    @IBOutlet weak var btnSeeAll: UIButton!
    
}

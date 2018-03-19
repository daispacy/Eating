//
//  HeaderRestaurantView.swift
//  Eating
//
//  Created by Dai Pham on 3/14/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class HeaderRestaurantView: UIView {

    // MARK: - api
    
    
    // MARK: - private
    private func config() {
        
        
        lblTitle.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lblTitle.font = UIFont.boldSystemFont(ofSize: fontSize22)
        
        lblSubtitle.textColor = #colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6156862745, alpha: 1)
        lblSubtitle.font = UIFont.systemFont(ofSize: fontSize17)
    }
    
    private func loadNIB() {
        Bundle.main.loadNibNamed("HeaderRestaurantView", owner: self, options: nil)
        addSubview(view)
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
        loadNIB()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNIB()
    }
    
    // MARK: - closures
    
    // MARK: - properties
    
    // MARK: - outlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet var view: UIView!
    
}

//
//  BaseUIView.swift
//  Eating
//
//  Created by Dai Pham on 3/26/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class BaseUIView: UIView {

    func config() {
        
    }
    
    private func loadNIb() {
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNIb()
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNIb()
        config()
    }
    
    // MARK: - outlet
    @IBOutlet weak var view: UIView!
}

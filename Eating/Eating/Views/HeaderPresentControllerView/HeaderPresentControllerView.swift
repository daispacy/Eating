//
//  HeaderPresentControllerView.swift
//  Eating
//
//  Created by Dai Pham on 3/14/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class HeaderPresentControllerView: UIView {

    // MARK: - api
    func effect(with scrollView:UIScrollView) {
        UIView.animate(withDuration: 0.1, animations: {
            self.bottomLine.alpha = scrollView.contentOffset.y > 0 ? 1 : 0
        })
    }
    
    // MARK: - action
    func touchButton(_ sender:UIButton) {
        controller?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - private
    private func config() {
        
        bottomLine.alpha = 0
        
        btnClose.setImage(#imageLiteral(resourceName: "ic_close_down").resizeImageWith(newSize: CGSize(width: 25, height: 25)).tint(with: #colorLiteral(red: 0.8862745098, green: 0.2196078431, blue: 0.2705882353, alpha: 1)), for: UIControlState())
        
        btnClose.addTarget(self, action: #selector(touchButton(_:)), for: .touchUpInside)
    }
    
    func loadNib() {
        Bundle.main.loadNibNamed("HeaderPresentControllerView", owner: self, options: nil)
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
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    // MARK: - closures
    
    // MARK: - properties
    var controller:UIViewController?
    @IBOutlet var view: UIView!
    
    // MARK: - outlet
    @IBOutlet weak var bottomLine: UIView!
    @IBOutlet weak var stackLeft: UIStackView!
    @IBOutlet weak var stackRight: UIStackView!
    @IBOutlet weak var btnClose: UIButton!
    
}

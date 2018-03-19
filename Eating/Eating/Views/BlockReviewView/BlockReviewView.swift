//
//  BlockReviewView.swift
//  Eating
//
//  Created by Dai Pham on 3/13/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class BlockReviewView: UIView {

    // MARK: - api
    func prepareReused() {
        imvUserAvatar.image = nil
    }
    
    
    // MARK: - action
    func touchButton(_ sender:UIButton) {
        sender.isHidden = true
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.lblReview.numberOfLines = 0
        }, completion: nil)
    }
    
    // MARK: - private
    private func config() {
        imvUserAvatar.layer.masksToBounds = true
        imvUserAvatar.layer.borderWidth = 1
        imvUserAvatar.layer.cornerRadius = imvUserAvatar.frame.size.width/2
        imvUserAvatar.loadImageUsingCacheWithURLString("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPEsiz-I7JK1WXVen1MJwSsGOFzgv-7KejWVsSr3ArhRg_1SYl")
        
        lblUserName.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lblUserName.font = UIFont.boldSystemFont(ofSize: fontSize16)
        
        lblRated.textColor = #colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6156862745, alpha: 1)
        lblRated.font = UIFont.systemFont(ofSize: fontSize13)
        
        lblDateReview.textColor = #colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6156862745, alpha: 1)
        lblDateReview.font = UIFont.systemFont(ofSize: fontSize13)
        
        let js = Restaurant_Card_Rate_BG_Colors.chooseOne
        if let color = js.values.first as? UIColor{
            btnRated.setTitleColor(color, for: UIControlState())
            btnRated.layer.borderColor = color.cgColor
            btnRated.setImage(#imageLiteral(resourceName: "star").tint(with: color).resizeImageWith(newSize: CGSize(width: 8, height: 8)), for: UIControlState())
            btnRated.backgroundColor = color.withAlphaComponent(0.2)
        }
        btnRated.setTitle("3", for: UIControlState())
        btnRated.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize13)
        
        btnRated.layer.cornerRadius = btnRated.frame.size.height/2
        btnRated.layer.borderWidth = 1
        
        btnReadMore.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize15)
        btnReadMore.setTitleColor(#colorLiteral(red: 0.05098039216, green: 0.6392156863, blue: 0.07843137255, alpha: 1), for: UIControlState())
        
        lblReview.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lblReview.font = UIFont.systemFont(ofSize: fontSize14)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0.25 * lblReview.font.lineHeight
        
        let attributedText = NSMutableAttributedString(string: lblReview.text!, attributes: [
            NSFontAttributeName: UIFont.systemFont(ofSize: fontSize14),
            NSForegroundColorAttributeName: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
            NSParagraphStyleAttributeName:paragraphStyle
            ])
        
        lblReview.attributedText = attributedText
        
        if stackContentReview.arrangedSubviews.count < 3 {
            photosAttachedView = Bundle.main.loadNibNamed("BlockListImageSquardView", owner: self, options: nil)?.first as! BlockListImageSquardView
            photosAttachedView.loadFakeImages()
            stackContentReview.addArrangedSubview(photosAttachedView)
        }
        
        btnReadMore.addTarget(self, action: #selector(touchButton(_:)), for: .touchUpInside)
    }
    
    func loadNib() {
        Bundle.main.loadNibNamed("BlockReviewView", owner: self, options: nil)
        self.addSubview(self.view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
        config()
    }
    
    // MARK: - closures
    
    // MARK: - properties
    var photosAttachedView:BlockListImageSquardView!
    
    // MARK: - outlet
    @IBOutlet weak var view:UIView!
    @IBOutlet weak var imvUserAvatar: UIImageViewRound!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblRated: UILabel!
    @IBOutlet weak var btnRated: UIButton!
    @IBOutlet weak var lblDateReview: UILabel!
    @IBOutlet weak var stackContentReview: UIStackView!
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var btnReadMore: UIButton!
    
}

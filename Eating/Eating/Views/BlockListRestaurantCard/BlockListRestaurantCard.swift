//
//  BlockListRestaurantCard.swift
//  Eating
//
//  Created by Dai Pham on 2/27/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class BlockListRestaurantCard: UIView {

    // MARK: - api
    func load(data:Any? = nil) {
        guard (data != nil) else {
            loadFakeData()
            return
        }
    }
    
    func set(title:String, buttonTitle:String) {
        lblTitle.text = title
        btnSeeAll.setTitle(buttonTitle, for: UIControlState())
    }
    
    // MARK: - private
    private func config() {
        
        btnSeeAll.titleLabel?.font = List_Card_Button_SeeAll_Font
        btnSeeAll.setTitleColor(List_Card_Button_SeeAll_TextColor, for: UIControlState())
        
        lblTitle.textColor = List_Card_Title_TextColor
        lblTitle.font = List_Card_Title_Font
        
        // initial constraint fake uicollectview
        stackLeadingConstraint.constant = 10
        stackTrailingConstraint.constant = 0
        btnSeeAllConstraint.constant = 10
        lblTitleLeadingConstraint.constant = 0
    }
    
    private func loadFakeData() {
        for _ in 0..<10 {
            let card = Bundle.main.loadNibNamed("RestaurantCard", owner: self, options: nil)?.first as! RestaurantCard
            card.load()
            stackBlocks.addArrangedSubview(card)
            card.translatesAutoresizingMaskIntoConstraints = false
            card.widthAnchor.constraint(equalToConstant: 140).isActive = true
            card.heightAnchor.constraint(equalToConstant: 170).isActive = true
            
            card.onTouchCard = {[weak self] card in
                guard let _self = self else {return}
                _self.onTouchCard?(card)
            }
        }
    }
    
    // MARK: - init
    override func awakeFromNib() {
        super.awakeFromNib()
        
        scrollView.delegate = self
        
        config()
    }
    
    // MARK: - closures
    var onTouchCard:((Any?)->Void)?
    
    // MARK: - properties
    var isDragging:Bool = false
    
    // MARK: - constraint
    @IBOutlet weak var stackTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnSeeAllConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblTitleLeadingConstraint: NSLayoutConstraint!
    
    // MARK: - outlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnSeeAll: UIButton!
    @IBOutlet weak var stackBlocks: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
}

extension BlockListRestaurantCard: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isDragging = true
        
        stackLeadingConstraint.constant = 0
        stackTrailingConstraint.constant = 0
        btnSeeAllConstraint.constant = 10
        lblTitleLeadingConstraint.constant = 10
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        isDragging = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // if dragging dont check condition for layout
        if isDragging {return}
        
        if scrollView.contentOffset.x <= 10 {
            stackLeadingConstraint.constant = 10
            stackTrailingConstraint.constant = 0
            btnSeeAllConstraint.constant = 10
            lblTitleLeadingConstraint.constant = 0
        } else if scrollView.contentOffset.x >= scrollView.contentSize.width - self.frame.size.width {
            stackLeadingConstraint.constant = 0
            stackTrailingConstraint.constant = 10
            btnSeeAllConstraint.constant = 0
            lblTitleLeadingConstraint.constant = 10
        }
    }
}

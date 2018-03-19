//
//  ReviewsListCell.swift
//  Eating
//
//  Created by Dai Pham on 3/19/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class ReviewsListCell: UITableViewCell {

    // MARK: - api
    
    // MARK: - private
    private func config() {
        
    }
    
    // MARK: - init
    override func awakeFromNib() {
        super.awakeFromNib()
        
        config()
    }
    
    override func prepareForReuse() {
//        restaurantView.prepareReused()
    }
    
    // MARK: - closures
    
    // MARK: - properties
    
    // MARK: - outlet
    @IBOutlet weak var restaurantView: BlockReviewView!
    
}

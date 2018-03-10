//
//  RestaurantCellSearch.swift
//  Eating
//
//  Created by Dai Pham on 2/27/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

enum RestaurantCellSearchType {
    case recentSearch
    case recentView
}

class RestaurantCellSearch: UITableViewCell {

    // MARK: - api
    func load(data:Any? = nil) {
        guard (data != nil) else {
            loadFakeData()
            return
        }
    }
    
    // MARK: - private
    private func config() {
        lblTitle.font = Restaurant_Card_Title_Font
        lblTitle.textColor = Restaurant_Card_Title_TextColor
        
        lblSubtitle.font = Restaurant_Card_Subtitle_Font
        lblSubtitle.textColor = Restaurant_Card_Subtitle_TextColor
        
        lblRate.font = Restaurant_Card_Rate_Font
        lblRate.textColor = Restaurant_Card_Rate_TextColor
        
        lblRate.backgroundColor = Restaurant_Card_Rate_BG_Colors.chooseOne.values.first as? UIColor
        
        lblRate.layer.masksToBounds = true
        lblRate.layer.cornerRadius = 3
        icon.layer.cornerRadius = 5
    }
    
    private func loadFakeData() {
        lblTitle.text = ["RuxBin","Pequod's Pizza","vai ca lon","oi cai dit con me"].chooseOne
        lblSubtitle.text = ["WEST TOWN, CHICAGO New American"].chooseOne
        icon.loadImageUsingCacheWithURLString(["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCde9ByZhZbfzmgC6dejFPA3uG4uwzhtKMylAIl6NPo8uuUn1UdA","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZ9S3o8jHYRrCRG_G1O7qLqKj3XI0nnZfdf-lhr0aiN6MHQbE1JQ","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSd6zlG1TTU-hKsQhvvImS7Je0kdc3u1DrafmaWSthxeDrqevGGzw"].chooseOne)
    }
    
    // MARK: - init
    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }
    
    override func prepareForReuse() {
        type = .recentSearch
        icon.image = nil
    }
    
    // MARK: - closures
    
    // MARK: - properties
    var type:RestaurantCellSearchType = .recentSearch
    
    // MARK: - outlet
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblRate: UILabel!
}

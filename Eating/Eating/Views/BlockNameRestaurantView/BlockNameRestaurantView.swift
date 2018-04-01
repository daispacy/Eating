//
//  BlockNameRestaurantView.swift
//  Eating
//
//  Created by Dai Pham on 3/13/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class BlockNameRestaurantView: UIView {

    // MARK: - api
    
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
    
    func loadNib() {
        Bundle.main.loadNibNamed("BlockNameRestaurantView", owner: self, options: nil)
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
        loadFakeData()
    }
    
    // MARK: - closures
    
    // MARK: - properties
    
    // MARK: - outlet
    @IBOutlet var view: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblRate: UILabel!

}

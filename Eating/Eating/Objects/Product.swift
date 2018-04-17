//
//  Employee.swift
//  Eating
//
//  Created by Dai Pham on 4/16/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import Foundation

class Product {
    var Id: String = ""
    
    var StoreId: String = ""
    var CategoryId: String = ""
    var FullName:String = ""
    var ShortName:String = ""
    var Description:String = ""
    var Price:Float = 0
    var Discount:Float = 0
    var TotalPrice:Float = 0
    var DisplayOrder:Int = 0
    
    var Status:String = ""
    var IsActive:Bool = true
    var CreatedBy:String = ""
    var CreatedDate:Date?
    var UpdatedBy:String = ""
    var UpdatedDate:Date?
    
    static func parse(from dictionary: JSON) -> Product{
        let user = Product()
        user.parse(from: dictionary)
        return user
    }
}
extension Product {
    
    func parse(from dictionary: JSON) {
        
        if let data = dictionary["Id"] as? String {
            self.Id = data
        } else if let data = dictionary["Id"] as? Int {
            self.Id = "\(data)"
        }
        
        if let data = dictionary["StoreId"] as? String {
            self.StoreId = data
        } else if let data = dictionary["StoreId"] as? Int {
            self.StoreId = "\(data)"
        }
        
        if let data = dictionary["CategoryId"] as? String {
            self.CategoryId = data
        } else if let data = dictionary["CategoryId"] as? Int {
            self.CategoryId = "\(data)"
        }
        
        if let data = dictionary["FullName"] as? String {
            self.FullName = data
        }
        
        if let data = dictionary["ShortName"] as? String {
            self.ShortName = data
        }
        
        if let data = dictionary["Description"] as? String {
            self.Description = data
        }
        
        if let data = dictionary["Price"] as? String {
            self.Price = Float(data)!
        } else if let data = dictionary["Price"] as? Float {
            self.Price = data
        }
        
        if let data = dictionary["Discount"] as? String {
            self.Discount = Float(data)!
        } else if let data = dictionary["Discount"] as? Float {
            self.Discount = data
        }
        
        if let data = dictionary["TotalPrice"] as? String {
            self.TotalPrice = Float(data)!
        } else if let data = dictionary["TotalPrice"] as? Float {
            self.TotalPrice = data
        }
        
        if let data = dictionary["DisplayOrder"] as? String {
            self.DisplayOrder = Int(data)!
        } else if let data = dictionary["DisplayOrder"] as? Int {
            self.DisplayOrder = data
        }
        
        if let data = dictionary["Status"] as? String {
            self.Status = data
        }
        
        if let data = dictionary["IsActive"] as? Bool {
            self.IsActive = data
        }
        
        if let data = dictionary["CreatedBy"] as? String {
            self.CreatedBy = data
        }
        
        if let data = dictionary["CreatedDate"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let myDate = dateFormatter.date(from: data) {
                self.CreatedDate = myDate
            }
        }
        
        if let data = dictionary["UpdatedBy"] as? String {
            self.UpdatedBy = data
        }
        
        if let data = dictionary["UpdatedDate"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let myDate = dateFormatter.date(from: data) {
                self.UpdatedDate = myDate
            }
        }
    }
}

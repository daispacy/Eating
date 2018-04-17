//
//  Employee.swift
//  Eating
//
//  Created by Dai Pham on 4/16/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import Foundation

class OrderDetail {
    var Id: String = ""
    
    var OrderMasterId: String = ""
    var ProductId: String = ""
    var Quantity:Int = 0
    var OriginalPrice:Float = 0
    var Discount:Float = 0
    var Price:Float = 0
    var Notes:String = ""
    
    var Status:String = ""
    var IsActive:Bool = true
    var CreatedBy:String = ""
    var CreatedDate:Date?
    var UpdatedBy:String = ""
    var UpdatedDate:Date?
    
    static func parse(from dictionary: JSON) -> OrderDetail{
        let user = OrderDetail()
        user.parse(from: dictionary)
        return user
    }
}
extension OrderDetail {
    
    func parse(from dictionary: JSON) {
        
        if let data = dictionary["Id"] as? String {
            self.Id = data
        } else if let data = dictionary["Id"] as? Int {
            self.Id = "\(data)"
        }
        
        if let data = dictionary["OrderMasterId"] as? String {
            self.OrderMasterId = data
        } else if let data = dictionary["OrderMasterId"] as? Int {
            self.OrderMasterId = "\(data)"
        }
        
        if let data = dictionary["ProductId"] as? String {
            self.ProductId = data
        }
        
        if let data = dictionary["Quantity"] as? String {
            self.Quantity = Int(data)!
        } else if let data = dictionary["Quantity"] as? Int {
            self.Quantity = data
        }
        
        if let data = dictionary["OriginalPrice"] as? String {
            self.OriginalPrice = Float(data)!
        } else if let data = dictionary["OriginalPrice"] as? Float {
            self.OriginalPrice = data
        }
        
        if let data = dictionary["Discount"] as? String {
            self.Discount = Float(data)!
        } else if let data = dictionary["Discount"] as? Float {
            self.Discount = data
        }
        
        if let data = dictionary["Price"] as? String {
            self.Price = Float(data)!
        } else if let data = dictionary["Price"] as? Float {
            self.Price = data
        }
        
        if let data = dictionary["ImageURL"] as? String {
            self.Notes = data
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

//
//  Employee.swift
//  Eating
//
//  Created by Dai Pham on 4/16/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import Foundation

class OrderMaster {
    var Id: String = ""
    
    var CustomerId:String = ""
    var EmployeeId:String = ""
    var StoreId:String = ""
    var ShipperId:String = ""
    var BookingDate:Date = Date()
    var DeliveryDate:Date = Date()
    var TotalQuantity:Int = 0
    var TotalPrice:Float = 0
    var Discount:Float = 0
    var ShipFee:Float = 0
    var TotalDistanceToDelivery:Float = 0
    var TotalPayment:Float = 0
    var Notes:String = ""
    var RateOfCustomerToShipper:Int = 0
    var CommentOfCustomerToShipper:String = ""
    var RateOfCustomerToStore:Int = 0
    var CommentOfCustomerToStore:String = ""
    var OrderStatus:String = ""
    
    var Status:String = ""
    var IsActive:Bool = true
    var CreatedBy:String = ""
    var CreatedDate:Date?
    var UpdatedBy:String = ""
    var UpdatedDate:Date?
    
    static func parse(from dictionary: JSON) -> OrderMaster{
        let user = OrderMaster()
        user.parse(from: dictionary)
        return user
    }
}
extension OrderMaster {
    
    func parse(from dictionary: JSON) {
        
        if let data = dictionary["Id"] as? String {
            self.Id = data
        } else if let data = dictionary["Id"] as? Int {
            self.Id = "\(data)"
        }
        
        if let data = dictionary["CustomerId"] as? String {
            self.CustomerId = data
        } else if let data = dictionary["CustomerId"] as? Int {
            self.CustomerId = "\(data)"
        }
        
        if let data = dictionary["EmployeeId"] as? String {
            self.EmployeeId = data
        } else if let data = dictionary["EmployeeId"] as? Int {
            self.EmployeeId = "\(data)"
        }
        
        if let data = dictionary["StoreId"] as? String {
            self.StoreId = data
        } else if let data = dictionary["StoreId"] as? Int {
            self.StoreId = "\(data)"
        }
        
        if let data = dictionary["ShipperId"] as? String {
            self.ShipperId = data
        } else if let data = dictionary["ShipperId"] as? Int {
            self.ShipperId = "\(data)"
        }
        
        if let data = dictionary["BookingDate"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let myDate = dateFormatter.date(from: data) {
                self.BookingDate = myDate
            }
        }
        
        if let data = dictionary["DeliveryDate"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let myDate = dateFormatter.date(from: data) {
                self.DeliveryDate = myDate
            }
        }
        
        if let data = dictionary["TotalQuantity"] as? String {
            self.TotalQuantity = Int(data)!
        } else if let data = dictionary["TotalQuantity"] as? Int {
            self.TotalQuantity = data
        }
        
        if let data = dictionary["TotalPrice"] as? String {
            self.TotalPrice = Float(data)!
        } else if let data = dictionary["TotalPrice"] as? Float {
            self.TotalPrice = data
        }
        
        if let data = dictionary["Discount"] as? String {
            self.Discount = Float(data)!
        } else if let data = dictionary["Discount"] as? Float {
            self.Discount = data
        }
        
        if let data = dictionary["ShipFee"] as? String {
            self.ShipFee = Float(data)!
        } else if let data = dictionary["ShipFee"] as? Float {
            self.ShipFee = data
        }
        
        if let data = dictionary["TotalDistanceToDelivery"] as? String {
            self.TotalDistanceToDelivery = Float(data)!
        } else if let data = dictionary["TotalDistanceToDelivery"] as? Float {
            self.TotalDistanceToDelivery = data
        }
        
        if let data = dictionary["TotalPayment"] as? String {
            self.TotalPayment = Float(data)!
        } else if let data = dictionary["TotalPayment"] as? Float {
            self.TotalPayment = data
        }
        
        if let data = dictionary["Notes"] as? String {
            self.Notes = data
        }
        
        if let data = dictionary["RateOfCustomerToShipper"] as? String {
            self.RateOfCustomerToShipper = Int(data)!
        } else if let data = dictionary["RateOfCustomerToShipper"] as? Int {
            self.RateOfCustomerToShipper = data
        }
        
        if let data = dictionary["CommentOfCustomerToShipper"] as? String {
            self.CommentOfCustomerToShipper = data
        }
        
        if let data = dictionary["RateOfCustomerToStore"] as? String {
            self.RateOfCustomerToStore = Int(data)!
        } else if let data = dictionary["RateOfCustomerToStore"] as? Int {
            self.RateOfCustomerToStore = data
        }
        
        if let data = dictionary["CommentOfCustomerToStore"] as? String {
            self.CommentOfCustomerToStore = data
        }
        
        if let data = dictionary["OrderStatus"] as? String {
            self.OrderStatus = data
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

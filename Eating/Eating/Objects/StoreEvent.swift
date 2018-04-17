//
//  Employee.swift
//  Eating
//
//  Created by Dai Pham on 4/16/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import Foundation

class StoreEvent {
    var Id: String = ""
    
    var StoreId: String = ""
    var EventName:String = ""
    var Description:String = ""
    var ImageURL:String = ""
    var StartDate:Date?
    var EndDate:Date?
    var OrderDisplay:Int = 0
    
    var Status:String = ""
    var IsActive:Bool = true
    var CreatedBy:String = ""
    var CreatedDate:Date?
    var UpdatedBy:String = ""
    var UpdatedDate:Date?
    
    static func parse(from dictionary: JSON) -> StoreEvent{
        let user = StoreEvent()
        user.parse(from: dictionary)
        return user
    }
}
extension StoreEvent {
    
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
        
        if let data = dictionary["EventName"] as? String {
            self.EventName = data
        }
        
        if let data = dictionary["Description"] as? String {
            self.Description = data
        }
        
        if let data = dictionary["ImageURL"] as? String {
            self.ImageURL = data
        }
        
        if let data = dictionary["StartDate"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let myDate = dateFormatter.date(from: data) {
                self.StartDate = myDate
            }
        }
        
        if let data = dictionary["EndDate"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let myDate = dateFormatter.date(from: data) {
                self.EndDate = myDate
            }
        }
        
        if let data = dictionary["OrderDisplay"] as? String {
            self.OrderDisplay = Int(data)!
        } else if let data = dictionary["OrderDisplay"] as? Int {
            self.OrderDisplay = data
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

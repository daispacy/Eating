//
//  Employee.swift
//  Eating
//
//  Created by Dai Pham on 4/16/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import Foundation

class StoreAccount {
    var Id: String = ""
    
    var StoreId: String = ""
    var UserName: String = ""
    var Password: String = ""
    var FirstName:String = ""
    var MidName:String = ""
    var LastName:String = ""
    var Email:String = ""
    var Tel:String = ""
    var Gender:String = ""
    var AvatarURL:String = ""
    
    var Status:String = ""
    var IsActive:Bool = true
    var CreatedBy:String = ""
    var CreatedDate:Date?
    var UpdatedBy:String = ""
    var UpdatedDate:Date?
    
    static func parse(from dictionary: JSON) -> StoreAccount{
        let user = StoreAccount()
        user.parse(from: dictionary)
        return user
    }
}
extension StoreAccount {
    
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
        
        if let data = dictionary["UserName"] as? String {
            self.UserName = data
        }
        
        if let data = dictionary["Password"] as? String {
            self.Password = data
        }
        
        if let data = dictionary["FirstName"] as? String {
            self.FirstName = data
        }
        
        if let data = dictionary["MidName"] as? String {
            self.MidName = data
        }
        
        if let data = dictionary["LastName"] as? String {
            self.LastName = data
        }
        
        if let data = dictionary["Email"] as? String {
            self.Email = data
        }
        
        if let data = dictionary["Tel"] as? String {
            self.Tel = data
        }
        
        if let data = dictionary["Gender"] as? String {
            self.Gender = data
        }
        
        if let data = dictionary["AvatarURL"] as? String {
            self.AvatarURL = data
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

//
//  Employee.swift
//  Eating
//
//  Created by Dai Pham on 4/16/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import Foundation

class CustomerAccount {
    var Id: String = ""
    var UserName:String = ""
    var Password:String = ""
    var Status:String = ""
    var IsActive:Bool = true
    var CreatedBy:String = ""
    var CreatedDate:Date?
    var UpdatedBy:String = ""
    var UpdatedDate:Date?
    
    static func parse(from dictionary: JSON) -> CustomerAccount{
        let user = CustomerAccount()
        user.parse(from: dictionary)
        return user
    }
}
extension CustomerAccount {
    
    func parse(from dictionary: JSON) {
        
        if let data = dictionary["Id"] as? String {
            self.Id = data
        } else if let data = dictionary["Id"] as? Int {
            self.Id = "\(data)"
        }
        
        if let data = dictionary["UserName"] as? String {
            self.UserName = data
        } else if let data = dictionary["UserName"] as? Int {
            self.UserName = "\(data)"
        }
        
        if let data = dictionary["Password"] as? String {
            self.Password = data
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

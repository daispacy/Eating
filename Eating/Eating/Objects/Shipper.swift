//
//  Employee.swift
//  Eating
//
//  Created by Dai Pham on 4/16/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import Foundation

class Shipper {
    var Id: String = ""
    
    var FullName:String = ""
    var Birthday:Date?
    var IdentityCardNo:String = ""
    var IdentityCardIssueDate:Date?
    var IdentityCardIssuePlace:String = ""
    var AvatarURL:String = ""
    var Gender:String = ""
    var PrimaryAddress:String = ""
    var TemporaryAddress:String = ""
    var Email:String = ""
    var Tel:String = ""
    var Facebook:String = ""
    var WorkPlace:String = ""
    var WorkStart:Date?
    var WorkEnd:Date?
    var IsWorkOvertime:Bool = false
    var VehicleType:String = ""
    var Brand:String = ""
    var NumberPlate:String = ""
    var VerhicleImageURL:String = ""
    
    var Status:String = ""
    var IsActive:Bool = true
    var CreatedBy:String = ""
    var CreatedDate:Date?
    var UpdatedBy:String = ""
    var UpdatedDate:Date?
    
    static func parse(from dictionary: JSON) -> Shipper{
        let user = Shipper()
        user.parse(from: dictionary)
        return user
    }
}
extension Shipper {
    
    func parse(from dictionary: JSON) {
        
        if let data = dictionary["Id"] as? String {
            self.Id = data
        }
        
        if let data = dictionary["FullName"] as? String {
            self.FullName = data
        }
        
        if let data = dictionary["Birthday"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let myDate = dateFormatter.date(from: data) {
                self.Birthday = myDate
            }
        }
        
        if let data = dictionary["IdentityCardNo"] as? String {
            self.IdentityCardNo = data
        }
        
        if let data = dictionary["IdentityCardIssueDate"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let myDate = dateFormatter.date(from: data) {
                self.IdentityCardIssueDate = myDate
            }
        }
        
        if let data = dictionary["IdentityCardIssuePlace"] as? String {
            self.IdentityCardIssuePlace = data
        }
        
        if let data = dictionary["AvatarURL"] as? String {
            self.AvatarURL = data
        }
        
        if let data = dictionary["Gender"] as? String {
            self.Gender = data
        }
        
        if let data = dictionary["PrimaryAddress"] as? String {
            self.PrimaryAddress = data
        }
        
        if let data = dictionary["TemporaryAddress"] as? String {
            self.TemporaryAddress = data
        }
        
        if let data = dictionary["Email"] as? String {
            self.Email = data
        }
        
        if let data = dictionary["Tel"] as? String {
            self.Tel = data
        }
        
        if let data = dictionary["Facebook"] as? String {
            self.Facebook = data
        }
        
        if let data = dictionary["WorkPlace"] as? String {
            self.WorkPlace = data
        }
        
        if let data = dictionary["WorkStart"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let myDate = dateFormatter.date(from: data) {
                self.WorkStart = myDate
            }
        }
        
        if let data = dictionary["WorkEnd"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let myDate = dateFormatter.date(from: data) {
                self.WorkEnd = myDate
            }
        }
        
        if let data = dictionary["IsWorkOvertime"] as? Bool {
            self.IsWorkOvertime = data
        }
        
        if let data = dictionary["VehicleType"] as? String {
            self.VehicleType = data
        }
        
        if let data = dictionary["Brand"] as? String {
            self.Brand = data
        }
        
        if let data = dictionary["NumberPlate"] as? String {
            self.NumberPlate = data
        }
        
        if let data = dictionary["VerhicleImageURL"] as? String {
            self.VerhicleImageURL = data
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

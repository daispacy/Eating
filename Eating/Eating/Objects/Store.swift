//
//  Employee.swift
//  Eating
//
//  Created by Dai Pham on 4/16/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import Foundation

class Store {
    var Id: String = ""
    
    var ParentId: String = ""
    var FullName:String = ""
    var ShortName:String = ""
    var PrimaryAddress:String = ""
    var PrimaryLatitude:Float?
    var PrimaryLongtitude:Float?
    var SecondAddress:String = ""
    var SecondLatitude:Float?
    var SecondLongtitude:Float?
    var Tel:String = ""
    var Tel2:String = ""
    var Facebook:String = ""
    var OpenTime:Date = Date()
    var CloseTime:Date = Date()
    var StartOpenDayInWeek:Int = 0
    var EndOpenDayInWeek:Int = 0
    var LogoURL:String = ""
    var AvatarURL:String = ""
    var BannerURL:String = ""
    var IsConnectPartner:Bool = false
    var BenefitPercentPerReceipt:Float = 0
    var BenefitPricePerReceipt:Float = 0
    var AboutUs:String = ""
    var IsReturnReceipt:Bool = false
    
    var Status:String = ""
    var IsActive:Bool = true
    var CreatedBy:String = ""
    var CreatedDate:Date?
    var UpdatedBy:String = ""
    var UpdatedDate:Date?
    
    static func parse(from dictionary: JSON) -> Store{
        let user = Store()
        user.parse(from: dictionary)
        return user
    }
}
extension Store {
    
    func parse(from dictionary: JSON) {
        
        if let data = dictionary["Id"] as? String {
            self.Id = data
        }
        
        if let data = dictionary["ParentId"] as? String {
            self.ParentId = data
        }
        
        if let data = dictionary["FullName"] as? String {
            self.FullName = data
        }
        
        if let data = dictionary["ShortName"] as? String {
            self.ShortName = data
        }
        
        if let data = dictionary["PrimaryAddress"] as? String {
            self.PrimaryAddress = data
        }
        
        if let data = dictionary["PrimaryLatitude"] as? Float {
            self.PrimaryLatitude = data
        } else if let data = dictionary["PrimaryLatitude"] as? String {
            self.PrimaryLatitude = Float(data)!
        }
        
        if let data = dictionary["PrimaryLongtitude"] as? Float {
            self.PrimaryLongtitude = data
        } else if let data = dictionary["PrimaryLongtitude"] as? String {
            self.PrimaryLongtitude = Float(data)!
        }
        
        if let data = dictionary["SecondAddress"] as? String {
            self.SecondAddress = data
        }
        
        if let data = dictionary["SecondLatitude"] as? Float {
            self.SecondLatitude = data
        } else if let data = dictionary["SecondLatitude"] as? String {
            self.SecondLatitude = Float(data)!
        }
        
        if let data = dictionary["SecondLongtitude"] as? Float {
            self.SecondLongtitude = data
        } else if let data = dictionary["SecondLongtitude"] as? String {
            self.SecondLongtitude = Float(data)!
        }
        
        if let data = dictionary["Tel"] as? String {
            self.Tel = data
        }
        
        if let data = dictionary["Tel2"] as? String {
            self.Tel2 = data
        }
        
        if let data = dictionary["Facebook"] as? String {
            self.Facebook = data
        }
        
        if let data = dictionary["OpenTime"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let myDate = dateFormatter.date(from: data) {
                self.OpenTime = myDate
            }
        }
        
        if let data = dictionary["CloseTime"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let myDate = dateFormatter.date(from: data) {
                self.CloseTime = myDate
            }
        }
        
        if let data = dictionary["StartOpenDayInWeek"] as? Int {
            self.StartOpenDayInWeek = data
        } else if let data = dictionary["StartOpenDayInWeek"] as? String {
            self.StartOpenDayInWeek = Int(data)!
        }
        
        if let data = dictionary["EndOpenDayInWeek"] as? Int {
            self.EndOpenDayInWeek = data
        } else if let data = dictionary["EndOpenDayInWeek"] as? String {
            self.EndOpenDayInWeek = Int(data)!
        }
        
        if let data = dictionary["LogoURL"] as? String {
            self.LogoURL = data
        }
        
        if let data = dictionary["AvatarURL"] as? String {
            self.AvatarURL = data
        }
        
        
        if let data = dictionary["BannerURL"] as? String {
            self.BannerURL = data
        }
        
        if let data = dictionary["IsConnectPartner"] as? Bool {
            self.IsConnectPartner = data
        }
        
        if let data = dictionary["BenefitPricePerReceipt"] as? Float {
            self.BenefitPricePerReceipt = data
        } else if let data = dictionary["BenefitPricePerReceipt"] as? String {
            self.BenefitPricePerReceipt = Float(data)!
        }
        
        if let data = dictionary["BenefitPercentPerReceipt"] as? Float {
            self.BenefitPercentPerReceipt = data
        } else if let data = dictionary["BenefitPercentPerReceipt"] as? String {
            self.BenefitPercentPerReceipt = Float(data)!
        }
        
        if let data = dictionary["AboutUs"] as? String {
            self.AboutUs = data
        }
        
        if let data = dictionary["IsReturnReceipt"] as? Bool {
            self.IsReturnReceipt = data
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

//
//  Employee.swift
//  Eating
//
//  Created by Dai Pham on 4/16/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import Foundation

class StoreAttachmentFile {
    var Id: String = ""
    
    var StoreId:String = ""
    var ShortName:String = ""
    var OriginalName:String = ""
    var FilePath:String = ""
    var FileType:String = ""
    
    var Status:String = ""
    var IsActive:Bool = true
    var CreatedBy:String = ""
    var CreatedDate:Date?
    var UpdatedBy:String = ""
    var UpdatedDate:Date?
    
    static func parse(from dictionary: JSON) -> StoreAttachmentFile{
        let user = StoreAttachmentFile()
        user.parse(from: dictionary)
        return user
    }
}
extension StoreAttachmentFile {
    
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
        
        if let data = dictionary["ShortName"] as? String {
            self.ShortName = data
        }
        
        if let data = dictionary["OriginalName"] as? String {
            self.OriginalName = data
        }
        
        if let data = dictionary["FilePath"] as? String {
            self.FilePath = data
        }
        
        if let data = dictionary["FileType"] as? String {
            self.FileType = data
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

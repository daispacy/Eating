//
//  Employee.swift
//  Eating
//
//  Created by Dai Pham on 4/16/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import Foundation

class ProductAttachmentFile {
    var Id: String = ""
    
    var ProductId:String = ""
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
    
    static func parse(from dictionary: JSON) -> ProductAttachmentFile{
        let user = ProductAttachmentFile()
        user.parse(from: dictionary)
        return user
    }
}
extension ProductAttachmentFile {
    
    func parse(from dictionary: JSON) {
        
        if let data = dictionary["Id"] as? String {
            self.Id = data
        } else if let data = dictionary["Id"] as? Int {
            self.Id = "\(data)"
        }
        
        if let data = dictionary["ProductId"] as? String {
            self.ProductId = data
        } else if let data = dictionary["ProductId"] as? Int {
            self.ProductId = "\(data)"
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

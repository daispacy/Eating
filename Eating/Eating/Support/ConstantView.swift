//
//  ConstantView.swift
//  Eating
//
//  Created by Dai Pham on 2/27/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import Foundation
import UIKit

// MARK: - TextFieldSearchCard
let TextFieldSearchCard_PlaceHolder_Color   = #colorLiteral(red: 0.5647058824, green: 0.5607843137, blue: 0.5843137255, alpha: 1)
let TextFieldSearchCard_PlaceHolder_Font    = UIFont.systemFont(ofSize: fontSize15)

// MARK: - ListCard
let List_Card_Title_TextColor               = #colorLiteral(red: 0.09019607843, green: 0.1921568627, blue: 0.2588235294, alpha: 1)
let List_Card_Title_Font                    = UIFont.boldSystemFont(ofSize: fontSize17)

let List_Card_Button_SeeAll_Font            = UIFont.boldSystemFont(ofSize: fontSize16)
let List_Card_Button_SeeAll_TextColor       = #colorLiteral(red: 0.05098039216, green: 0.6352941176, blue: 0.07450980392, alpha: 1)

// MARK: - RestaurantCard
let Restaurant_Card_Radius:CGFloat          = 5
let Restaurant_Card_Shadow_Radius:CGFloat   = 1
let Restaurant_Card_Shadow_Opacity:Float    = 0.5
let Restaurant_Card_Shadow_Offset           = CGSize(width:0.5, height:0.5)
let Restaurant_Card_Shadow_Color            = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor

let Restaurant_Card_Title_Font              = UIFont.boldSystemFont(ofSize: fontSize16)
let Restaurant_Card_Title_TextColor         = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

let Restaurant_Card_Subtitle_Font           = UIFont.systemFont(ofSize: fontSize13)
let Restaurant_Card_Subtitle_TextColor      = #colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6156862745, alpha: 1)

let Restaurant_Card_Rate_Font               = UIFont.boldSystemFont(ofSize: fontSize17)
let Restaurant_Card_Rate_TextColor          = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
let Restaurant_Card_Rate_BG_Colors:[JSON]   = [[NSStringFromCGPoint(CGPoint(x: 0, y: 1)):#colorLiteral(red: 0.7960784314, green: 0.1254901961, blue: 0.1607843137, alpha: 1)],
                                               [NSStringFromCGPoint(CGPoint(x: 1.1, y: 2)):#colorLiteral(red: 1, green: 0.4745098039, blue: 0, alpha: 1)],
                                               [NSStringFromCGPoint(CGPoint(x: 2.1, y: 3)):#colorLiteral(red: 0.7960784314, green: 0.8431372549, blue: 0.07450980392, alpha: 1)],
                                               [NSStringFromCGPoint(CGPoint(x: 3.1, y: 4)):#colorLiteral(red: 0.3607843137, green: 0.662745098, blue: 0.1607843137, alpha: 1)],
                                               [NSStringFromCGPoint(CGPoint(x: 4.1, y: 5)):#colorLiteral(red: 0.1882352941, green: 0.3647058824, blue: 0.007843137255, alpha: 1)]]


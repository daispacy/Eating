//
//  MapController.swift
//  Eating
//
//  Created by Dai Pham on 3/11/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class MapController: BaseController {

    // MARK: - api
    
    // MARK: - private
    private func config() {
        webView.delegate = self
        let url = try! URL(string: "https://maps.google.com/maps?saddr=9.998634,105.0894541&sll=9.998634,105.0894541&hl=en&t=m&mra=mift&mrsp=1&sz=5&z=3")
        if let url = url {
            webView.loadRequest(URLRequest(url: url))
        }
    }
    
    // MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    // MARK: - closures
    
    // MARK: - properties
    
    // MARK: - outlet
    @IBOutlet weak var webView: UIWebView!
    
}

extension MapController:UIWebViewDelegate {

}

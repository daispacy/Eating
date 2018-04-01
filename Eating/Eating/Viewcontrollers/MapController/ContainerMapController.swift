//
//  ContainerMapController.swift
//  Eating
//
//  Created by Dai Pham on 3/31/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class ContainerMapController: BaseController {

    // MARK: - api
    
    // MARK: - private
    private func config() {
        
    }
    
    // MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onBack?(mapController)
    }
    
    override func loadView() {
        super.loadView()
        guard let map = mapController else { return }
        view = UIView(frame: UIScreen.main.bounds)
        view.addSubview(map.view)
        map.view.fullConstraintWithParent()
        mapController?.didMove(toParentViewController: self)
    }
    
    // MARK: - closures
    var onBack:((MapController?)->Void)?
    
    // MARK: - properties
    var mapController:MapController?
    
    // MARK: - outlet

}

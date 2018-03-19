//
//  ReviewsListController.swift
//  Eating
//
//  Created by Dai Pham on 3/19/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class ReviewsListController: BasePresentController {

    // MARK: - api
    
    // MARK: - private
    private func config() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ReviewsListCell", bundle: Bundle.main), forCellReuseIdentifier: "cell")
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        
        tableView.reloadData()
    }
    
    // MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    
    // MARK: - closures
    
    // MARK: - properties
    
    // MARK: - outlet
    @IBOutlet weak var tableView: UITableView!
    
}

extension ReviewsListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReviewsListCell
        
        return cell
    }
}

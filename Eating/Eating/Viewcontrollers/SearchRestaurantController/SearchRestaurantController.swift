//
//  SearchRestaurantController.swift
//  Eating
//
//  Created by Dai Pham on 4/17/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class SearchRestaurantController: UIViewController {

    // MARK: - api
    
    // MARK: - private
    private func config() {
        
        tableView.register(UINib(nibName: "RestaurantCellSearch", bundle: Bundle.main), forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        
        searchController.dimsBackgroundDuringPresentation = false // default is YES
        searchController.searchBar.delegate = self    // so we can monitor text changes + others
        
        searchController.searchBar.placeholder = "Tìm kiếm món ăn, nước uống hoặc nhà hàng"
        searchController.searchBar.barTintColor = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1)
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.tintColor = #colorLiteral(red: 0, green: 0.6156862745, blue: 0.05490196078, alpha: 1)
        
        if myNav == nil && self.navigationController == nil {
            myNav = UINavigationBar(frame: CGRect.zero)
            let naviItem = UINavigationItem()
            naviItem.titleView = searchController.searchBar
            myNav.items = [naviItem]
            stackContainer.insertArrangedSubview(myNav, at: 0)
        } else {
            if #available(iOS 11.0, *) {
                navigationItem.searchController = searchController
                title = "Tìm kiếm nhà hàng"
            } else {
                navigationItem.titleView = searchController.searchBar
            }
        }
    }
    
    // MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.searchBar.becomeFirstResponder()
    }
    
    // MARK: - closures
    
    // MARK: - properties
    var listRestaurant:[JSON] = []
    
    var searchController: UISearchController!
    var myNav:UINavigationBar!
    
    // MARK: - outlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stackContainer: UIStackView!
    
}

// MARK: -
extension SearchRestaurantController:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RestaurantCellSearch
        cell.load()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5//listRestaurant.count
    }
}

// MARK: -
extension SearchRestaurantController:UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let strippedString = searchController.searchBar.text!
        debugPrint("UISearchControllerDelegate invoked method: \(#function). : \(strippedString)")
    }
}

// MARK: -
extension SearchRestaurantController:UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - var
extension SearchRestaurantController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchController.searchBar.resignFirstResponder()
    }
}

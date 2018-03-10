//
//  HomeController.swift
//  Eating
//
//  Created by Dai Pham on 2/25/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class HomeController: BaseController {

    // MARK: - api
    
    // MARK: - private
    private func loadFakeData() {
        for _ in 0..<5 {
            let block = Bundle.main.loadNibNamed("BlockListRestaurantCard", owner: self, options: nil)?.first as! BlockListRestaurantCard
            block.set(title: "Gần đây", buttonTitle: "Tất cả")
            block.load()
            stackBlocks.addArrangedSubview(block)
            block.onTouchCard = {[weak self] card in
                guard let _self = self else {return}
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "restaurant_detail") as! RestaurantDetailController
                _self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    // MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.delegate = self
        searchBar.placeholder = "Tìm kiếm món ăn, nước uống hoặc nhà hàng"
        
        tableSearch.register(UINib(nibName: "RestaurantCellSearch", bundle: Bundle.main), forCellReuseIdentifier: "cell")
        tableSearch.rowHeight = UITableViewAutomaticDimension
        tableSearch.estimatedRowHeight = 50
        tableSearch.delegate = self
        tableSearch.dataSource = self
        tableSearch.isHidden = true
        
        let dummyViewHeight = CGFloat(30)
        self.tableSearch.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableSearch.bounds.size.width, height: dummyViewHeight))
        self.tableSearch.contentInset = UIEdgeInsetsMake(-dummyViewHeight, 0, 0, 0)
        
        loadFakeData()
        
        tableSearch.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - closures
    
    // MARK: - properties
    var thumbnailZoomTransitionAnimator: PushZoomTransitionAnimator?
    var transitionThumbnail: UIImageView?
    
    // MARK: - outlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var stackBlocks: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableSearch: UITableView!
}

// MARK: - search delegate
extension HomeController:UITableViewDelegate,
UITableViewDataSource,
UISearchBarDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        
        let txt = UITextField(frame: view.bounds)
        view.addSubview(txt)
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        txt.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10).isActive = true
        txt.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 5).isActive = true
        
        txt.textColor = #colorLiteral(red: 0.6666666667, green: 0.5725490196, blue: 0.3294117647, alpha: 1)
        txt.text = (section == 0 ? "Tìm kiếm gần đây" : "Xem gần đây").uppercased()
        txt.font = Restaurant_Card_Title_Font
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RestaurantCellSearch
        cell.load()
        return cell
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        self.tableSearch.isHidden = false
        tabBarController?.tabBar.isHidden = true
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        tableSearch.isHidden = true
        tabBarController?.tabBar.isHidden = false
        searchBar.resignFirstResponder()
    }
}

// MARK: - scrollview delegate
extension HomeController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if searchBar.isFirstResponder {
            searchBar.resignFirstResponder()
            if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
                cancelButton.isEnabled = true
            }
        }
    }
}

// MARK: - custom transition
extension HomeController: UINavigationControllerDelegate {
   
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            // Pass the thumbnail frame to the transition animator.
            guard let transitionThumbnail = transitionThumbnail, let transitionThumbnailSuperview = transitionThumbnail.superview else { return nil }
            thumbnailZoomTransitionAnimator = PushZoomTransitionAnimator()
            thumbnailZoomTransitionAnimator?.thumbnailFrame = transitionThumbnailSuperview.convert(transitionThumbnail.frame, to: nil)
        }
        thumbnailZoomTransitionAnimator?.operation = operation
        
        return thumbnailZoomTransitionAnimator
    }
}

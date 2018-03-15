//
//  WriteReviewController.swift
//  Eating
//
//  Created by Dai Pham on 3/14/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class WriteReviewController: BaseController {

    // MARK: - api
    
    // MARK: - private
    private func config() {
        
        automaticallyAdjustsScrollViewInsets = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil)
        tapgesture = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide))
        view.addGestureRecognizer(tapgesture)
        tapgesture.cancelsTouchesInView = true
        
        // set delegate for controls
        scrollView.delegate = self
        textViewComment.delegate = self
        
        rateRestaurantView.type = .lite
        
        // set controller for custom view
        vwHeader.controller = self
        photoView.controller = self
        
        // add name restaurant view
        headerRestaurantView = Bundle.main.loadNibNamed("HeaderRestaurantView", owner: self, options: nil)?.first as! HeaderRestaurantView
        stackContainer.insertArrangedSubview(headerRestaurantView, at: 0)
        
        // add Rate Restaurant View
        stackRates.addArrangedSubview(rateRestaurantView)
        
        lblTitleRate.font = UIFont.systemFont(ofSize: fontSize13)
        lblTitleRate.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lblTitleComment.font = UIFont.systemFont(ofSize: fontSize13)
        lblTitleComment.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        bottomLineComment.alpha = 0.4
        
        view.bringSubview(toFront: vwHeader)
    }
    
    func scrollToCusorPosition(textView:UITextView) {
        if let range:UITextRange = textView.selectedTextRange {
            let position = range.end
            let cursorRect = textView.caretRect(for: position)
            let cursorPoint = CGPoint(x: 0, y: /*realPoint.y +*/ cursorRect.origin.y)
            currentContentOffset = CGPoint(x: 0, y: (cursorPoint.y - keyboardHeight + 20))
            print(cursorRect)
            if cursorPoint.y.isNaN || cursorPoint.y.isInfinite || scrollView.contentOffset.y ==  currentContentOffset.y {return}
            scrollView.scrollRectToVisible(CGRect(origin: CGPoint(x: scrollView.contentSize.width - 1, y: scrollView.contentSize.height - 1), size: CGSize(width: 1, height: 1)), animated: true)
        }
    }
    
    func keyboardWillChangeFrame(notification:NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            var mix:CGFloat = 0
            if let parent = self.parent {
                if let tabbar = parent.tabBarController {
                    mix = tabbar.tabBar.frame.size.height
                }
            }
            if #available(iOS 11.0,*) {
                keyboardHeight = keyboardRectangle.height - mix - view.safeAreaInsets.bottom
            } else {
                keyboardHeight = keyboardRectangle.height - mix
            }
        }
    }
    
    func keyboardWillShow(notification:NSNotification) {
        bottomLineComment.alpha = 1
        bottomConstraintScrollView.constant = keyboardHeight + 40
    }
    
    func keyboardWillHide(notification:NSNotification) {
        bottomLineComment.alpha = 0.4
        bottomConstraintScrollView.constant = 0
        view.endEditing(true)
    }
    
    // MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onDissmiss?()
    }
    
    deinit {
        print("writereviewcontroller dealloc")
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil)
        view.removeGestureRecognizer(tapgesture)
    }
    
    // MARK: - closures
    
    // MARK: - properties
    var currentContentOffset:CGPoint = CGPoint.zero
    var keyboardHeight:CGFloat = 210
    var shouldScrollToCursor:Bool = true
    var tapgesture:UITapGestureRecognizer!
    var headerRestaurantView:HeaderRestaurantView!
    var rateRestaurantView:RateRestaurantView!
    
    // MARK: - outlet
    
    @IBOutlet weak var photoView: AddPhotosView!
    @IBOutlet weak var vwHeader: HeaderPresentControllerView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackContainer: UIStackView!
    @IBOutlet weak var stackRates: UIStackView!
    @IBOutlet weak var lblTitleRate: UILabel!
    @IBOutlet weak var stackComment: UIStackView!
    @IBOutlet weak var lblTitleComment: UILabel!
    @IBOutlet weak var bottomLineComment: UIView!
    @IBOutlet weak var textViewComment: UITextView!
    
    @IBOutlet weak var topConstraintScrollView: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraintScrollView: NSLayoutConstraint!
}

extension WriteReviewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // hide/show bottom line on header controller
        vwHeader.effect(with: scrollView)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

extension WriteReviewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if scrollView.contentSize.height > scrollView.frame.size.height - keyboardHeight{
            self.scrollToCusorPosition(textView: textView)
            
        }
    }
}

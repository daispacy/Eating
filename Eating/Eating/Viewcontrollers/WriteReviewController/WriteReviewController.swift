//
//  WriteReviewController.swift
//  Eating
//
//  Created by Dai Pham on 3/14/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

class WriteReviewController: BasePresentController {

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
        
        // config Rate Restaurant View
        stackRates.addArrangedSubview(rateRestaurantView)
        
        lblTitleRate.font = UIFont.systemFont(ofSize: fontSize13)
        lblTitleRate.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        // config write comment
        lblTitleComment.font = UIFont.systemFont(ofSize: fontSize13)
        lblTitleComment.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        textViewComment.font = UIFont.systemFont(ofSize: fontSize16)
        textViewComment.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        bottomLineComment.alpha = 0.4
        
        view.bringSubview(toFront: vwHeader)
        
        txtPlaceholder.textColor = #colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6156862745, alpha: 1)
        txtPlaceholder.font = UIFont.boldSystemFont(ofSize: fontSize17)
        
        checkShowPlaceholder()
    }
    
    private func checkShowPlaceholder() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.1, animations: {
            if self.textViewComment.text.characters.count > 0 {
                self.textViewComment.alpha = 1
                self.txtPlaceholder.alpha = 0
                self.topConstraintBottomLineTextView.priority = 750
                self.topConstraintBottomLineLabel.priority = 250
            } else {
                self.textViewComment.alpha = 0
                self.txtPlaceholder.alpha = 1
                self.topConstraintBottomLineTextView.priority = 250
                self.topConstraintBottomLineLabel.priority = 750
            }
            self.view.layoutIfNeeded()
        },completion:{done in
            if self.textViewComment.text.characters.count > 0 {
                self.textViewComment.isHidden = false
                self.txtPlaceholder.isHidden = true
            } else {
                self.textViewComment.isHidden = true
                self.txtPlaceholder.isHidden = false
            }
        })
    }
    
    fileprivate func scrollToCusorPosition(textView:UITextView) {
        if let range:UITextRange = textView.selectedTextRange {
            let position = range.end
            let cursorRect = textView.caretRect(for: position)
            let cursorPoint = CGPoint(x: 0, y: /*realPoint.y +*/ cursorRect.origin.y)
            currentContentOffset = CGPoint(x: 0, y: (cursorPoint.y - keyboardHeight + 20))
            print(cursorRect)
            if cursorPoint.y.isNaN || cursorPoint.y.isInfinite || scrollView.contentOffset.y ==  currentContentOffset.y {return}
            let numberItems = UIDevice.current.userInterfaceIdiom == .pad ? CGFloat(8) : CGFloat(4)
            let height = (UIScreen.main.bounds.size.width - 20  - (numberItems - 1)*5) / numberItems // height of func add photos
            scrollView.scrollRectToVisible(CGRect(origin: CGPoint(x: scrollView.contentSize.width - 1, y: scrollView.contentSize.height - height), size: CGSize(width: 1, height: 1)), animated: true)
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
        bottomConstraintScrollView.constant = keyboardHeight
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.1, animations: {
            self.topConstraintBottomLineTextView.priority = 750
            self.topConstraintBottomLineLabel.priority = 250
            self.view.layoutIfNeeded()
        },completion:{done in
            self.textViewComment.alpha = 1
            self.txtPlaceholder.alpha = 0
            self.textViewComment.isHidden = false
            self.txtPlaceholder.isHidden = true
        })
        
        
    }
    
    func keyboardWillHide(notification:NSNotification) {
        bottomLineComment.alpha = 0.4
        bottomConstraintScrollView.constant = 0
        view.endEditing(true)
        checkShowPlaceholder()
    }
    
    // MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        txtPlaceholder.addEvent {[weak self] in
            guard let _self = self else {return}
            _self.textViewComment.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        txtPlaceholder.removeEvent()
    }
    
    deinit {
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
    var rateRestaurantView:RateRestaurantView!
    
    // MARK: - outlet
    
    @IBOutlet weak var headerRestaurantView: HeaderRestaurantView!
    @IBOutlet weak var photoView: AddPhotosView!
    @IBOutlet weak var vwHeader: NavigationCustomView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackContainer: UIStackView!
    @IBOutlet weak var stackRates: UIStackView!
    @IBOutlet weak var lblTitleRate: UILabel!
    @IBOutlet weak var stackComment: UIStackView!
    @IBOutlet weak var lblTitleComment: UILabel!
    @IBOutlet weak var bottomLineComment: UIView!
    @IBOutlet weak var textViewComment: UITextView!
    @IBOutlet weak var txtPlaceholder: UILabel!
    
    @IBOutlet weak var topConstraintBottomLineLabel: NSLayoutConstraint!
    @IBOutlet weak var topConstraintBottomLineTextView: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraintScrollView: NSLayoutConstraint!
}

// MARK: -
extension WriteReviewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // hide/show bottom line on header controller
        vwHeader.effect(with: scrollView)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

// MARK: -
extension WriteReviewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if scrollView.contentSize.height > scrollView.frame.size.height - keyboardHeight{
            self.scrollToCusorPosition(textView: textView)
            
        }
    }
}

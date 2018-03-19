//
//  TabbarMenuSlider.swift
//  Eating
//
//  Created by Dai Pham on 3/19/18.
//  Copyright © 2018 Eating VietNam. All rights reserved.
//

import UIKit

fileprivate let LEADING:CGFloat = 0

class TabbarMenuSlider: UIView {

    // MARK: - api
    func load(data:[String]) {
        listData = data
        
        selectedIndex = 0
        _ = stackControls.arrangedSubviews.map{$0.removeFromSuperview()}
        
        for (i,title) in data.enumerated() {
            let btn = createButton(title: title,tag: i)
            stackControls.addArrangedSubview(btn)
            if i < data.count - 1 {
                let seperate = createSeperate()
                stackControls.addArrangedSubview(seperate)
            }
        }
        
        self.layoutIfNeeded()
        self.setNeedsDisplay()
        
        self.constraintLeadingHighlight.constant =  LEADING
        if let btn = stackControls.arrangedSubviews.first as? UIButton{
            self.constraintWidthHighlight.constant = btn.frame.size.width
            btn.isSelected = true
        }
    }
    
    func scrollDidView(_ scrollView:UIScrollView? = nil) {
        
        guard let scrollView = scrollView else { return }
        
        var fromView:UIView? = nil
        var toView:UIView? = nil
        
        let min = scrollView.frame.size.width * CGFloat(selectedIndex)
        let inScrease = min < scrollView.contentOffset.x
        
        for item in stackControls.arrangedSubviews {
            if let btn = item as? UIButton {
                if btn.tag == selectedIndex {
                    fromView = btn
                } else {
                    if inScrease {
                        if btn.tag == selectedIndex + 1 {
                            toView = btn
                        }
                    } else {
                        if btn.tag == selectedIndex - 1 {
                            toView = btn
                        }
                    }
                }
            }
        }
        
        guard let from = fromView, let to = toView else {return}
        
        let percent =  inScrease ? (scrollView.contentOffset.x - (scrollView.frame.size.width*CGFloat(selectedIndex)))*100/scrollView.frame.size.width :
            -(scrollView.contentOffset.x - (scrollView.frame.size.width*CGFloat(selectedIndex)))*100/scrollView.frame.size.width

        moveHightlight(from: from, to: to, percent: percent)
    }
    
    func selectIndex(_ index:Int) {
        guard index < listData.count && index >= 0 else {
            return
        }
        var fromView:UIView? = nil
        var toView:UIView? = nil
        
        for item in stackControls.arrangedSubviews {
            if let btn = item as? UIButton {
                if btn.tag == selectedIndex {
                    fromView = btn
                } else if btn.tag == index {
                    toView = btn
                }
            }
        }
        
        guard let from = fromView, let to = toView else { return }
        
        moveHightlight(from: from, to: to, percent: 100)
        
        selectedIndex = index
        updated()
    }
    
    // MARK: - action
    func touchButton(_ sender:UIButton) {
        if sender.tag == selectedIndex {return}
        var fromView:UIView? = nil
        var toView:UIView? = nil
        
        for item in stackControls.arrangedSubviews {
            if let btn = item as? UIButton {
                if btn.tag == selectedIndex {
                    fromView = btn
                } else if btn.tag == sender.tag {
                    toView = btn
                }
            }
        }
        selectedIndex = sender.tag
        
        moveHightlight(from: fromView!, to: toView!, percent: 100)
        
        updated()
    }
    
    // MARK: - private
    private func moveHightlight(from:UIView, to:UIView, percent:CGFloat) {
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       options: .allowUserInteraction,
                       animations: {
                        let number = LEADING + from.frame.minX + percent * (to.frame.minX - from.frame.minX)/100
                        self.constraintLeadingHighlight.constant =  number
                        self.constraintWidthHighlight.constant = from.frame.width + percent*(to.frame.width - from.frame.width)/100
                        self.layoutIfNeeded()
        },
                       completion: {finis in
                        UIView.animate(withDuration: 0.1, animations: {
                            for (_,btn) in self.stackControls.arrangedSubviews.enumerated() {
                                if let btn = btn as? UIButton {
                                    btn.isSelected = self.selectedIndex == btn.tag
                                }
                            }
                        })
        })
        let frameVisible = CGRect(origin: to.frame.origin,
                                  size: CGSize(width: to.frame.width + 10,
                                               height: to.frame.height))
        scrollView.scrollRectToVisible(frameVisible, animated: true)
    }
    
    private func updated() {
        self.onSelectIndex?(self.selectedIndex)
    }
    
    private func createButton(title:String,tag:Int) -> UIButton{
        let btn = UIButton(type: .custom)
        btn.tag = tag
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize17)
        btn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.05098039216, green: 0.6392156863, blue: 0.07843137255, alpha: 1), for: .selected)

        btn.setTitle(title, for: UIControlState())
        
        btn.addTarget(self, action: #selector(touchButton(_:)), for: .touchUpInside)
        
        return btn
    }
    
    private func createSeperate() -> UILabel{
        let lbl = UILabel(frame: bounds)
        lbl.font = UIFont.systemFont(ofSize: fontSize16)
        lbl.textColor = #colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6156862745, alpha: 1)
        lbl.text = ":"
        return lbl
    }
    
    private func config() {
        vwHightLight.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.6392156863, blue: 0.07843137255, alpha: 1)
    }
    
    private func loadNib() {
        Bundle.main.loadNibNamed("TabbarMenuSlider", owner: self, options: nil)
        self.addSubview(self.view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    // MARK: - init
    override func awakeFromNib() {
        super.awakeFromNib()
        
        config()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    // MARK: - closures
    var onSelectIndex:((Int)->Void)?
    
    // MARK: - properties
    var selectedIndex:Int = 0
    var listData:[String] = []
    
    // MARK: - outlet
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var stackControls: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var vwHightLight: UIView!
    
    // MARK: - constraint
    @IBOutlet weak var constraintLeadingHighlight: NSLayoutConstraint!
    @IBOutlet weak var constraintWidthHighlight: NSLayoutConstraint!
}

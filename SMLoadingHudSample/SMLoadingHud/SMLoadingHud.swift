//
//  SMLoadingHud.swift
//  SMLoadingHud
//
//  Created by Si Ma on 9/26/17.
//  Copyright © 2017 Si Ma. All rights reserved.
//

import UIKit

open class SMLoadingHud: UIWindow {
    
    private static let `default` = SMLoadingHud()
    
    private var indicatorView: SMLoadingIndicatorView!
    private var backgroundView: UIView?
    
    private var indicatorContainer: UIView!
    private var label: UILabel!
    private var text: String?
    
    open var customIndicator: SMLoadingIndicator?
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supposed to be used. Use init() instead.")
    }
    
    override public init(frame: CGRect) {
        fatalError("init(frame:) is not supposed to be used. Use init() instead.")
    }
    
    
    public init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.alpha = 0.0
        self.windowLevel = UIWindowLevelAlert
        self.makeKeyAndVisible()
        
        self.indicatorContainer = UIView(frame: .zero)
        self.addSubview(self.indicatorContainer)
        
        self.label = UILabel(frame: .zero)
        self.indicatorContainer.addSubview(self.label)
        
        self.indicatorView = SMLoadingIndicatorView()
        self.indicatorContainer.addSubview(self.indicatorView)
        
        self.setupIndicatorContainer()
        self.setupIndicatorView()
        self.setupLoadingLabel()
    }
    
    private func setupIndicatorContainer() {
        self.indicatorContainer.translatesAutoresizingMaskIntoConstraints = false
        self.indicatorContainer.backgroundColor = UIColor(white: 0.0, alpha: 0.8)
        self.indicatorContainer.layer.masksToBounds = true
        self.indicatorContainer.layer.cornerRadius = 12.0
        
        let widthConstraint = NSLayoutConstraint(item: self.indicatorContainer, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 160.0)
        let centreXConstraint = NSLayoutConstraint(item: self.indicatorContainer, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centreYConstraint = NSLayoutConstraint(item: self.indicatorContainer, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        
        NSLayoutConstraint.activate([widthConstraint, centreXConstraint, centreYConstraint])
    }
    
    private func setupIndicatorView() {
        let centreXConstraint = NSLayoutConstraint(item: self.indicatorView, attribute: .centerX, relatedBy: .equal, toItem: self.indicatorContainer, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(item: self.indicatorView, attribute: .top, relatedBy: .equal, toItem: self.indicatorContainer, attribute: .top, multiplier: 1.0, constant: 5.0)
        let widthConstraint = NSLayoutConstraint(item: self.indicatorView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0)
        let heightConstraint = NSLayoutConstraint(item: self.indicatorView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 90.0)
        
        NSLayoutConstraint.activate([centreXConstraint, topConstraint, widthConstraint, heightConstraint])
    }
    
    private func setupLoadingLabel() {
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.backgroundColor = .clear
        self.label.font = UIFont.boldSystemFont(ofSize: 20.0)
        self.label.adjustsFontSizeToFitWidth = true
        self.label.textAlignment = .center
        self.label.textColor = UIColor(white: 0.9, alpha: 1.0)
        
        let leadingConstraint = NSLayoutConstraint(item: self.label, attribute: .leading, relatedBy: .equal, toItem: self.indicatorContainer, attribute: .leadingMargin, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: self.label, attribute: .trailing, relatedBy: .equal, toItem: self.indicatorContainer, attribute: .trailingMargin, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(item: self.label, attribute: .top, relatedBy: .equal, toItem: self.indicatorView, attribute: .bottom, multiplier: 1.0, constant: -5.0)
        let bottomConstraint = NSLayoutConstraint(item: self.label, attribute: .bottom, relatedBy: .equal, toItem: self.indicatorContainer, attribute: .bottom, multiplier: 1.0, constant: -15.0)
        
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }
    
    open override func didMoveToWindow() {
        super.didMoveToWindow()
        
        guard let superWindow = self.superview else { return }
        DispatchQueue.main.async {
            self.frame = superWindow.bounds
            self.layoutIfNeeded()
        }
    }
}

//MARK: <#Configurations#>
extension SMLoadingHud {
    
    class open func setIndicatorType(type: SMLoadingIndicatorType) {
        let hud = SMLoadingHud.default
        
        DispatchQueue.main.async {
            hud.indicatorView.indicator.stopAnimation()
            hud.indicatorView.indicator.rootNode.removeFromParentNode()
            switch type {
            case .cube:
                hud.indicatorView.indicator = SMCubeIndicator()
            case .custom:
                guard let indicator = hud.customIndicator else {
                    fatalError("customIndicator must be assigned before using .custom as the indicator type.")
                }
                hud.indicatorView.indicator = indicator
            }
        }
    }
    
    class open func setBackgroundView(view: UIView?) {
        DispatchQueue.main.async {
            
            let hud = SMLoadingHud.default
            hud.backgroundView?.removeFromSuperview()
            hud.backgroundView = view
            if let background = hud.backgroundView {
                hud.insertSubview(background, at: 0)
            }
        }
    }
    
    class open func setText(_ text: String) {
        DispatchQueue.main.async {
            let hud = SMLoadingHud.default
            hud.text = text
        }
    }
}


//MARK: <#Animation#>
extension SMLoadingHud {
    
    class open func presentWithText(_ text: String?) {
        guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else {
            fatalError()
        }
        
        DispatchQueue.main.async {
            let hud = SMLoadingHud.default
            hud.label.text = text
            window.addSubview(hud)
            
            UIView.animate(withDuration: 0.25, animations: {
                hud.alpha = 1.0
            })
            hud.indicatorView.indicator.startAnimation()
        }
    }
    
    class open func dismiss(completion: (() -> Void)?) {
        DispatchQueue.main.async {
            let hud = SMLoadingHud.default
            UIView.animate(withDuration: 0.25, animations: {
                hud.alpha = 0.0
                
            }, completion: {_ in
                hud.indicatorView.indicator.stopAnimation()
                hud.removeFromSuperview()
                completion?()
            })
        }
    }
}

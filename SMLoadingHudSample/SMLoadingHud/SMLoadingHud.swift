//
//  SMLoadingHud.swift
//  SMLoadingHud
//
//  Created by Si Ma on 9/26/17.
//  Copyright © 2017 Si Ma. All rights reserved.
//

import UIKit

public enum SMLoadingIndicatorType: Int {
    case cube
}

open class SMLoadingHud: UIWindow {
    
    private static let defaultHud = SMLoadingHud(indicatorType: .cube)
    
    private var indicatorView: SMLoadingIndicatorView!
    private var indicatorType: SMLoadingIndicatorType = .cube
    private var backgroundView: UIView?
    
    private var indicatorContainer: UIView!
    private var label: UILabel!
    private var text: String?
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supposed to be used. Use init(indicatorType:) instead.")
    }
    
    override public init(frame: CGRect) {
        fatalError("init(frame:) is not supposed to be used. Use init(indicatorType:) instead.")
    }
    
    
    public init(indicatorType: SMLoadingIndicatorType) {
        super.init(frame: .zero)
        
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.alpha = 0.0
        self.windowLevel = UIWindowLevelAlert
        self.makeKeyAndVisible()
        
        self.indicatorContainer = UIView(frame: .zero)
        self.addSubview(self.indicatorContainer)
        
        self.label = UILabel(frame: .zero)
        self.indicatorContainer.addSubview(self.label)
        
        switch indicatorType {
        case .cube:
            self.indicatorView = SMLoadingCubeView()
        }
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
    
    class open func setBackgroundView(view: UIView?) {
        DispatchQueue.main.async {
            let hud = SMLoadingHud.defaultHud
            hud.backgroundView?.removeFromSuperview()
            hud.backgroundView = view
            if let background = hud.backgroundView {
                hud.insertSubview(background, at: 0)
            }
        }
    }
    
    class open func setText(_ text: String) {
        DispatchQueue.main.async {
            let hud = SMLoadingHud.defaultHud
            hud.text = text
        }
    }
}


// MARK: <#Animation#>
extension SMLoadingHud {
    
    class open func presentWithText(_ text: String?) {
        
        guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else {
            fatalError()
        }
        
        DispatchQueue.main.async {
            let hud = SMLoadingHud.defaultHud
            hud.frame = window.bounds
            hud.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            hud.alpha = 0.0
            hud.label.text = text
            window.addSubview(hud)
            
            UIView.animate(withDuration: 0.25, animations: {
                hud.alpha = 1.0
            })
            hud.indicatorView.startAnimation()
        }
    }
    
    class open func dismiss(completion: (() -> Void)?) {
        DispatchQueue.main.async {
            let hud = SMLoadingHud.defaultHud
            UIView.animate(withDuration: 0.25, animations: {
                hud.alpha = 0.0
                
            }, completion: {_ in
                hud.indicatorView.stopAnimation()
                hud.removeFromSuperview()
                completion?()
            })
        }
    }
}

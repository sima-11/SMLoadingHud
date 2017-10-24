//
//  SMLoadingIndicator.swift
//  SMLoadingHud
//
//  Created by Si Ma on 9/29/17.
//  Copyright © 2017 Si Ma. All rights reserved.
//

import SceneKit

public enum SMLoadingIndicatorType: Int {
    case cube
    case custom
}

open class SMLoadingIndicator: SMLoadingIndicatorCreation {
    
    public var type: SMLoadingIndicatorType { return .cube }
    
    public let rootNode = SCNNode()
    public var action: SCNAction?
    
    private let actionKey = "SMLoadingIndicatorAction"
    
    
    public init() {
        self.buildIndicator()
        self.buildAction()
    }
    
    // MARK: <#SMLoadingIndicatorCreation Methods#>
    public func buildIndicator() {}
    public func buildAction() {}
    
    // MARK: <#Animation#>
    open func startAnimation() {
        guard let action = self.action else {
            print("action hasn't been assigned.")
            return
        }
        self.rootNode.runAction(SCNAction.repeatForever(action), forKey: self.actionKey)
    }
    
    open func stopAnimation() {
        self.rootNode.removeAction(forKey: self.actionKey)
    }
}

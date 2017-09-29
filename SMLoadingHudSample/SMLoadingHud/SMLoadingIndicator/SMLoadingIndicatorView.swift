//
//  SMLoadingIndicator.swift
//  SMLoadingHud
//
//  Created by Si Ma on 9/26/17.
//  Copyright © 2017 Si Ma. All rights reserved.
//

import SceneKit

open class SMLoadingIndicatorView: SCNView {
    
    private var aScene: SCNScene!
    
    internal var objectNode: SCNNode!
    internal let actionKey = "SMLoadingIndicatorAction"
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    public override init(frame: CGRect, options: [String : Any]? = nil) {
        super.init(frame: frame, options: options)
        self.setup()
    }
    
    convenience init() {
        self.init(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setup() {
        self.setupScene()
        self.setupCamera()
        self.buildObject()
        self.addObjectNode()
    }
    
    private func setupScene() {
        self.backgroundColor = .clear
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.aScene = SCNScene()
        self.aScene.background.contents = UIColor.clear
        self.scene = self.aScene
    }
    
    private func setupCamera() {
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 6)
        self.aScene.rootNode.addChildNode(cameraNode)
    }
    
    internal func buildObject() {
        self.objectNode = SCNNode()
    }
    
    private func addObjectNode() {
        self.aScene.rootNode.addChildNode(self.objectNode)
    }
    
    // MARK: <#Animation#>
    /*
     * The following two methods are only used for the interface declaration
     * and are supposed to be overwritten by subclasses
     */
    internal func startAnimation() {
    }
    internal func stopAnimation() {
    }
}

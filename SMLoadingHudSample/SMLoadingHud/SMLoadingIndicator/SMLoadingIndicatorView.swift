//
//  SMLoadingIndicator.swift
//  SMLoadingHud
//
//  Created by Si Ma on 9/26/17.
//  Copyright © 2017 Si Ma. All rights reserved.
//

import SceneKit

open class SMLoadingIndicatorView: SCNView {
    
    internal var indicator: SMLoadingIndicator = SMCubeIndicator() {
        didSet {
            DispatchQueue.main.async {
                oldValue.stopAnimation()
                oldValue.rootNode.removeFromParentNode()
                self.aScene.rootNode.addChildNode(self.indicator.rootNode)
            }
        }
    }
    
    private var aScene: SCNScene!
    
    
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
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    // MARK: <#Scene & Camera Setup#>
    private func setup() {
        self.setupScene()
        self.setupCamera()
        self.aScene.rootNode.addChildNode(self.indicator.rootNode)
    }
    
    private func setupScene() {
        self.backgroundColor = .clear
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.aScene = SCNScene()
        self.aScene.background.contents = UIColor.clear
        self.scene = self.aScene
    }
    
    /// Warning: Changing camera's position will have impact on the presentation of all indicators
    private func setupCamera() {
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 6)
        self.aScene.rootNode.addChildNode(cameraNode)
    }
}

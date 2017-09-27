//
//  SMLoadingCube.swift
//  SMLoadingHud
//
//  Created by Si Ma on 9/26/17.
//  Copyright © 2017 Si Ma. All rights reserved.
//

import SceneKit

class SMLoadingCubeView: SMLoadingIndicatorView {
    
    override internal func buildObject() {
        super.buildObject()
        
        for x in 0..<3 {
            for y in 0..<3 {
                for z in 0..<3 {
                    let sphere = SCNSphere(radius: 0.17)
                    if x == 0 {
                        sphere.materials.first?.diffuse.contents = UIColor(white: 0.7, alpha: 1.0)
                    } else if x == 1 {
                        sphere.materials.first?.diffuse.contents = UIColor(white: 0.85, alpha: 1.0)
                    } else {
                        sphere.materials.first?.diffuse.contents = UIColor.white
                    }
                    
                    let sphereNode = SCNNode(geometry: sphere)
                    sphereNode.position = SCNVector3(x: Float(x-1), y: Float(y-1), z: Float(z-1))
                    self.objectNode.addChildNode(sphereNode)
                }
            }
        }
        
        self.objectNode.pivot = SCNMatrix4MakeRotation(Float.pi/4, 0.0, 0.0, 1.0)
        self.objectNode.eulerAngles = SCNVector3(x: 0, y: 0, z: Float.pi / 4)
    }
    
    // MARK: <#Animation#>
    override func startAnimation() {
        let action = SCNAction.rotateBy(x: 0.0, y: 1.0, z: 1.0, duration: 0.7)
        self.objectNode.runAction(SCNAction.repeatForever(action), forKey: self.actionKey)
    }
    
    override func stopAnimation() {
        self.objectNode.removeAction(forKey: self.actionKey)
    }
}

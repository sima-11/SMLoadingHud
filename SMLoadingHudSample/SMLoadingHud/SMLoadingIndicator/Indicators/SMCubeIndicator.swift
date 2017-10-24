//
//  SMCubeIndicator.swift
//  SMLoadingHud
//
//  Created by Si Ma on 9/29/17.
//  Copyright © 2017 Si Ma. All rights reserved.
//

import SceneKit

class SMCubeIndicator: SMLoadingIndicator {
    
    override var type: SMLoadingIndicatorType { return .cube }
    
    override func buildIndicator() {
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
                    self.rootNode.addChildNode(sphereNode)
                }
            }
        }
    }
    
    override func buildAction() {
        self.action = SCNAction.rotateBy(x: 0.0, y: 1.0, z: 1.0, duration: 0.7)
    }
}

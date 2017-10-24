//
//  SMLoadingIndicatorCreation.swift
//  SMLoadingHudSample
//
//  Created by Si Ma on 10/24/17.
//  Copyright © 2017 Si Ma. All rights reserved.
//

import Foundation

public protocol SMLoadingIndicatorCreation {
    var type: SMLoadingIndicatorType { get }
    func buildIndicator()
    func buildAction()
}

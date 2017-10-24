//
//  ViewController.swift
//  SMLoadingHudSample
//
//  Created by Si Ma on 9/26/17.
//  Copyright © 2017 Si Ma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let background = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0))
        background.backgroundColor = .red
        SMLoadingHud.setBackgroundView(view: background)
        SMLoadingHud.presentWithText("Loading")
    }
}


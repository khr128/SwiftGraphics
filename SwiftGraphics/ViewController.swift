//
//  ViewController.swift
//  SwiftGraphics
//
//  Created by khr on 4/23/15.
//  Copyright (c) 2015 khr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    (view as! GraphicsView).createPoints()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}


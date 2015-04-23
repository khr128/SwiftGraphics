//
//  ViewController.swift
//  SwiftGraphics
//
//  Created by khr on 4/23/15.
//  Copyright (c) 2015 khr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var timerSource: dispatch_source_t = 0;
  let deltaTMsec:UInt64 = 10;

  override func viewDidLoad() {
    super.viewDidLoad()

    let graphicsView = (view as! GraphicsView)
    graphicsView.createPoints()

    var l:Int8 = 12
    var q = dispatch_queue_create(&l, DISPATCH_QUEUE_SERIAL)
    timerSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, q)
    dispatch_source_set_timer(timerSource, dispatch_time(DISPATCH_TIME_NOW, 0), deltaTMsec*NSEC_PER_MSEC, 0);

    dispatch_source_set_event_handler(timerSource, {
       dispatch_async(dispatch_get_main_queue(), {
        graphicsView.movePoints(CGFloat(self.deltaTMsec)/1000.0)
      });
    });

    dispatch_resume(timerSource);
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}


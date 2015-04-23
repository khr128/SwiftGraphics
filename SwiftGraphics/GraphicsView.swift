//
//  GraphicsView.swift
//  SwiftGraphics
//
//  Created by khr on 4/23/15.
//  Copyright (c) 2015 khr. All rights reserved.
//

import UIKit

class GraphicsView: UIView {
  var points = [CGPoint]()
  var velocities = [CGPoint]()
  let maxSpeed = 10 as CGFloat;
  var pointCount = 10;

  func randomPointInRect(rect: CGRect) -> CGPoint {
    return CGPointMake(
      rect.origin.x + CGFloat(rand())*rect.width/CGFloat(RAND_MAX),
      rect.origin.y + CGFloat(rand())*rect.height/CGFloat(RAND_MAX))
  }

  func randomVelocity() -> CGPoint {
    return CGPointMake(
      CGFloat(rand())*maxSpeed/CGFloat(RAND_MAX),
      CGFloat(rand())*maxSpeed/CGFloat(RAND_MAX))
  }

  func seedRandWithCurrentTime() {
    var pt = UnsafeMutablePointer<time_t>.alloc(1)
    time(pt)
    srand(UInt32(pt.move()))
  }
  
  func createPoints() {
    seedRandWithCurrentTime()
    for _ in 1...pointCount {
      points.append(randomPointInRect(frame))
      velocities.append(randomVelocity())
    }
  }

  override func drawRect(rect: CGRect) {
    var context = UIGraphicsGetCurrentContext()
    CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
    CGContextAddLines(context, points, pointCount)
    CGContextClosePath(context)
    CGContextStrokePath(context)
  }
}

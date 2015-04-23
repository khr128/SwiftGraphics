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
  let maxSpeed = 100.0 as CGFloat;
  var pointCount = 11;

  func randomPointInRect(rect: CGRect) -> CGPoint {
    return CGPointMake(
      rect.origin.x + CGFloat(rand())*rect.width/CGFloat(RAND_MAX),
      rect.origin.y + CGFloat(rand())*rect.height/CGFloat(RAND_MAX))
  }

  func randomVelocity() -> CGPoint {
    return CGPointMake(
      -maxSpeed + CGFloat(rand())*2.0*maxSpeed/CGFloat(RAND_MAX),
      -maxSpeed + CGFloat(rand())*2.0*maxSpeed/CGFloat(RAND_MAX))
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

  func movePoints(deltaT: CGFloat) {
    for i in 0..<pointCount {
      var p = points[i]
      var v = velocities[i];
      p.x += deltaT * v.x
      p.y += deltaT * v.y

      if (p.x < frame.origin.x || p.x > frame.origin.x + frame.width) {
        v.x = -v.x
        velocities[i] = v
      } else if (p.y < frame.origin.y || p.y > frame.origin.y + frame.height) {
        v.y = -v.y
        velocities[i] = v
      }

      points[i] = p
    }
    setNeedsDisplay()
  }

  override func drawRect(rect: CGRect) {
    var context = UIGraphicsGetCurrentContext()
    CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
//    CGContextAddLines(context, points, pointCount)
//    CGContextClosePath(context)
//    CGContextStrokePath(context)

    var bezierPath = UIBezierPath()
    bezierPath.moveToPoint(points.first!)
   for var i=0; i < pointCount-2; i += 2 {
     bezierPath.addQuadCurveToPoint(points[i+2], controlPoint:points[i+1])
    }
    bezierPath.addQuadCurveToPoint(points[0], controlPoint:points[pointCount-2])
    bezierPath.stroke()
  }
}

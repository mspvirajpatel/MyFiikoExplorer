//
//  ExtensionUIImageView.swift
//  FiikoExplorer
//
//  Created by Viraj on 03/04/17.
//  Copyright © 2017 Viraj. All rights reserved.
//

import UIKit

extension UIView {
  
  //
  // Animation
  //
  
  func getCABasicAnimation(keyPath:String, fromValue:Double, toValue:Double, beginTime:Double, duration:Double, timingFunction:String) -> CABasicAnimation {
    let pathAnimation: CABasicAnimation = CABasicAnimation(keyPath: keyPath)
    pathAnimation.timingFunction = CAMediaTimingFunction(name: timingFunction)
    pathAnimation.beginTime = beginTime
    pathAnimation.duration = CFTimeInterval(duration)
    pathAnimation.fromValue = NSNumber(value: fromValue)
    pathAnimation.toValue = NSNumber(value: toValue)
    pathAnimation.isCumulative = true
    
    return pathAnimation
  }
  
  func addAnimationWithDelay(shapeLayer:CAShapeLayer, keyPath:String, fromValue:Double, toValue:Double, duration:Double, delay:Double, timingFunction:String) {
    self.addChainedAnimations(delay:delay, shapeLayer:shapeLayer, keyPath:[keyPath], fromValue:[fromValue], toValue:[toValue], duration:[duration], timingFunction:[timingFunction])
  }
  
  func addChainedAnimations(delay:Double, shapeLayer:CAShapeLayer, keyPath:[String], fromValue:[Double], toValue:[Double], duration:[Double],timingFunction:[String]) {
    let min = [keyPath.count, fromValue.count, toValue.count, duration.count, timingFunction.count].min()
    let animationGroup: CAAnimationGroup = CAAnimationGroup()
    var beginTime = delay
    var animations:[CABasicAnimation] = []
    for i in 0..<min! {
      let pathAnimation = self.getCABasicAnimation(keyPath:keyPath[i], fromValue:fromValue[i], toValue:toValue[i], beginTime:beginTime, duration:duration[i], timingFunction:timingFunction[i])
      animations.append(pathAnimation)
      beginTime += duration[i]
    }
    animationGroup.animations = animations
    animationGroup.duration = beginTime
    animationGroup.fillMode = kCAFillModeForwards
    animationGroup.isRemovedOnCompletion = false
    shapeLayer.add(animationGroup, forKey: nil)
  }
  
  func animatedDot(withDistance delta: CGFloat, delay: Double, rate:Double) -> CALayer {
    let dot = CAShapeLayer()
    dot.strokeColor = UIColor.cyan.cgColor
    let circlePath = UIBezierPath(arcCenter: CGPoint(x: 0,y: -10), radius: 0.2, startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
    dot.path = circlePath.cgPath
    
    let keyPaths:[String] = ["transform.translation.y", "transform.translation.y", "transform.translation.y"]
    let durations = [rate*1.0, rate*2.0, rate*1.0]
    let fromValues = [0.0, -(Double)(delta), -(Double)(delta)]
    let toValues = [-(Double)(delta), -(Double)(delta), -2*(Double)(delta)]
    let timingFunctions = [kCAMediaTimingFunctionEaseOut, kCAMediaTimingFunctionEaseOut, kCAMediaTimingFunctionEaseOut]
    
    self.addChainedAnimations(delay:delay, shapeLayer: dot, keyPath: keyPaths, fromValue: fromValues, toValue: toValues, duration: durations, timingFunction:timingFunctions)
    
    let keyPaths2:[String] = ["transform.rotation", "transform.rotation", "transform.rotation"]
    let fromValues2 = [0.0, 0.0, M_PI_4]
    let toValues2 = [0.0, M_PI_4, 0]
    
    self.addChainedAnimations(delay:delay, shapeLayer: dot, keyPath: keyPaths2, fromValue: fromValues2, toValue: toValues2, duration: durations, timingFunction:timingFunctions)
    
    self.addChainedAnimations(delay:delay, shapeLayer: dot, keyPath: keyPaths, fromValue: fromValues, toValue: toValues, duration: durations, timingFunction:timingFunctions)
    
    let opacMult = 0.7
    let keyPaths3:[String] = ["opacity", "opacity", "opacity"]
    let fromValues3 = [opacMult*1.0, opacMult*1.0, opacMult*1.0]
    let toValues3 = [opacMult*1.0, opacMult*1.0, 0]
    
    self.addChainedAnimations(delay:delay, shapeLayer: dot, keyPath: keyPaths3, fromValue: fromValues3, toValue: toValues3, duration: durations, timingFunction:timingFunctions)
    
    return dot
  }
  
  func animatedLineFrom(from: CGPoint, to: CGPoint) -> CAShapeLayer {
    let linePath = UIBezierPath()
    linePath.move(to: from)
    linePath.addLine(to: to)
    
    let line = CAShapeLayer()
    line.path = linePath.cgPath
    line.lineCap = kCALineCapRound
    line.strokeColor = UIColor.cyan.cgColor
    
    
    self.addAnimationWithDelay(shapeLayer: line, keyPath: "strokeEnd", fromValue: 0.0, toValue: 1.0, duration: 1.0, delay: 0.0, timingFunction:kCAMediaTimingFunctionEaseOut)
    
    self.addAnimationWithDelay(shapeLayer: line, keyPath: "strokeStart", fromValue: 0.0, toValue: 1.0, duration: 0.75, delay: 0.9, timingFunction:kCAMediaTimingFunctionEaseOut)
    
    line.strokeStart = 1.0
    
    return line
  }
  
  func firework1(at atPoint: CGPoint) -> CAReplicatorLayer {
    let replicator = CAReplicatorLayer()
    replicator.position = atPoint
    
    let f11linePath = UIBezierPath()
    f11linePath.move(to: CGPoint(x: 0, y: -10))
    f11linePath.addLine(to: CGPoint(x: 0, y: -100))
    
    // line 1
    let f11line = CAShapeLayer()
    f11line.path = f11linePath.cgPath
    f11line.strokeColor = UIColor.cyan.cgColor
    replicator.addSublayer(f11line)
    
    replicator.instanceCount = 20
    replicator.instanceTransform = CATransform3DMakeRotation(CGFloat(M_PI/10), 0, 0, 1)
    
    f11line.strokeEnd = 0
    self.addAnimationWithDelay(shapeLayer: f11line, keyPath: "strokeEnd", fromValue: 0.0, toValue: 1.0, duration: 1.0, delay: 0.33, timingFunction:kCAMediaTimingFunctionEaseOut)
    
    self.addAnimationWithDelay(shapeLayer: f11line, keyPath: "strokeStart", fromValue: 0.0, toValue: 1.0, duration: 1.0, delay: 1.0, timingFunction:kCAMediaTimingFunctionEaseIn)
    
    //line path 2
    let f12linePath = UIBezierPath()
    f12linePath.move(to: CGPoint(x: 0, y: -25))
    f12linePath.addLine(to: CGPoint(x: 0, y: -100))
    f12linePath.apply(CGAffineTransform(rotationAngle: CGFloat(M_PI/20)))
    
    let f12line = CAShapeLayer()
    f12line.path = f12linePath.cgPath
    f12line.lineDashPattern = [20, 2]
    f12line.strokeColor = UIColor.cyan.cgColor
    replicator.addSublayer(f12line)
    
    f12line.strokeEnd = 0
    self.addAnimationWithDelay(shapeLayer: f12line, keyPath: "strokeEnd", fromValue: 0.0, toValue: 1.0, duration: 1.0, delay: 0.0, timingFunction:kCAMediaTimingFunctionEaseOut)
    
    self.addAnimationWithDelay(shapeLayer: f12line, keyPath: "strokeStart", fromValue: 0.0, toValue: 0.5, duration: 1.0, delay: 1.0, timingFunction:kCAMediaTimingFunctionEaseIn)
    
    // rotations
    self.addAnimationWithDelay(shapeLayer: f11line, keyPath: "transform.rotation", fromValue: 0.0, toValue: M_PI_4, duration: 2.0, delay: 0.0, timingFunction:kCAMediaTimingFunctionEaseOut)
    self.addAnimationWithDelay(shapeLayer: f12line, keyPath: "transform.rotation", fromValue: 0.0, toValue: M_PI_4/2, duration: 2.0, delay: 0.0, timingFunction:kCAMediaTimingFunctionEaseOut)
    
    return replicator
  }
  
  func firework2(at atPoint: CGPoint) -> CAReplicatorLayer {
    let rand = CGFloat(drand48())
    
    let replicator = CAReplicatorLayer()
    replicator.position = CGPoint(x: atPoint.x, y: 27.0)
    
    replicator.instanceCount = 40
    replicator.instanceTransform = CATransform3DMakeRotation(CGFloat(M_PI/20), 0, 0, 1)
    
    for i in 1...10 {
      replicator.addSublayer(
        animatedDot(withDistance: (rand + 0.2)*CGFloat(i*10), delay: 1/Double(i), rate:0.15)
      )
    }
    
    return replicator
  }
  
  func fireworks() {
//    self.layer.addSublayer(self.firework1(at: self.center))
    self.layer.addSublayer(self.firework2(at: self.center))
  }
  
}

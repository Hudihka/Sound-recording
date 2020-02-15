//
//  ViewController.swift
//  aniation
//
//  Created by Hudihka on 11/02/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

//class ViewController: UIViewController {
//
//    var viewProgress: UIView = UIView()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
//
//    func addView(){
//        viewProgress = UIView(frame: CGRect(x: 0,
//                                            y: 0,
//                                            width: 0,
//                                            height: self.view.frame.height))
//
//        viewProgress.backgroundColor = UIColor.red
//        self.view.addSubview(viewProgress)
//    }
//
//
//    func resizeLayer() {
//
//        addView()
//
//        CATransaction.begin()
//
//        let boundsAnimation = CABasicAnimation(keyPath: "bounds")
//        boundsAnimation.fromValue = NSValue(cgRect: viewProgress.frame)
//        boundsAnimation.toValue = NSValue(cgRect: CGRect(x: 0,
//                                                         y: 0,
//                                                         width: self.view.frame.width,
//                                                         height: self.view.frame.height))
//
//
//
//        CATransaction.setCompletionBlock {
//            print("конец")
//        }
//        boundsAnimation.duration = 5
//
//        self.viewProgress.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
//        viewProgress.layer.add(boundsAnimation, forKey: "boundsAnimate")
//        CATransaction.commit()
//    }
//
//    @IBAction func buttonAction(_ sender: Any) {
//
//
//        self.resizeLayer()
//    }
//
//    @IBAction func pause(_ sender: Any) {
//        viewProgress.layer.pause()
//
//    }
//
//    @IBAction func play(_ sender: Any) {
//        viewProgress.layer.resume()
//
//    }
//
//}
//
//extension CALayer {
//    func pause() {
//        let pausedTime: CFTimeInterval = self.convertTime(CACurrentMediaTime(), from: nil)
//        self.speed = 0.0
//        self.timeOffset = pausedTime
//    }
//
//    func resume() {
//        let pausedTime: CFTimeInterval = self.timeOffset
//        self.speed = 1.0
//        self.timeOffset = 0.0
//        self.beginTime = 0.0
//        let timeSincePause: CFTimeInterval = self.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
//        self.beginTime = timeSincePause
//    }
//}

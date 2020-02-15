//
//  HollVC.swift
//  aniation
//
//  Created by Username on 15.02.2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

class HollVC: UIViewController {

    private var frame: CGRect {
        return view.frame
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addMask()
    }


   private func addMask(){

        let sampleMask = UIView()
        sampleMask.frame = frame
        sampleMask.backgroundColor =  UIColor.black//.withAlphaComponent(0.6)

        self.view.addSubview(sampleMask)
        let maskLayer = CALayer()
        maskLayer.frame = sampleMask.bounds
        let circleLayer = CAShapeLayer()
        //assume the circle's radius is 150
        circleLayer.frame = self.view.frame
        let finalPath = UIBezierPath(roundedRect: frame, cornerRadius: 0)

        let holl = bezierPath(75)//UIBezierPath(ovalIn: CGRect(x:sampleMask.center.x - 150, y:sampleMask.center.y - 150, width: 300, height: 300))
        finalPath.append(holl.reversing())
        circleLayer.path = finalPath.cgPath
        maskLayer.addSublayer(circleLayer)

        sampleMask.layer.mask = maskLayer

    }



    private func bezierPath(_ procent: CGFloat) -> UIBezierPath {

        let startX: CGFloat = 10
        let height = frame.height * procent / 100

        let rect = CGRect(x: startX,
                          y: frame.height - height,
                          width: frame.width - startX,
                          height: height)
        return UIBezierPath(roundedRect: rect, cornerRadius: 0)
    }

}



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

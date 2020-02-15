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

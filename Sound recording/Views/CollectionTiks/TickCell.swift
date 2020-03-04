//
//  TickCell.swift
//  Sound recording
//
//  Created by Hudihka on 16/02/2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import UIKit

class TickCell: UICollectionViewCell {
	
	var procent: CGFloat = 2 {
		didSet{
//			addHold()
		}
	}
	
    private var myFrame: CGRect {
        return contentView.frame
    }
	
	
	private func addHold(){
		
		self.backgroundColor = UIColor.clear
		
		let sampleMask = UIView()
        sampleMask.frame = myFrame
        sampleMask.backgroundColor =  UIColor.black//

        contentView.addSubview(sampleMask)
        let maskLayer = CALayer()
        maskLayer.frame = sampleMask.bounds
        let circleLayer = CAShapeLayer()
		
        circleLayer.frame = self.contentView.frame
        let finalPath = UIBezierPath(roundedRect: myFrame, cornerRadius: 0)

        let holl = bezierPath(procent)
        finalPath.append(holl.reversing())
        circleLayer.path = finalPath.cgPath
        maskLayer.addSublayer(circleLayer)

        sampleMask.layer.mask = maskLayer
	}
	

    private func bezierPath(_ procent: CGFloat) -> UIBezierPath {

        let startX: CGFloat = 1
        let height = myFrame.height * procent / 100

        let rect = CGRect(x: startX,
                          y: frame.height - height,
                          width: frame.width - startX,
                          height: height)
        return UIBezierPath(roundedRect: rect, cornerRadius: 0)
    }
    
}

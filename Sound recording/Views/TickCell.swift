//
//  TickCell.swift
//  Sound recording
//
//  Created by Hudihka on 16/02/2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import UIKit

class TickCell: UICollectionViewCell {
	
	var procent: Int = 10 {
		didSet{
			addHold()
		}
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()

		self.backgroundColor = UIColor.clear
    }
	
	private func addHold(){
		
		let sampleMask = UIView()
        sampleMask.frame = frame
        sampleMask.backgroundColor =  UIColor.black//

        self.view.addSubview(sampleMask)
        let maskLayer = CALayer()
        maskLayer.frame = sampleMask.bounds
        let circleLayer = CAShapeLayer()
        //assume the circle's radius is 150
        circleLayer.frame = self.view.frame
        let finalPath = UIBezierPath(roundedRect: frame, cornerRadius: 0)

        let holl = bezierPath(procent)
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

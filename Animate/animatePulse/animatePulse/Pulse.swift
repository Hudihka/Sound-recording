//
//  Pulse.swift
//  animatePulse
//
//  Created by Hudihka on 13/04/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit

class Pulse: CALayer {
	
	var animateGroup = CAAnimationGroup()
	var initPulseScale: Float = 1
//	var animateDuration: TimeInterval = 0.049
	var animateDuration: TimeInterval = 0.5
	
	
	
	override init(layer: Any) {
		super.init(layer: layer)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	init(view: UIView){
		
		super.init()
		
		
		let animation = CABasicAnimation(keyPath: "transform.scale.xy")
		animation.duration = animateDuration
		animation.repeatCount = 1
		animation.autoreverses = false
		
		let frame = view.frame
		
		self.frame = CGRect(origin: CGPoint(x: 100, y: 100), size: frame.size)
//		self.frame = CGRect(origin: frame.origin, size: frame.size)
		self.cornerRadius = frame.size.width / 2
		
		self.backgroundColor = UIColor(red: 122/255, green: 131/255, blue: 1, alpha: 0.5).cgColor
		
		self.add(animation, forKey: "position")
		
		createScaleAnimmation()
	}
	
	
	func createScaleAnimmation() {
		let scaleanimation = CABasicAnimation(keyPath: "transform.scale.xy")
		
		scaleanimation.fromValue = NSNumber(value: initPulseScale)
		scaleanimation.toValue = NSNumber(value: 2.5)
		scaleanimation.duration = animateDuration
		
		scaleanimation.fillMode = .forwards
		scaleanimation.isRemovedOnCompletion = false
		
		self.add(scaleanimation, forKey: "transform.scale.xy")
	}
	
	
}

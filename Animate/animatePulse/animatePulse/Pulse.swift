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
	var initPulseScale: Float = 0
	var nextPulseAfter: TimeInterval = 0
	var animateDuration: TimeInterval = 1.5
	var radius: CGFloat = 200
	var numberOfPulses: Float = Float.infinity
	
	
	
	override init(layer: Any) {
		super.init(layer: layer)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	init(numberPulses: Float = Float.infinity,
		 radius: CGFloat,
		 position: CGPoint){
		
		super.init()
		
		
		self.backgroundColor = UIColor.blue.cgColor
		self.contentsScale = UIScreen.main.scale
		self.opacity = 0
		self.radius = radius
		self.numberOfPulses = numberPulses
		self.position = position
		
		self.bounds = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
		self.cornerRadius = radius
		
		DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
			self.setupAnimationGroup()
			
			DispatchQueue.main.async {
				self.add(self.animateGroup, forKey: "pulse")
			}
		}
	}
	
	
	func createScaleAnimmation() -> CABasicAnimation{
		let scaleanimation = CABasicAnimation(keyPath: "transform.scale.xy")
		scaleanimation.fromValue = NSNumber(value: initPulseScale)
		scaleanimation.toValue = NSNumber(value: 1)
		scaleanimation.duration = animateDuration
		
		return scaleanimation
	}
	
	func createOpasityAnimmation() -> CAKeyframeAnimation {
		
		let opasityAnimmation = CAKeyframeAnimation(keyPath: "opacity")
		opasityAnimmation.duration = animateDuration
		
		opasityAnimmation.values = [0.4, 0.8, 1]
		opasityAnimmation.keyTimes = [0, 0.2, 1]
		
		
		return opasityAnimmation
	}
	
	func setupAnimationGroup(){
		self.animateGroup = CAAnimationGroup()
		self.animateGroup.duration = animateDuration + nextPulseAfter
		self.animateGroup.repeatCount = numberOfPulses
		
		let defaultCurve = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
		self.animateGroup.timingFunction = defaultCurve
		
		
		self.animateGroup.animations = [createScaleAnimmation(), createOpasityAnimmation()]
	}
	
}

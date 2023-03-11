//
//  Pulse.swift
//  animatePulse
//
//  Created by Hudihka on 13/04/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit

final class Pulse: CALayer {
	
	private var initPulseScale: Float = 1
	private var animateDuration: TimeInterval = 0.49
    
    private var flagBigValue = true
    private var meterTimer:Timer?
    
    private var bigScale: Float?
    private var endScale: Float?
	
	
	override init(layer: Any) {
		super.init(layer: layer)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
    init(
        postion: CGPoint,
        width: CGFloat,
        alpha: CGFloat,
        bigScale: Float,
        endScale: Float
    ){
		super.init()
        
		let animation = CABasicAnimation(keyPath: "transform.scale.xy")
		animation.duration = animateDuration
		animation.repeatCount = 1
		animation.autoreverses = false
        
        self.bigScale = bigScale
        self.endScale = endScale
        
        self.position = postion
        self.backgroundColor = UIColor.green.withAlphaComponent(alpha).cgColor
        
        self.bounds = CGRect(x: 0, y: 0, width: width, height: width)
        self.cornerRadius = width / 2
        
		self.add(animation, forKey: "position")
		
	}
    
    func activateTimer() {
        guard self.meterTimer == nil else {
            return
        }
        
        meterTimer = Timer.scheduledTimer(
            timeInterval: 0.5,
            target:self,
            selector:#selector(self.updateAudioMeter(timer:)),
            userInfo:nil,
            repeats:true
        )
    }
	
    @objc
    func updateAudioMeter(timer: Timer){
        let scale: Float = flagBigValue ? (bigScale ?? 1) : (endScale ?? 1)
        
        createScaleAnimmation(endValue: scale)
        
        flagBigValue = !flagBigValue
    }
    
	private func createScaleAnimmation(endValue: Float) {
		let scaleanimation = createAnimate(endValue: endValue)
		self.add(scaleanimation, forKey: "transform.scale.xy")
	}
	
	private func createAnimate(endValue: Float) -> CABasicAnimation{
		let scaleanimation = CABasicAnimation(keyPath: "transform.scale.xy")
		
		scaleanimation.fromValue = NSNumber(value: initPulseScale)
		scaleanimation.toValue = NSNumber(value: endValue)
		scaleanimation.duration = animateDuration
		if endValue > initPulseScale {
			scaleanimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
		}
		
		initPulseScale = endValue
		
		scaleanimation.fillMode = .forwards
		scaleanimation.isRemovedOnCompletion = false
		
		return scaleanimation
	}
	
	
    deinit {
        meterTimer = nil
    }
}

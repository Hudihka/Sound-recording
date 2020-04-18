//
//  ViewController.swift
//  animatePulse
//
//  Created by Hudihka on 13/04/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
	@IBOutlet weak var passwordTextField: ShakingTextField!
	
	
	@IBOutlet weak var avatarImageView: UIImageView!
	
	var pulse: Pulse?
	var pulseSmall: Pulse?
	
	private var meterTimer:Timer!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		passwordTextField.delegate = self
		
		avatarImageView.isUserInteractionEnabled = true
		avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
		avatarImageView.layer.masksToBounds = true
		
		
	}
	
	
	@objc func updateAudioMeter(timer: Timer){
		if pulse != nil, pulseSmall != nil {
			
			let randomValue = Float(arc4random_uniform(15000))
			
			let bigValue = generateValueLauer(startValue: randomValue, isBig: true)
			let small = generateValueLauer(startValue: randomValue, isBig: false)
			
			self.pulse!.createScaleAnimmation(endValue: bigValue)
			self.pulseSmall!.createScaleAnimmation(endValue: small)
		}
	}
	
	
	@IBAction func record(_ sender: Any) {
		
		self.pulse = Pulse(view: avatarImageView)
		self.pulseSmall = Pulse(view: avatarImageView)
		self.view.layer.insertSublayer(pulseSmall!, below: avatarImageView.layer)
		self.view.layer.insertSublayer(pulse!, below: avatarImageView.layer)
		
		
		meterTimer = Timer.scheduledTimer(timeInterval: 0.075,
										  target:self, selector:#selector(self.updateAudioMeter(timer:)), userInfo:nil, repeats:true)
		
	}
	
	@IBAction func stopRecord(_ sender: Any) {
		
		if pulse != nil, pulseSmall != nil {
			
			meterTimer.invalidate()
			
			self.pulse?.createScaleAnimmationFinal {
				self.pulse?.removeFromSuperlayer()
			}
			
			self.pulseSmall?.createScaleAnimmationFinal {
				self.pulseSmall?.removeFromSuperlayer()
			}
			
		}
		
	}
	
	
	private func generateValueLauer(startValue: Float, isBig: Bool) -> Float{
		let koef: Float = isBig ? 1 : 0.33333
		let generikCoef = startValue * koef
		
		return (generikCoef + 10000.0) / 10000.0
	}


	func textFieldDidBeginEditing(_ textField: UITextField) {
		passwordTextField.shake()
	}
	
	
}


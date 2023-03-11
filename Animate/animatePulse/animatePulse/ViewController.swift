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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		passwordTextField.delegate = self
		
		avatarImageView.isUserInteractionEnabled = true
		avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
		avatarImageView.layer.masksToBounds = true
		
		
	}
	
	
	@IBAction func record(_ sender: Any) {
		
        self.pulse = Pulse(postion: avatarImageView.center, width: 48, alpha: 0.1, bigScale: 2.2, endScale: 1.6)
        self.pulseSmall = Pulse(postion: avatarImageView.center, width: 48, alpha: 0.2, bigScale: 1.8, endScale: 1)
		self.view.layer.insertSublayer(pulseSmall!, below: avatarImageView.layer)
		self.view.layer.insertSublayer(pulse!, below: avatarImageView.layer)
        
        pulse?.activateTimer()
        pulseSmall?.activateTimer()
	}
	
	@IBAction func stopRecord(_ sender: Any) {
		
		if pulse != nil, pulseSmall != nil {
			
//			meterTimer.invalidate()
			
//			self.pulse?.createScaleAnimmationFinal {
//				self.pulse?.removeFromSuperlayer()
//			}
//
//			self.pulseSmall?.createScaleAnimmationFinal {
//				self.pulseSmall?.removeFromSuperlayer()
//			}
			
		}
		
	}
	
	
//	private func generateValueLauer(startValue: Float, isBig: Bool) -> Float{
//		let koef: Float = isBig ? 1 : 0.33333
//		let generikCoef = startValue * koef
//
//		return (generikCoef + 10000.0) / 10000.0
//	}


	func textFieldDidBeginEditing(_ textField: UITextField) {
		passwordTextField.shake()
	}
	
	
}


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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		passwordTextField.delegate = self
		
		avatarImageView.isUserInteractionEnabled = true
		avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
		avatarImageView.layer.masksToBounds = true
		
		
		let tabGestureRecogizer = UITapGestureRecognizer(target: self,
														 action: #selector(ViewController.addPulse))
		
		avatarImageView.addGestureRecognizer(tabGestureRecogizer)
	}
	
	@objc func addPulse(){
		if pulse == nil {
			self.pulse = Pulse(view: avatarImageView)
			self.view.layer.insertSublayer(pulse!, below: avatarImageView.layer)
		} else {
			let value = Float(arc4random_uniform(15000) + 10000) / 10000.0
			self.pulse!.createScaleAnimmation(endValue: value)
		}
	}


	func textFieldDidBeginEditing(_ textField: UITextField) {
		passwordTextField.shake()
	}
	
	
}


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
		let pulse = Pulse(view: avatarImageView)
		
		self.view.layer.insertSublayer(pulse, below: avatarImageView.layer)
	}


	func textFieldDidBeginEditing(_ textField: UITextField) {
		passwordTextField.shake()
	}
	
	
}


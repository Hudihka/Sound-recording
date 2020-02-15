//
//  Int.swift
//  Sound recording
//
//  Created by Hudihka on 16/02/2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation


extension Int {
	
	var timerValue: String {
		
		let countSeconds = self % 60
		let countMinut = self / 60
		
		return "\(countMinut.textCount):\(countSeconds.textCount)"
	}
	
	private var textCount: String{
		return self > 9 ? "\(self)" : "0\(self)"
	}
	
	
}

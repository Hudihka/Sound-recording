//
//  TickCell.swift
//  Sound recording
//
//  Created by Hudihka on 05/03/2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import UIKit

class TickCell: UICollectionViewCell {
	
	@IBOutlet weak var constreint: NSLayoutConstraint!
	var procent: CGFloat = 2 {
		didSet{
			addHold()
		}
	}
	
	
	private func addHold(){
		self.backgroundColor = UIColor.clear
		
		let value = procent <= 5 ? 5 : procent
		
		constreint.constant = self.frame.height * value / 100
	}
	
    
}


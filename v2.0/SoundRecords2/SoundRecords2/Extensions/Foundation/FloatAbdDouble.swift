//
//  FloatAbdDouble.swift
//  GinzaGO
//
//  Created by Username on 20.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation


// MARK: - Double

extension Double {

    func rounded(toPlaces places: Int) -> Double {//округление
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }

	
	var timerValue: String {
		
		let intSelf = Int(self)
		
		let countSeconds = intSelf % 60
		let countMinut = intSelf / 60
		
		return "\(countMinut.textCount):\(countSeconds.textCount)"
	}
	
	
}

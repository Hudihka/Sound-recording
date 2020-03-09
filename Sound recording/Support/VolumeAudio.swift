//
//  VolumeAudio.swift
//  Sound recording
//
//  Created by Hudihka on 09/03/2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation
import AVFoundation

class VolumeAudio {
	
	let minDb: Float = -80.0
	let pauseImageHeight: Float = 2
	var engine = AVAudioEngine()
	
	func scaledPower(power: Float) -> Float {
	  guard power.isFinite else { return 0.0 } //значение не бесконечность

	  if power < minDb {
		return 0.0
	  } else if power >= 1.0 {
		return 1.0
	  } else {
		return (abs(minDb) - abs(power)) / abs(minDb)
	  }
	}
	
	func connectVolumeTap(completion: @escaping(CGFloat) -> Void) {
		
		// 1
		let format = engine.mainMixerNode.outputFormat(forBus: 0)
		// 2
		engine.mainMixerNode.installTap(onBus: 0, bufferSize: 1024, format: format) { buffer, when in
		  // 3
		  guard let channelData = buffer.floatChannelData else {
			  return
		  }

		  let channelDataValue = channelData.pointee
		  // 4
		  let channelDataValueArray = stride(from: 0, to: Int(buffer.frameLength),
											 by: buffer.stride).map{ channelDataValue[$0] }
		  // 5
		  let rms = sqrt(channelDataValueArray.map{ $0 * $0 }.reduce(0, +) / Float(buffer.frameLength))
		  // 6
		  let avgPower = 20 * log10(rms)
		  // 7
		  let meterLevel = self.scaledPower(power: avgPower)

		  DispatchQueue.main.async {
			let value = CGFloat(min((meterLevel * self.pauseImageHeight), self.pauseImageHeight))
			completion(value)
		  }
		}
		
	}
	
	
	
}

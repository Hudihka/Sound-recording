//
//  AudioFile.swift
//  Sound recording
//
//  Created by Username on 06.03.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation
import AVFoundation


struct AudioFile {

	var audioPlayerStruct: AVAudioPlayer?
    var name: String = ""

    init?(url: URL) {
		
		if let audioPlayer = try? AVAudioPlayer(contentsOf: url){
			self.audioPlayerStruct = audioPlayer
			self.name = url.absoluteString.components(separatedBy: "/").last ?? ""
		}
    }


    var duration: String {

        if let duration = audioPlayerStruct?.duration{
			return Int(duration).timerValue
        }

        return "--:--"
    }

    
}

extension AudioFile: Hashable{
	static func == (lhs: AudioFile, rhs: AudioFile) -> Bool {
        return lhs.name == rhs.name
    }
}



extension CMTime{

    var stringFormat: String{

        let count = Int(CMTimeGetSeconds(self))

        return count.timerValue
    }
}

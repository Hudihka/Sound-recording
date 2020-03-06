//
//  AudioFile.swift
//  Sound recording
//
//  Created by Username on 06.03.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation
import MediaPlayer


struct AudioFile {

    private var asset: AVAsset?

    var name: String = ""
    var time: Int = 0

    init(url: URL) {
        self.asset = AVPlayerItem(url: url).asset
        self.name = url.absoluteString.components(separatedBy: "/").last ?? ""
    }


    var duration: String{

        if let duration = asset?.duration{
            return duration.stringFormat
        }

        return "--:--"
    }

    var progressViewDuration: Double {

        if let duration = asset?.duration{
            return Double(CMTimeGetSeconds(duration))
        }

        return 0
    }

    
}



extension CMTime{

    var stringFormat: String{

        let count = Int(CMTimeGetSeconds(self))

        return count.timerValue
    }
}

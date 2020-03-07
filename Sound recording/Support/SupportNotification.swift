//
//  SupportNotification.swift
//  GinzaGO
//
//  Created by Username on 31.01.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import UIKit


enum SupportNotification: String{

    case playFile           = "playFile"
	case stopedFile			= "stopedFile"
	case reloadDataCell	    = "reloadDataCell"

    var nameNotific: NSNotification.Name {
        return NSNotification.Name(self.rawValue)
    }

    func subscribeNotific(observer: Any, selector: Selector){
        NotificationCenter.default.addObserver(observer,
                                               selector: selector,
                                               name: self.nameNotific,
                                               object: nil)
    }

    func notific() {
        NotificationCenter.default.post(name: self.nameNotific, object: nil)
    }
	
	func audioFile(_ file: AudioFile, dataCell: TulpDataCell? = nil){
		
		var userInfo: [String: Any] = ["AudioFile" : file]
		
		if let dataCell = dataCell {
			userInfo["dataCell"] = dataCell
		}
		
		self.notific(userInfo: userInfo)
	}


    private func notific(userInfo: [String: Any]) {
        NotificationCenter.default.post(name: self.nameNotific, object: nil, userInfo: userInfo)
    }

}


extension Notification {

	func thisIsDesiredCell(_ audioFile: AudioFile?) -> Bool {
	
		guard let audioFile = audioFile, let userInfo = self.userInfo?["AudioFile"] as? AudioFile else {
			return false
		}

        return audioFile == userInfo
    }

}


/*

NotificationCenter.default.addObserver(self,
selector: #selector(appExitBacground(notfication:)),
name: UIApplication.willEnterForegroundNotification,
object: nil)

NotificationCenter.default.addObserver(self,
selector: #selector(rebootGoogleMap),
name: .rebootGoogleMap,
object: nil)


@objc func rebootGoogleMap(notfication: Notification) {}

deinit {
NotificationCenter.default.removeObserver(self)
}

*/

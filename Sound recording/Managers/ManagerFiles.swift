//
//  ManagerFiles.swift
//  MP3Player
//
//  Created by Username on 17.01.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation
import AVFoundation


//@objc protocol ProtocolMusic: class {
//    func nextTrack()
//    @objc optional func timeText(muchIsPlaying: String, muchIsLeft: String)
//}

class ManagerFiles: NSObject, AVAudioPlayerDelegate{

    static let shared = ManagerFiles()
    var audioPlayer: AVAudioPlayer?

    var arraySrtuct: [AudioFile] = []

    func initData(){

        print(FileManager.default.linksAudio)

        for link in FileManager.default.linksAudio {
			if let file = AudioFile(url: link){
				arraySrtuct.append(file)
			}
        }

        arraySrtuct = arraySrtuct.sorted(by: {$0.name < $1.name})

    }


    var activePlayer: Bool {
        return self.audioPlayer?.isPlaying ?? false
    }
	
	func playForName(name: String){
		if let index = arraySrtuct.firstIndex(where: {$0.name == name}){
			playFor(index)
		}
	}


    func playFor(_ index: Int){
		
		if let player = arraySrtuct[index].audioPlayerStruct {
			self.audioPlayer = player
			self.audioPlayer?.delegate = self
			audioPlayer?.play()
			//			                self.playIndex = index
			
		}
    }

    func nextTrack(){

    }


//    func prevTrack(){
//
//        guard var index = playIndex else {return}
//
//        index -= 1
//
//        if index == -1 {
//            index = arrayName.count - 1
//        }
//
//        playFor(index)
//        playIndex = index
//    }
//
//    var getActiveStruct: AudioFile? {
//        guard let index = playIndex else {return nil}
//
//        return arraySrtuct[index]
//
//    }






}



extension FileManager {
    private func urls(skipsHiddenFiles: Bool = false ) -> [URL]? {
        let documentsURL = urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURLs = try? contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil, options: skipsHiddenFiles ? .skipsHiddenFiles : [] )
        return fileURLs
    }

    var linksAudio: [URL]{

        guard let array = self.urls()?.filter({$0.absoluteString.contains(expansionAudio)}) else {return []}

        return array

    }
}


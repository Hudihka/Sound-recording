//
//  ManagerFiles.swift
//  MP3Player
//
//  Created by Username on 17.01.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation
import AVFoundation


protocol PlayPauseCellProtocol: class{
	func playFile(file: AudioFile)
	func stopedFile(file: AudioFile)
}


//@objc protocol ProtocolMusic: class {
//    func nextTrack()
//    @objc optional func timeText(muchIsPlaying: String, muchIsLeft: String)
//}

class ManagerFiles: NSObject, AVAudioPlayerDelegate{

    static let shared = ManagerFiles()
    var audioPlayer: AVAudioPlayer?

    var arraySrtuct: [AudioFile] = []
	
	weak var delegateCell: PlayPauseCellProtocol?

    func initData(){

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
	
	private func index(file: AudioFile) -> Int?{
		return arraySrtuct.firstIndex(where: {$0 == file})
	}
	
	/*активный аудиофайл*/
	private var activeAudioFile: AudioFile?{
		return arraySrtuct.first(where: {$0.audioPlayerStruct == self.audioPlayer})
	}
	
	func playForName(file: AudioFile?){
		if let file = file, let index = index(file: file){
			
			if isPlay(file: file){ //если сейчас воспроизводится новый трек то ставим на паузу
				self.audioPlayer?.pause()
				self.delegateCell?.playFile(file: file)
			} else { //иначе выключаем выключаем звук и воспроизводим новый
				
				if audioPlayer != nil, let file = activeAudioFile {
					self.audioPlayer?.stop()
					self.delegateCell?.stopedFile(file: file)
				}
	
				playFor(index)
				self.delegateCell?.playFile(file: file)
			}
		}
	}
	
	func isPlay(file: AudioFile) -> Bool{
		if let index = index(file: file), let player = arraySrtuct[index].audioPlayerStruct{
			return player.isPlaying
		}
		
		return false
	}


    private func playFor(_ index: Int){
		
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


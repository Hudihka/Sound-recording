//
//  ManagerFiles.swift
//  MP3Player
//
//  Created by Username on 17.01.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation
import AVFoundation


class ManagerFiles: NSObject, AVAudioPlayerDelegate{

    static let shared = ManagerFiles()
    var audioPlayer: AVAudioPlayer?

    private var arraySrtuct: [AudioFile] = []

	var timer: Timer?
	
    func initData() -> [AudioFile]{
		
		arraySrtuct = []

        for link in FileManager.default.linksAudio {
			if let file = AudioFile(url: link){
				arraySrtuct.append(file)
			}
        }

        arraySrtuct = arraySrtuct.sorted(by: {$0.name < $1.name})

		return arraySrtuct
    }
	
	//функция которые необходимы при отрисовке ячейки
	
	func baseDesingCell(file: AudioFile) -> (labelTime: String, progressValue: Float){
		let isPl = isPlay(file: file)
		
		let time     = isPl ? audioPlayer?.currentTime : file.audioPlayerStruct?.duration
		let progerss = isPl ? audioPlayer?.currentTime : 0
		
		let progressValue = Float(progerss ?? 0)/Float(audioPlayer?.duration ?? 1)
		
		return (labelTime: Int(time ?? 0).timerValue, progressValue: progressValue)
	}
	
	func isPlay(file: AudioFile) -> Bool{
		if let index = index(file: file), let player = arraySrtuct[index].audioPlayerStruct{
			return player.isPlaying
		}
		
		return false
	}
	
	
	func playForName(file: AudioFile?){
		if let file = file, let index = index(file: file){
			
			if isPlay(file: file){ //если сейчас воспроизводится новый трек то ставим на паузу
				self.audioPlayer?.pause()
				self.timer?.invalidate()
				SupportNotification.playFile.audioFile(file)
			} else { //иначе выключаем выключаем звук и воспроизводим новый
				
				stoped()
	
				playFor(index)
				SupportNotification.playFile.audioFile(file)
			}
		}
	}
	
	
	func stoped() {
		if audioPlayer != nil, let file = activeAudioFile {
			self.audioPlayer?.stop()
			self.timer?.invalidate()
			SupportNotification.stopedFile.audioFile(file)
		}
	}


    private func playFor(_ index: Int){
		
		if let player = arraySrtuct[index].audioPlayerStruct {
			self.audioPlayer = player
			self.audioPlayer?.delegate = self
			audioPlayer?.play()
		}
    }

	
	private func index(file: AudioFile) -> Int?{
		return arraySrtuct.firstIndex(where: {$0 == file})
	}
	
	/*активный аудиофайл*/
	private var activeAudioFile: AudioFile?{
		return arraySrtuct.first(where: {$0.audioPlayerStruct == self.audioPlayer})
	}
	
	
	//MARK- delegate
	
	func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
//		stoped() //если хочешь просто остановить
		nextTrack() //если хочешь автоматически воспроизвести следующий
	}

    private func nextTrack(){
		guard let activeAudioFile = activeAudioFile, let index = index(file: activeAudioFile) else {return}
		
		if let newFile = arraySrtuct[safe: index + 1]{
			playForName(file: newFile)
		} else {
			stoped()
		}

    }

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


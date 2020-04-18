//
//  ManagerFiles.swift
//  MP3Player
//
//  Created by Username on 17.01.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation
import AVFoundation

typealias TulpDataCell = (labelTime: String, progressValue: Float)


class ManagerFiles: NSObject, AVAudioPlayerDelegate{

    static let shared = ManagerFiles()
    var audioPlayer: AVAudioPlayer?

    private var arraySrtuct: [AudioFile] = []

	var timer: Timer?
	
	var initData: [AudioFile]{
		
		arraySrtuct = []
		
		for link in FileManager.default.linksAudio {
			if let file = AudioFile(url: link){
				arraySrtuct.append(file)
			}
        }

		return arraySrtuct
    }
	
	//функция которые необходимы при отрисовке ячейки
	
	func baseDesingCell(file: AudioFile) -> TulpDataCell{
		
		if let index = index(file: file),
			let player = arraySrtuct[index].audioPlayerStruct,
			player == self.audioPlayer {
			return valueActiveTimer
		} else {
			
			return (labelTime: file.durationStruct, progressValue: 0)
		}
	}
	
	func isPlay(file: AudioFile) -> Bool{
		if let index = index(file: file), let player = arraySrtuct[index].audioPlayerStruct{
			return player.isPlaying
		}
		
		return false
	}
	
	
	func playForName(file: AudioFile?){
		if let file = file, let index = index(file: file){
			
			if isPlay(file: file){
				self.audioPlayer?.pause()
				self.timer?.invalidate()
				SupportNotification.playFile.audioFile(file)
			} else { //иначе выключаем выключаем звук и воспроизводим новый
				
//				stoped()
	
				playFor(index)
				SupportNotification.playFile.audioFile(file)
			}
		}
	}
	
	//функция нужна для ситуаций когда мы воспроизводим новый файл,
	// что бы старый файл сделать не активным
	
	func stopedActiveFileFolPlayNew(file: AudioFile?){
		guard let file = file, let active = activeAudioFile, active != file else {return}
		
		stoped()
		
	}
	
	
	func stoped() {
		if audioPlayer != nil, let file = activeAudioFile {
			self.timer?.invalidate()
			self.timer = nil
			self.audioPlayer?.stop()
			SupportNotification.stopedFile.audioFile(file)
		}
	}


    private func playFor(_ index: Int){
		
		if let player = arraySrtuct[index].audioPlayerStruct {
			self.audioPlayer = player
			self.audioPlayer?.delegate = self
			audioPlayer?.play()
			
			self.timer = Timer.scheduledTimer(timeInterval: 0.1,
											  target: self,
											  selector: #selector(actionTimer),
											  userInfo: nil,
											  repeats: true)
			
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
		
		stoped()
		
		if let newFile = arraySrtuct[safe: index + 1]{
			playForName(file: newFile)
		}

    }
	
	
	//MARK - timer

	@objc private func actionTimer() {
		if let file = activeAudioFile{
			SupportNotification.reloadDataCell.audioFile(file, dataCell: valueActiveTimer)
		}
	}
	
	private var valueActiveTimer: TulpDataCell{
		
		let time = audioPlayer?.currentTime ?? 0

		let progressValue = Float(time)/Float(audioPlayer?.duration ?? 1)
		
		return (labelTime: Int(time).timerValue, progressValue: progressValue)
	}
}



extension FileManager {
	
    private func urls(skipsHiddenFiles: Bool = false ) -> [URL]? {
        let documentsURL = urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURLs = try? contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil, options: skipsHiddenFiles ? .skipsHiddenFiles : [] )
		
		return fileURLs
    }

    var linksAudio: [URL]{

        guard var array = self.urls()?.filter({$0.absoluteString.contains(expansionAudio)}) else {return []}
		
		array = array.sorted(by: {date(url: $0) > date(url: $1)})
		
        return array

    }
	
	private func date(url: URL) -> Date{
		
		if let attributes = try? FileManager.default.attributesOfItem(atPath: url.path) as [FileAttributeKey: Any],
		   let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
			return creationDate
		}
		
		return Date(timeIntervalSinceNow: 0)
	}
	
}


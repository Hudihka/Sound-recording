//
//  ManagerRecord.swift
//  Sound recording
//
//  Created by Hudihka on 05/03/2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation
import AVFoundation

class ManagerRecord: NSObject, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
	
//	https://stackoverflow.com/questions/26472747/recording-audio-in-swift
	
	var audioRecorder: AVAudioRecorder!
	var audioPlayer : AVAudioPlayer!
	var meterTimer:Timer!
	var isAudioRecordingGranted: Bool!
	var isRecording = false
	var isPlaying = false
	
	
	func checkRecordPermission(){
		
		switch AVAudioSession.sharedInstance().recordPermission {
		case AVAudioSessionRecordPermission.granted:
			isAudioRecordingGranted = true
			break
		case AVAudioSessionRecordPermission.denied:
			isAudioRecordingGranted = false
			break
		case AVAudioSessionRecordPermission.undetermined:
			AVAudioSession.sharedInstance().requestRecordPermission({ (allowed) in
					if allowed {
						self.isAudioRecordingGranted = true
					} else {
						self.isAudioRecordingGranted = false
					}
			})
			break
		default:
			break
		}
	}
	
	//сохранение запииси
	
	func getDocumentsDirectory() -> URL {
		
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		let documentsDirectory = paths[0]
		return documentsDirectory
	}

	func getFileUrl() -> URL {
	
		let date = Date().printDate(format: "dd MMMM yyy HH:mm:ss")
		let filename = "\(date).m4a"
		let filePath = getDocumentsDirectory().appendingPathComponent(filename)
		return filePath
	}
	
	
	func setupRecorder(){
		
		if isAudioRecordingGranted{
			let session = AVAudioSession.sharedInstance()
			do{
//				try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
				try session.setCategory(AVAudioSession.Category.playAndRecord)
				try session.setActive(true)
				
				let settings = [
					AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
					AVSampleRateKey: 44100,
					AVNumberOfChannelsKey: 2,
					AVEncoderAudioQualityKey:AVAudioQuality.high.rawValue
				]
				audioRecorder = try AVAudioRecorder(url: getFileUrl(), settings: settings)
				audioRecorder.delegate = self
				audioRecorder.isMeteringEnabled = true
				audioRecorder.prepareToRecord()
			} catch let error {
				print(error.localizedDescription)
			}
		}else{
			print("Чувак, дай доступ к микрофону")
		}
	}
	
}

//
//  ManagerRecord.swift
//  Sound recording
//
//  Created by Hudihka on 05/03/2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation
import AVFoundation

protocol AudioRecordProtocol: class {
    func updateLabelTimer(text: String)
}


class ManagerRecord: NSObject, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
	
//	https://stackoverflow.com/questions/26472747/recording-audio-in-swift

    static let shared = ManagerRecord()
	
	var audioRecorder: AVAudioRecorder!

	private var meterTimer:Timer!
    private var startTime: Double = 0

	var isRecording = false

    weak var delegate: AudioRecordProtocol?

	//сохранение запииси
	
	private func getDocumentsDirectory() -> URL {
		
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		let documentsDirectory = paths[0]
		return documentsDirectory
	}

	func getFileUrl() -> URL {
	
		let date = Date().timeIntervalSince1970
		let filename = "\(date)\(expansionAudio)"
		let filePath = getDocumentsDirectory().appendingPathComponent(filename)
		return filePath
	}

    //получение доступа к микрофону
    private func checkRecordPermission(completion: @escaping(Bool?) -> Void){

        switch AVAudioSession.sharedInstance().recordPermission {
        case AVAudioSession.RecordPermission.granted:
            completion(true)
        case AVAudioSession.RecordPermission.denied:
            completion(false)
        case AVAudioSession.RecordPermission.undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission({ (allowed) in
                completion(nil)
            })
        default:
            break
        }

    }

    //запись

    private func record(){

        if isRecording {
            return
        }

        let session = AVAudioSession.sharedInstance()
        do{
            try session.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
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

            audioRecorder.record()
			
//			audioRecorder.averagePower(forChannel: 1)

            isRecording = true
            startTime = Date().timeIntervalSinceReferenceDate

            print("пишем")
            meterTimer = Timer.scheduledTimer(timeInterval: 0.05, target:self, selector:#selector(self.updateAudioMeter(timer:)), userInfo:nil, repeats:true)

        } catch let error {
            print("косяк")
            print(error.localizedDescription)
        }
    }
	
	
	func setupRecorder(){
        checkRecordPermission {(value) in
			
			guard let value = value else {return}
			
            if value {
                self.record()
            } else {
                print("чувак дай доступ")
            }
        }
	}


    @objc func updateAudioMeter(timer: Timer) {
        if audioRecorder.isRecording {

            //если нужны только секунды
//            let time = Int(audioRecorder.currentTime).timerValue
//			print(maxPoverVolue(frame: 100))

            delegate?.updateLabelTimer(text: startTime.countMS)
            audioRecorder.updateMeters()
        }

    }

    func finishAudioRecording(){
        audioRecorder.stop()
        audioRecorder = nil
        meterTimer.invalidate()

        startTime = 0
        isRecording = false

    }
	
	private func maxPoverVolue() -> Float{
		let power = abs(audioRecorder.averagePower(forChannel: 0) + audioRecorder.averagePower(forChannel: 1))
		print("power \(power)")
		
		let procent = max(0, (maxValue - power)/100)
		
		if procent == 0 {
			return 0
		} else {
			/*1,5 это значение которое будет говорит на сколько
			полученный будет больше фрейма к которому применяется */
			
			return 1.5 * procent
		}
		
	}

	
}


extension Double{

    var countMS: String {

        let time = Date().timeIntervalSinceReferenceDate - self
        let sec = time.timerValue
        let timeMS = Int(time.truncatingRemainder(dividingBy: 1) * 100)


        return "\(sec).\(timeMS)"
    }

}

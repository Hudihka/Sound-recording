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
    func buttonRecord()
}


class ManagerRecord: NSObject, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
	
//	https://stackoverflow.com/questions/26472747/recording-audio-in-swift

    static let shared = ManagerRecord()
	
	var audioRecorder: AVAudioRecorder!
	var audioPlayer : AVAudioPlayer!

	private var meterTimer:Timer!
    private var startTime: Double = 0

	var isRecording = false
	var isPlaying = false

    weak var delegate: AudioRecordProtocol?

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

    //получение доступа к микрофону
    private func checkRecordPermission(completion: @escaping(Bool) -> Void){

        if AVAudioSession.sharedInstance().recordPermission == AVAudioSession.RecordPermission.undetermined {
            AVAudioSession.sharedInstance().requestRecordPermission({ (allowed) in
                completion(allowed)
            })
        } else {
            completion(false)
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

            isRecording = true
            startTime = Date().timeIntervalSinceReferenceDate

            meterTimer = Timer.scheduledTimer(timeInterval: 0.5, target:self, selector:#selector(self.updateAudioMeter(timer:)), userInfo:nil, repeats:true)
            delegate?.buttonRecord()

        } catch let error {
            print(error.localizedDescription)
        }
    }
	
	
	func setupRecorder(){
        checkRecordPermission {(value) in
            if value {
                self.record()
            } else {
                print("чувак дай доступ")
            }
        }
	}


    @objc func updateAudioMeter(timer: Timer) {
        if audioRecorder.isRecording {

            let time = Int(audioRecorder.currentTime).timerValue

            delegate?.updateLabelTimer(text: "\(time):\(startTime.countMS)")
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

	
}


extension Double{

    var countMS: String {

        let time = Date().timeIntervalSinceReferenceDate - self

        return String(format: "%.2f", time)
    }

}
//
//  TestViewController2.swift
//  Raycast
//
//  Created by Hudihka on 02/04/2020.
//  Copyright © 2020 Razeware. All rights reserved.
//

import UIKit
import AVFoundation
import DSWaveformImage

class TestViewController2: UIViewController {
	
	@IBOutlet weak var viewProgress: ViewProgress!
	var dataArray = [Float]()
	
	var audioPlayer: AVAudioPlayer?
	var duration: Double = 0
	
	private var meterTimer:Timer!
    private var startTime: Double = 0

	override func viewDidLoad() {
		super.viewDidLoad()
		
		//		https://stackoverflow.com/questions/54152300/how-to-make-waveform-for-my-recorded-audio
		
		self.view.backgroundColor = UIColor.blue
		
		let count = viewProgress.countFullTiks
		viewProgress.clipsToBounds = true
		
		
		guard let audioURL = Bundle.main.url(forResource: "Тони Раут & Иван Рейс - Шот", withExtension: "mp3"),
			let waveformAnalyzer = WaveformAnalyzer(audioAssetURL: audioURL) else {
				fatalError("Couldn't find the file path")
		}
		
		//ТО ЧТО ИСКАЛ!!!!
		waveformAnalyzer.samples(count: count) { samples in
			if let samples = samples?.invertProcent {
				DispatchQueue.main.async {
					self.viewProgress.dataArray = samples
					print("sampled down to 10, results are \(samples)")
					
					DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
						self.playFile(url: audioURL)
					}
					
				}
			}
		}
		
	}
    
	private func playFile(url: URL){
		
		if let audioPlayer = try? AVAudioPlayer(contentsOf: url){
			self.audioPlayer = audioPlayer
			
			duration = audioPlayer.duration
			
			self.audioPlayer?.play()
			meterTimer = Timer.scheduledTimer(timeInterval: 0.05, target:self, selector:#selector(self.updateAudioMeter(timer:)), userInfo:nil, repeats:true)
			
		}
		
	}
	
	@objc func updateAudioMeter(timer: Timer) {
		self.startTime += 0.05
		let progress = self.startTime / duration
		self.viewProgress.progressView.setProgress(Float(progress), animated: true)

	}

}



extension Array where Element == Float {
	var reloadProcent: [Float]{
		
		if let max = self.max(by: {$0 < $1}) {
			return self.map({$0 / max})
		}
		
		return []
		
	}
	
	
	var invertProcent: [Float]{
		
		if let max = self.max(by: {abs($0) < abs($1)}) {
			let hunder = abs(max/100)
			return self.map({100 - (abs($0) / hunder)})
		}
		
		return []
		
	}
	
	
}


extension UIView{
	
	var countFullTiks: Int{
		return Int(self.frame.size.width / tickWidth)
	}
	
	
}


//
//  CellAudio.swift
//  Sound recording
//
//  Created by Hudihka on 02/03/2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import UIKit


class CellAudio: UITableViewCell {
	
	@IBOutlet weak var butonPlay: UIButton!
	
	@IBOutlet weak var progressLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	
	@IBOutlet weak var viewProgress: ViewProgress!
	@IBOutlet weak var withViewProgress: NSLayoutConstraint!
	
	let manager = ManagerFiles.shared
	
	var file: AudioFile?{
		didSet{
			desingView()
		}
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
		
		withViewProgress.constant = wDdevice - 78
		viewProgress.clipsToBounds = true
		
		butonPlay.cirkleView()
	
    }

	//MARK desing
	
	private func desingView(){
		guard let file = file else {return}
		
		dateLabel.text = file.name
		progressLabel.text = file.durationStruct
		
		desingButton()
	
		desingProgressView(url: file.url, name: file.name)
		
	}
	
	private func desingButton(){
		guard let file = file else {return}
		
		let imageName = manager.isPlay(file: file) ? "pauseButton" : "play"
		butonPlay.setImage(UIImage(named: imageName), for: .normal)
	}
	
	private func desingProgressView(url: URL?, name: String){
		
		if let audioURL = url, let waveformAnalyzer = WaveformAnalyzer(audioAssetURL: audioURL, name: name) {
			
//			let countSamples = Int(viewProgress.countFullTiks)
			let countSamples = Int(self.withViewProgress.constant / tickWidth)
			
			waveformAnalyzer.samples(count: countSamples) { samples in
				if let samples = samples?.invertProcent {
					self.viewProgress.dataArray = samples
				}
			}
			
		} else {
			viewProgress.isHidden = true
		}
		
	}
	
	
	@IBAction func playButton(_ sender: Any) {
		
		manager.stopedActiveFileFolPlayNew(file: file)
		manager.playForName(file: file)
	}
	
	//MARK: Notification
	

	
	deinit {
		NotificationCenter.default.removeObserver(self)
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



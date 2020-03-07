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
	
	@IBOutlet weak var progressView: UIProgressView!
	
	
	let manager = ManagerFiles.shared
	
	var file: AudioFile?{
		didSet{
			desingView()
		}
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
		
		butonPlay.cirkleView()
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 10)
		
		addCollection()
    }

	//MARK desing
	
	private func addCollection(){
		let customRect = CGRect(x: 68, y: 17, width: wDdevice - 88, height: 20)
			
			let CV = CollectionTiks(frame: customRect)
			
			contentView.addSubview(CV)
	}
	
	private func desingView(){
		guard let file = file else {return}
		
		progressLabel.text = file.duration
		dateLabel.text = file.name
		
		desingButton()
	}
	
	func desingButton(){
		guard let file = file else {return}
		
		let imageName = manager.isPlay(file: file) ? "pauseButton" : "play"
		butonPlay.setImage(UIImage(named: imageName), for: .normal)
	}
	
	@IBAction func playButton(_ sender: Any) {
		
		manager.playForName(file: file)
	}
	
}



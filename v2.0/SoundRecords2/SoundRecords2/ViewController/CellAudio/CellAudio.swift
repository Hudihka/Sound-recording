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
	
	
	let manager = ManagerFiles.shared
	
	var file: AudioFile?{
		didSet{
			desingView()
		}
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
		
		butonPlay.cirkleView()
	
    }

	//MARK desing
	
	private func desingView(){
		guard let file = file else {return}
		
		let tuplData = manager.baseDesingCell(file: file)
		
		progressLabel.text = tuplData.labelTime
		
		dateLabel.text = file.name
		
		desingButton()
	}
	
	func desingButton(){
		guard let file = file else {return}
		
		let imageName = manager.isPlay(file: file) ? "pauseButton" : "play"
		butonPlay.setImage(UIImage(named: imageName), for: .normal)
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



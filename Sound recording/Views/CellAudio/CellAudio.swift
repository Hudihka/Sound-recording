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
	
	var file: AudioFile?{
		didSet{
			desingView()
		}
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
		
		butonPlay.cirkleView()
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 10)
		
		let CV = CollectionTiks(frame: progressView.frame)
		
		contentView.addSubview(CV)
    }

	
	private func desingView(){
		guard let file = file else {return}
		
		progressLabel.text = file.time.timerValue
		dateLabel.text = file.date.printDate(format: "d.MM.yyyy")
	}
	
	@IBAction func playButton(_ sender: Any) {
		self.progressView.setProgress(1, animated: true)
	}
	
}

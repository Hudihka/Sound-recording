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
		
		SupportNotification.playFile.subscribeNotific(observer: self, selector: #selector(play))
		SupportNotification.stopedFile.subscribeNotific(observer: self, selector: #selector(stoped))
		SupportNotification.reloadDataCell.subscribeNotific(observer: self, selector: #selector(reloadDataCell))
    }

	//MARK desing
	
	private func addCollection(){
		let customRect = CGRect(x: 68, y: 17, width: wDdevice - 88, height: 20)
			
			let CV = CollectionTiks(frame: customRect)
			
			contentView.addSubview(CV)
	}
	
	private func desingView(){
		guard let file = file else {return}
		
		let tuplData = manager.baseDesingCell(file: file)
		
		progressLabel.text = tuplData.labelTime
		progressView.setProgress(tuplData.progressValue, animated: false)
		
		
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
	
	//MARK: Notification
	
	@objc func play(notfication: Notification) {
		if notfication.thisIsDesiredCell(file){
			desingButton()
		}
	}
	
	@objc func stoped(notfication: Notification) {
		if notfication.thisIsDesiredCell(file){
			butonPlay.setImage(UIImage(named: "play"), for: .normal)
			progressView.setProgress(0, animated: false)
		}
	}
	
	@objc func reloadDataCell(notfication: Notification) {
		if notfication.thisIsDesiredCell(file), let tupl = notfication.userInfo?["dataCell"] as? TulpDataCell{
			progressLabel.text = tupl.labelTime
			progressView.setProgress(tupl.progressValue, animated: true)
		}
	}

	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}
	
}



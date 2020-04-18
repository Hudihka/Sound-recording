//
//  ViewController.swift
//  SoundRecords2
//
//  Created by Hudihka on 18/04/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	fileprivate let managerRecord = ManagerRecord.shared
	fileprivate let managerFile = ManagerFiles.shared
	
	fileprivate var dataArray = [AudioFile]()

	@IBOutlet weak var viewButton: ViewButtonRecord!
	@IBOutlet weak var labelTime: UILabel!
	
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		dataArray = managerFile.initData
		
		settingsTV()
		settingsViewRecord()
	}

	
	private func settingsViewRecord(){
		
		viewButton.blokStartRecord = {
			self.managerRecord.setupRecorder()
		}
		
		viewButton.blokFinishRecord = {
			self.labelTime.text = nil
			self.managerRecord.finishAudioRecording()
		}
		
		managerRecord.blockUpdateTimmer = {[weak self] time in
			self?.labelTime.text = time
		}
		
		managerRecord.blockUpdatePulse = {[weak self] value in
			self?.viewButton.updateValuePulse(volumeProcent: value)
		}
		
	}

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
	
	fileprivate func settingsTV(){
		
		tableView.baseSettingsTV(obj: self,
								 heghtCell: nil,
								 arrayNameCell: ["CellAudio"],
								 completion: nil)
		
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataArray.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "CellAudio", for: indexPath) as! CellAudio
		cell.file = dataArray[indexPath.row]
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 70
	}
	
	
}


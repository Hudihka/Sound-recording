//
//  ViewController.swift
//  SoundRecords2
//
//  Created by Hudihka on 18/04/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	let managerRecord = ManagerRecord.shared

	@IBOutlet weak var viewButton: ViewButtonRecord!
	@IBOutlet weak var labelTime: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
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


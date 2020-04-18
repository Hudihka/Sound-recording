//
//  ViewController.swift
//  Sound recording
//
//  Created by Username on 15.02.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let managerRecord = ManagerRecord.shared
    let managerAudio = ManagerFiles.shared
	
	@IBOutlet weak var tableView: UITableView!
	var dataArray = [AudioFile]()
	
	@IBOutlet var labelTimer: UILabel!

	@IBOutlet weak var viewButRecord: ViewButtonRecord!
	

    override func viewDidLoad() {
        super.viewDidLoad()

        managerRecord.delegate = self

        dataArray = managerAudio.initData()

		viewButRecord.blokStartRecord = {
			self.playRecord()
		}
		
		viewButRecord.blokFinishRecord = {
			self.finishRecord()
		}

		desingTV()

    }
	
	
    private func playRecord() {
		managerAudio.stoped()
        managerRecord.setupRecorder()
    }

    private func finishRecord() {
        if managerRecord.audioRecorder != nil {
           managerRecord.finishAudioRecording()
		   dataArray = managerAudio.initData()
		   tableView.reloadData()
        }

        self.labelTimer.text = nil
    }



}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
	func desingTV(){
		tableView.baseSettingsTV(obj: self,
								 cellEnabled: false,
								 heghtCell: nil,
								 arrayNameCell: [CellAudio.className],
								 completion: nil)
		
		tableView.rowHeight = 70.0
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataArray.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CellAudio.className, for: indexPath) as! CellAudio
		
		cell.file = dataArray[indexPath.row]
		return cell
	}
}

extension ViewController: AudioRecordProtocol {

    func updateLabelTimer(text: String) {
        labelTimer.text = text
//        if managerRecord.isRecording {
//            self.butRecord.backgroundColor = UIColor.red
//        }
    }
}





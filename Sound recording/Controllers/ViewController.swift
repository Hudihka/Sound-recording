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

	@IBOutlet var butRecord: UIButton!
	

    override func viewDidLoad() {
        super.viewDidLoad()

        butRecord.cirkleView()
        managerRecord.delegate = self


        managerAudio.initData()
        dataArray = managerAudio.arraySrtuct
		
		managerAudio.delegateCell = self


        butRecord.addTarget(self, action: #selector(playRecord(_:)), for: .touchDown)
        butRecord.addTarget(self, action: #selector(finishRecord(_:)), for: .touchUpInside)


		desingTV()

    }
	
    @objc func playRecord(_ button: UIButton) {

        managerRecord.setupRecorder()
    }

    @objc func finishRecord(_ button: UIButton) {
        if managerRecord.audioRecorder != nil {
           managerRecord.finishAudioRecording()
        }

        self.labelTimer.text = nil
        self.butRecord.backgroundColor = UIColor.black
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
        if managerRecord.isRecording {
            self.butRecord.backgroundColor = UIColor.red
        }
    }
}

extension ViewController: PlayPauseCellProtocol{
	
	func playFile(file: AudioFile) {
		if let cell = activeCell(audioFile: file) {
			cell.desingButton()
		}
	}

	func stopedFile(file: AudioFile) {
		if let cell = activeCell(audioFile: file) {
			print(file.name)
			cell.butonPlay.setImage(UIImage(named: "play"), for: .normal)
		}
	}

	private func activeCell(audioFile: AudioFile) -> CellAudio?{
		
		if let cells = self.tableView.visibleCells as? [CellAudio],
			let first = cells.first(where: {$0.file == audioFile}) {
			return first
		}
		
		return nil
	}
}




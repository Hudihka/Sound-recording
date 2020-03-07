//
//  ViewController.swift
//  Sound recording
//
//  Created by Username on 15.02.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let manager = ManagerRecord.shared
    let managerAudio = ManagerFiles.shared
	
	@IBOutlet weak var tableView: UITableView!
	var dataArray = [AudioFile]()
	
	@IBOutlet var labelTimer: UILabel!

	@IBOutlet var butRecord: UIButton!
	

    override func viewDidLoad() {
        super.viewDidLoad()

        butRecord.cirkleView()
        manager.delegate = self


        managerAudio.initData()
        dataArray = managerAudio.arraySrtuct


        butRecord.addTarget(self, action: #selector(playRecord(_:)), for: .touchDown)
        butRecord.addTarget(self, action: #selector(finishRecord(_:)), for: .touchUpInside)


		desingTV()

    }
	
    @objc func playRecord(_ button: UIButton) {

        manager.setupRecorder()
    }

    @objc func finishRecord(_ button: UIButton) {
        if manager.audioRecorder != nil {
           manager.finishAudioRecording()
        }

        self.labelTimer.text = nil
        self.butRecord.backgroundColor = UIColor.black
    }


    @IBAction func test(_ sender: Any) {
        managerAudio.initData()
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
        if manager.isRecording {
            self.butRecord.backgroundColor = UIColor.red
        }
    }

}




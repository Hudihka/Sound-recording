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
	
	@IBOutlet weak var tableView: UITableView!
	var dataArray = [AudioFile]()
	
	@IBOutlet var labelTimer: UILabel!
	@IBOutlet var recordBtnRef: UIButton!

	@IBOutlet var butRecord: UIButton!
	

    override func viewDidLoad() {
        super.viewDidLoad()

        butRecord.cirkleView()
        manager.delegate = self

		
//        for _ in 0...25{
//            dataArray.append(AudioFile())
//        }
//
//        dataArray = dataArray.sorted(by: {$0.date < $1.date})


        

		desingTV()

    }
	
    private func desingButtonRecord(){

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
    }

    func buttonRecord() {
        self.butRecord.backgroundColor = UIColor.red
    }

}


struct AudioFile {
	var date: Date = Date()
	var time: Int = 0
	
	init() {
		let month = Int(1 + arc4random_uniform(11))
		let day = Int(1 + arc4random_uniform(27))
		self.date = Date(day: day, month: month, year: 2019)
		
		self.time = Int(1 + arc4random_uniform(300))
	}
}

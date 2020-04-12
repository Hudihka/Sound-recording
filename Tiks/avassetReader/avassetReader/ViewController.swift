//
//  ViewController.swift
//  avassetReader
//
//  Created by Miguel  Saldana on 3/13/17.
//  Copyright © 2017 miguelDSP. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    @IBOutlet weak var waveFormView: UIView!
    
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		// ...
		
		
		if let file = createBuffer(name: "test", extensionName: "mp3"){
			
			let rect = CGRect(x: 0, y: 20, width: 667, height: 100)
			let viewDraw = DrawWaveform(frame: rect, file: file, countTiks: 200)
			viewDraw.backgroundColor = UIColor.brown
			
			self.view.addSubview(viewDraw)
		}
		
		
	}
	
	
	
	
	
	private func createBuffer(name: String, extensionName: String) -> AVAudioFile? {
		
		if let url = Bundle.main.url(forResource: name, withExtension: extensionName),
			let file = try? AVAudioFile(forReading: url){
			
			return file
		}
		
		return nil
	}
    
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


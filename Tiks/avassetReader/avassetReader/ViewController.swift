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
		
		
		if let buf = createBuffer(name: "piano", extensionName: "caf"){
			let array = Array(UnsafeBufferPointer(start: buf.floatChannelData?[0],
												  count:Int(buf.frameLength)))
			
			readFile.arrayFloatValues = array
		}
		
		
	}
	
	
	private func createBuffer(name: String, extensionName: String) -> AVAudioPCMBuffer? {
		
		if let url = Bundle.main.url(forResource: name, withExtension: extensionName),
			let file = try? AVAudioFile(forReading: url){
			
			guard let format = AVAudioFormat(commonFormat: .pcmFormatFloat32,
									   sampleRate: file.fileFormat.sampleRate,
									   channels: file.fileFormat.channelCount,
									   interleaved: false),
			      let buf = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: UInt32(file.length)) else {
					return nil
			}
			
			
			if ((try? file.read(into: buf)) != nil) {
				return buf
			}
			
			
		}
		
		return nil
		
	}
    
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


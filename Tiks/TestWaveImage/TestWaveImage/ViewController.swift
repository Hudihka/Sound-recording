//
//  ViewController.swift
//  TestWaveImage
//
//  Created by Hudihka on 12/04/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit
import DSWaveformImage

class ViewController: UIViewController {
	
    @IBOutlet weak var bottomWaveformView: UIImageView!

	override func viewDidLoad() {
		super.viewDidLoad()
		addImmage()
	}


	func addImmage(){
		
		let waveformImageDrawer = WaveformImageDrawer()
        let audioURL = Bundle.main.url(forResource: "test", withExtension: "mp3")!

        // always uses background thread rendering

        let configuration = WaveformConfiguration(size: bottomWaveformView.bounds.size,
                                                  color: UIColor.blue,
                                                  style: .filled,
                                                  position: .bottom)

        waveformImageDrawer.waveformImage(fromAudioAt: audioURL, with: configuration) { image in
            DispatchQueue.main.async {
                self.bottomWaveformView.image = image
            }
        }

        //ТО ЧТО ИСКАЛ!!!!
        let waveformAnalyzer = WaveformAnalyzer(audioAssetURL: audioURL)
        waveformAnalyzer?.samples(count: 150) { samples in
            print("sampled down to 10, results are \(samples ?? [])")
        }
		
	}
	
	
}

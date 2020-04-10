//
//  TestViewController2.swift
//  Raycast
//
//  Created by Hudihka on 02/04/2020.
//  Copyright © 2020 Razeware. All rights reserved.
//

import UIKit

class TestViewController2: UIViewController {
	
	@IBOutlet weak var viewProgress: ViewProgress!
	var dataArray = [Float]()

    override func viewDidLoad() {
        super.viewDidLoad()
		
		
		
		
		
		
		
		
		

//        guard let path = Bundle.main.path(forResource: "test", ofType:"mp3") else {
//			fatalError("Couldn't find the file path")
//		}
//
//
//
//
//		let render = Render()
//
//		let url = URL(fileURLWithPath: path)
//		var outputArray : [Float] = []
//		AudioContext.load(fromAudioURL: url, completionHandler: { audioContext in
//
//			guard let audioContext = audioContext else {
//				fatalError("Couldn't create the audioContext")
//			}
//			outputArray = render.render(audioContext: audioContext, targetSamples: 300)
//			print(outputArray)
//
//
////			outputArray = outputArray.map({20 * log10(abs($0))})
////
////			self.dataArray = outputArray.reloadProcent
////
////			DispatchQueue.main.async {
////				self.tableView.reloadData()
////			}
//
//
//		})
    }
	
	
	private func desingProgressView(){
		
		let count = Int(self.viewProgress.frame.size.width / tickWidth)
		let randomArray = (0..<count).map{ _ in Float.random(in: 1 ... 100) }
		
		viewProgress.dataArray = randomArray
		
		
		DispatchQ
	}
    


}



extension Array where Element == Float {
	var reloadProcent: [Float]{
		
		if let max = self.max(by: {$0 < $1}) {
			return self.map({$0 / max})
		}
		
		return []
		
	}
}



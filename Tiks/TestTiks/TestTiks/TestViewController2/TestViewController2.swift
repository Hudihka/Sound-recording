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
		
		
		
		let count = viewProgress.countFullTiks
		viewProgress.clipsToBounds = true
		
		
        guard let path = Bundle.main.path(forResource: "test", ofType:"mp3") else {
			fatalError("Couldn't find the file path")
		}




		let render = Render()

		let url = URL(fileURLWithPath: path)
		var outputArray : [Float] = []
		AudioContext.load(fromAudioURL: url, completionHandler: { audioContext in

			guard let audioContext = audioContext else {
				fatalError("Couldn't create the audioContext")
			}
			
			outputArray = render.render(audioContext: audioContext, targetSamples: count).invertProcent
			print(outputArray)
			
			DispatchQueue.main.async {
				self.viewProgress.dataArray = outputArray
			}
		})
    }
	
	
	private func desingProgressView(){
		
	}
    


}



extension Array where Element == Float {
	var reloadProcent: [Float]{
		
		if let max = self.max(by: {$0 < $1}) {
			return self.map({$0 / max})
		}
		
		return []
		
	}
	
	
	var invertProcent: [Float]{
		
		if let max = self.max(by: {abs($0) < abs($1)}) {
			let hunder = abs(max/100)
			return self.map({abs($0) / hunder})
		}
		
		return []
		
	}
	
	
}


extension UIView{
	
	var countFullTiks: Int{
		return Int(self.frame.size.width / tickWidth)
	}
	
	
}


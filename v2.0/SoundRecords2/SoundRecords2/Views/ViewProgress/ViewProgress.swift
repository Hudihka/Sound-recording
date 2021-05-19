//
//  ViewCancelRescription.swift
//  BC Talk
//
//  Created by Username on 22.01.2020.
//  Copyright © 2020 AITI MEGASTAR. All rights reserved.
//

import UIKit

class ViewProgress: UIView {
	var progressView = UIProgressView()
//
	
	var dataArray: [Float] = [] {
		didSet{
			let rect = CGRect(origin: .zero, size: self.frame.size)
			let collection = CollectionTiks(frame: rect, dataArray: dataArray)
			self.addSubview(collection)
		}
	}

    override init (frame: CGRect) {
        super.init(frame: frame)
		settingsView()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
		settingsView()
    }



	private func settingsView(){
		
		let y = self.frame.height / 2
		
		self.progressView.frame = self.frame
		
		progressView.trackTintColor = UIColor.yellow
		progressView.progressTintColor = UIColor.red
		progressView.progress = 0
		
		self.addSubview(progressView)
		
		progressView.transform = progressView.transform.scaledBy(x: 1, y: y)
	}
	
	

    deinit {
        NotificationCenter.default.removeObserver(self)
    }


}

extension UIView{
	
	var countFullTiks: CGFloat{
		return self.frame.size.width / tickWidth
	}
	
	
}



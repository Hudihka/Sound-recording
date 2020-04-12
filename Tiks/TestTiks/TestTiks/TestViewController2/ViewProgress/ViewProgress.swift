//
//  ViewCancelRescription.swift
//  BC Talk
//
//  Created by Username on 22.01.2020.
//  Copyright © 2020 AITI MEGASTAR. All rights reserved.
//

import UIKit

class ViewProgress: UIView {
    @IBOutlet var counteinerView: UIView!
	var progressView = UIProgressView()
//
//	@IBOutlet weak var progressView: UIProgressView!
	
	var dataArray: [Float] = [] {
		didSet{
			let rect = CGRect(origin: .zero, size: self.frame.size)
			let collection = CollectionTiks(frame: rect, dataArray: dataArray)
			self.counteinerView.addSubview(collection)
		}
	}

    override init (frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
		settingsView()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        xibSetup()
		settingsView()
    }


    private func xibSetup() {
        counteinerView = loadViewFromNib("ViewProgress")
        counteinerView.frame = bounds
        counteinerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(counteinerView )
    }

	private func settingsView(){
		
		let y = self.frame.height / 2
		
		self.progressView.frame = CGRect(x: 0,
										 y: y,
										 width: CGFloat(counteinerView.countFullTiks) * tickWidth,
										 height: 1)
		
		progressView.trackTintColor = UIColor.yellow
		progressView.progressTintColor = UIColor.red
		progressView.progress = 0
		
		self.counteinerView.addSubview(progressView)
		
		
		progressView.transform = progressView.transform.scaledBy(x: 1, y: y)
	}
	
	

    deinit {
        NotificationCenter.default.removeObserver(self)
    }


}





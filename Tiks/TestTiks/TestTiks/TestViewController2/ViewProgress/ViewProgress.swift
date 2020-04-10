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
	@IBOutlet weak var progressView: UIProgressView!
	
	var dataArray: [Float] = [] {
		didSet{
			let rect = CGRect(origin: .zero, size: self.frame.size)
//			let collection = CollectionTiks(frame: rect, dataArray: dataArray)
//			self.counteinerView.addSubview(collection)
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
		progressView.trackTintColor = UIColor.yellow
		progressView.progressTintColor = UIColor.red
		progressView.progress = 0
		
		progressView.transform = progressView.transform.scaledBy(x: 1, y: self.frame.height)
	}
	
	
	
	
	
	


    deinit {
        NotificationCenter.default.removeObserver(self)
    }


}





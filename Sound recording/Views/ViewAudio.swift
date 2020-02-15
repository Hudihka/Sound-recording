//
//  CurtainView.swift
//  twoButton
//
//  Created by Username on 18.12.2019.
//  Copyright © 2019 itMegastar. All rights reserved.
//

import UIKit

class ViewAudio: UIView {
    @IBOutlet var counteinerView: UIView!

    private let textTV = "Введите текст"
    private var keyBakend: String?

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
        counteinerView = loadViewFromNib("ViewAudio")
        counteinerView.frame = bounds
        counteinerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(counteinerView )
    }



    private func settingsView() {

    }


    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}



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
	
	@IBOutlet weak var labelTimer: UILabel!
	@IBOutlet weak var collectionView: UICollectionView!
	

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
		collectionView.baseSettingsCV(obj: self,
									  scrollEnabled: false,
									  clicableCell: false,
									  arrayNameCell: nil)
		collectionView.register(TickCell.self, forCellWithReuseIdentifier: "TickCell")
	}

	@IBAction func buttonPlay(_ sender: Any) {
	}
	
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

extension ViewAudio: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return Int(collectionView.frame.width / tickWidth)
	}
	
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TickCell", for: indexPath) as! TickCell
		
		cell.procent = CGFloat(arc4random_uniform(99))
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
	
	// MARK: - габариты ячеек
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: tickWidth, height: collectionView.frame.height)
	}
	
	
}



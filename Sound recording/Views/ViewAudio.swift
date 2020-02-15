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
		collectionView.reg
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
		
			let cell: CollectionCellDataVC = collectionView.dequeueReusableCell(withReuseIdentifier: "TickCell", for: indexPath) as! TickCell
		
		cell.procent = arc4ra

			return cell
		}

		func collectionView(_ collectionView: UICollectionView,
							layout collectionViewLayout: UICollectionViewLayout,
							minimumLineSpacingForSectionAt section: Int) -> CGFloat {
			return 0
		}

	//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
	//        if let cell = self.collectionView.cellForItem(at: indexPath) {
	//            cell.contentView.backgroundColor = UIColor.clear
	//        }
	//
	//        self.dataTransferDelegate(indexPath)
	//    }


		// MARK: - габариты ячеек

		func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
			return CGSize(width: getWCell(index: indexPath), height: 520)
		}
	
	
	
	
	
	
}



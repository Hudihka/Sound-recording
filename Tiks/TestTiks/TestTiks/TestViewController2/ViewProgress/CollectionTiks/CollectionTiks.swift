//
//  ViewTicks.swift
//  Sound recording
//
//  Created by Username on 17.02.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import UIKit

class CollectionTiks: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	private var dataArray = [Float]()

	init(frame: CGRect, dataArray: [Float]) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: frame, collectionViewLayout: layout)
		
		self.dataArray = dataArray

        self.baseSettingsCV(obj: self,
                                      scrollEnabled: false,
                                      clicableCell: false,
                                      arrayNameCell: ["TickCell"])


        translatesAutoresizingMaskIntoConstraints = false
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        layout.estimatedItemSize = CGSize(width: tickWidth, height: self.frame.height)


        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		//добавляем 2 ячейки что бы перекрыть прогресс вью
		return self.dataArray.count + 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TickCell", for: indexPath) as! TickCell
		
		if let value = dataArray[safe: indexPath.row]{
			cell.procent = CGFloat(value)
		}
		
        return cell
    }


}


extension Collection {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

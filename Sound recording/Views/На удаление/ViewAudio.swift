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
	
	@IBOutlet weak var buttonPlayAndPause: UIButton!
	private var viewProgress: UIView = UIView()
	
	var timeInterval: CFTimeInterval = 10 //измени потом на продолжителность
	var isProgress: Bool? = nil
	
	private var collectionFrame: CGRect {
		return collectionView.frame
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
		counteinerView = loadViewFromNib("ViewAudio")
		counteinerView.frame = bounds
		counteinerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		addSubview(counteinerView )
	}
	
	
	
	private func settingsView() {
		buttonPlayAndPause.cirkleView()
		imageButton()
		collectionView.baseSettingsCV(obj: self,
									  scrollEnabled: false,
									  clicableCell: false,
									  arrayNameCell: nil)
		collectionView.register(TickCell.self, forCellWithReuseIdentifier: "TickCell")
	}
	
	@IBAction func buttonPlay(_ sender: UIButton) {
		if let progress = isProgress {
			reloadButton(progress)
		}else{
			isProgress = true
			imageButton()
			startAnimate()
		}
	}
	
	private func reloadButton(_ progress: Bool?){
		
		guard let progr = progress else {
			isProgress = progress
			imageButton()
			return
		}
		
		isProgress = !progr
		if progr {
			viewProgress.layer.pause()
		} else {
			viewProgress.layer.resume()
		}
		
		imageButton()
	}
	
	private func imageButton(){
		let imagePlay = UIImage(named: "play")
		let immagePayse = UIImage(named: "pauseButton")
		
		if let isProgress = isProgress{
			buttonPlayAndPause.setImage(isProgress ? immagePayse : imagePlay, for: UIControl.State.normal)
		} else {
			buttonPlayAndPause.setImage(imagePlay, for: UIControl.State.normal)
		}
	}
	
	
	private func addView(){
		viewProgress = UIView(frame: progressViewRect(true))
		
		viewProgress.backgroundColor = UIColor.red
		counteinerView.addSubview(viewProgress)
	}
	
	
	private func startAnimate() {
		
		addView()
		
		CATransaction.begin()
		
		let boundsAnimation = CABasicAnimation(keyPath: "bounds")
		boundsAnimation.fromValue = NSValue(cgRect: viewProgress.frame)
		boundsAnimation.toValue = NSValue(cgRect: progressViewRect(false))
		
		
		
		CATransaction.setCompletionBlock {
			self.reloadButton(nil)
		}
		boundsAnimation.duration = timeInterval
		
		self.viewProgress.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
		viewProgress.layer.add(boundsAnimation, forKey: "boundsAnimate")
		CATransaction.commit()
	}
	
	
	private func progressViewRect(_ startFrame: Bool) -> CGRect{
		let collectionFrame = self.collectionView.frame
		
		return CGRect(x: collectionFrame.origin.x,
					  y: collectionFrame.origin.y,
					  width: startFrame ? 0 : collectionFrame.width,
					  height: collectionFrame.height)
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



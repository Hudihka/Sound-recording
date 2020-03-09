//
//

import Foundation
import UIKit


class ViewButtonRecord: UIView, UIGestureRecognizerDelegate {
	
	private let startColor = UIColor.black
	private let finishColor = UIColor.red
	
	private var flagTouchInSide: Bool = false

    override init (frame: CGRect) {
        super.init(frame: frame)
        settingsView()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        settingsView()
    }



    private func settingsView(){
		self.cirkleView()
		self.backgroundColor = startColor
		self.addTabGestures()
    }


    private func addTabGestures(){
        let tap = UILongPressGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.delegate = self
		tap.minimumPressDuration = 0.5
        self.addGestureRecognizer(tap)
    }

    @objc func handleTap(_ sender: UILongPressGestureRecognizer) {

        let rect = self.frame
		let point = sender.location(in: self)
		
		if point.x >= 0, point.y >= 0, point.y <= rect.height, point.x <= rect.width {
			flagTouchInSide = true
		} else {
			flagTouchInSide = false
		}


        switch sender.state {
        case .began:
			animate()
        case .ended:
            action()//вызываем метод если флаг тру
        default:
            break
        }
    }

	
    private func action(){
        if flagTouchInSide{
            flagTouchInSide = false
            animate()
			
			//останавливаем процесс
        }
    }
	
	
	private func animate(){
		
		UIView.animate(withDuration: 0.2,
					   delay: 0,
					   options: [.curveEaseIn],
					   animations: {
						
						self.backgroundColor = self.flagTouchInSide ? self.finishColor : self.startColor
						
						let k: CGFloat = self.flagTouchInSide ? 1.25 : 0.8
						self.transform = CGAffineTransform(scaleX: k, y: k)
		}) { (compl) in
					if compl{
					if self.flagTouchInSide == false {
						print("говорим заканчивай писать")
					} else {
						print("говорим начинай запись")
					}
					
					self.flagTouchInSide = !self.flagTouchInSide
				}
		}
		
	}

}



//
//

import Foundation
import UIKit


class ViewButtonRecord: UIView, UIGestureRecognizerDelegate {
	
	private let startColor = UIColor.black
	private let finishColor = UIColor.red
	
	private var flagTouchInSide: Bool = false
	
	private var pulse: Pulse?
	private var pulseSmall: Pulse?
	
	var blokStartRecord: ()->() = { }
	var blokFinishRecord: ()->() = { }

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
						
						let transform: CGAffineTransform = self.flagTouchInSide ? CGAffineTransform(scaleX: 1.25, y: 1.25) : .identity
						self.transform = transform
		}) {[weak self] (compl) in
			
			guard let selF = self, compl else {
				self?.flagTouchInSide = false
				return
			}
			
			if selF.flagTouchInSide == false {
				selF.dismisPulseLayer()
				selF.blokFinishRecord()
			} else {
				Vibro.weak()
				selF.createLayerPulse()
				selF.blokStartRecord()
			}
			
			selF.flagTouchInSide = !selF.flagTouchInSide
			
		}
		
	}
	
	
	//MARK: Pulse Animate
	
	private func createLayerPulse(){
		
		if let SV = self.superview{
		
		pulse = Pulse(view: self)
		pulseSmall = Pulse(view: self)
		
		SV.layer.insertSublayer(pulseSmall!, below: self.layer)
		SV.layer.insertSublayer(pulse!, below: self.layer)
		}
	}
	
	private func dismisPulseLayer(){
		
		if pulse != nil, pulseSmall != nil {
			
			self.pulse?.createScaleAnimmationFinal {
				self.pulse?.removeFromSuperlayer()
			}
			
			self.pulseSmall?.createScaleAnimmationFinal {
				self.pulseSmall?.removeFromSuperlayer()
			}
		}
	}
	
	func updateValuePulse(volumeProcent: Float){
		let bigValue = generateValueLauer(volumeProcent: volumeProcent, isBig: true)
		let small = generateValueLauer(volumeProcent: volumeProcent, isBig: false)
		
		self.pulse?.createScaleAnimmation(endValue: bigValue)
		self.pulseSmall?.createScaleAnimmation(endValue: small)
	}
	
	private func generateValueLauer(volumeProcent: Float, isBig: Bool) -> Float{
		let koef: Float = isBig ? 1 : 0.33333
		let generikCoef = volumeProcent * koef
		
		//1 это размер вью, максималный для isBig  1 + 1,5
//										для !isBig 1 + 0,5
		
		return generikCoef + 1
	}

}



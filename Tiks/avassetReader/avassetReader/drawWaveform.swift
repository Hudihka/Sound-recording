//
//  Draw2dWaveform.swift
//  Beatmaker
//
//  Created by Miguel Saldana on 10/17/16.
//  Copyright © 2016 Miguel Saldana. All rights reserved.
//

import Foundation
import UIKit
import Accelerate


class DrawWaveform: UIView {
	
    private var arrayFloatValues:[Float] = []
	private var points:[CGFloat] = []
	
	convenience init(frame: CGRect, arrayFloatValues: [Float]) {
		self.init(frame: frame)
		self.arrayFloatValues = arrayFloatValues
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func draw(_ rect: CGRect) {
        self.convertToPoints()
        var f = 0
        
        let aPath = UIBezierPath()
        aPath.lineWidth = 2.0
        aPath.move(to: CGPoint(x:0.0 , y:rect.height/2 ))
        
        
        // print(readFile.points)
        for _ in points{
                //separation of points
			
                var x:CGFloat = 2
                aPath.move(to: CGPoint(x:aPath.currentPoint.x + x , y:aPath.currentPoint.y ))
                
                //Y is the amplitude
			
				let newY = aPath.currentPoint.y - (points[f] * 70) - 1.0
				print("newY \(newY)")
                aPath.addLine(to: CGPoint(x:aPath.currentPoint.x  , y:newY))
                
                aPath.close()
                
                //print(aPath.currentPoint.x)
                x += 1
                f += 1
        }
       
        //If you want to stroke it with a Orange color
        UIColor.orange.set()
        aPath.stroke()
        //If you want to fill it as well
        aPath.fill()
		
		print("f = \(f)")
    }
    
    
    
    
    func readArray( array:[Float]){
        arrayFloatValues = array
    }
    
    func convertToPoints() {
        var processingBuffer = [Float](repeating: 0.0,
                                       count: Int(arrayFloatValues.count))
        let sampleCount = vDSP_Length(arrayFloatValues.count)
        //print(sampleCount)
        vDSP_vabs(arrayFloatValues, 1, &processingBuffer, 1, sampleCount);
        // print(processingBuffer)
        
        
        
        
        // convert do dB
        //    var zero:Float = 1;
        //    vDSP_vdbcon(floatArrPtr, 1, &zero, floatArrPtr, 1, sampleCount, 1);
        //    //print(floatArr)
        //
        //    // clip to [noiseFloor, 0]
        //    var noiseFloor:Float = -50.0
        //    var ceil:Float = 0.0
        //    vDSP_vclip(floatArrPtr, 1, &noiseFloor, &ceil,
        //                   floatArrPtr, 1, sampleCount);
        //print(floatArr)
        
        
        
        var multiplier = 1.0
        print(multiplier)
        if multiplier < 1{
            multiplier = 1.0
            
        }
        
        
        let samplesPerPixel = Int(150 * multiplier)
        let filter = [Float](repeating: 1.0 / Float(samplesPerPixel),
                             count: Int(samplesPerPixel))
        let downSampledLength = Int(arrayFloatValues.count / samplesPerPixel)
        var downSampledData = [Float](repeating:0.0,
                                      count:downSampledLength)
        vDSP_desamp(processingBuffer,
                    vDSP_Stride(samplesPerPixel),
                    filter, &downSampledData,
                    vDSP_Length(downSampledLength),
                    vDSP_Length(samplesPerPixel))
        
        // print(" DOWNSAMPLEDDATA: \(downSampledData.count)")
        
        //convert [Float] to [CGFloat] array
        points = downSampledData.map{CGFloat($0)}
        
        
    }
    
}



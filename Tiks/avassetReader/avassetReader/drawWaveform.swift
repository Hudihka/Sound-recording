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
import AVFoundation


class DrawWaveform: UIView {
	
    private var arrayFloatValues:[Float] = []
	private var points:[CGFloat] = []
	
	convenience init(frame: CGRect, file: AVAudioFile?) {
		self.init(frame: frame)
		
		self.arrayFloatValues = createArray(file: file)
		
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
	
	private func createArray(file: AVAudioFile?) -> [Float]{
		
		guard let file = file,
			  let format = AVAudioFormat(commonFormat: .pcmFormatFloat32,
								   sampleRate: file.fileFormat.sampleRate,
								   channels: file.fileFormat.channelCount,
								   interleaved: false),
			
			  let buf = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: UInt32(file.length)) else {
				return []
		}
		
			//читать весь буффер
		if ((try? file.read(into: buf)) != nil) {
			
			return Array(UnsafeBufferPointer(start: buf.floatChannelData?[0],
											 count:Int(buf.frameLength)))//Текущее количество допустимых выборочных кадров в буфере.
		}
		
		return []
		
	}
	
    override func draw(_ rect: CGRect) {
        self.convertToPoints()
        
        let aPath = UIBezierPath()
        aPath.lineWidth = 2.0
        aPath.move(to: CGPoint(x:0.0 , y:rect.height ))
        
        
//		points это количество столбов
        for point in points{
			
			
				//x это ширина тика
                var x:CGFloat = 4
                aPath.move(to: CGPoint(x:aPath.currentPoint.x + x , y:aPath.currentPoint.y ))
                
                //newY это отступ с верху
				//чем он меньше, тем громче
			
				let newY = aPath.currentPoint.y - (point * 250) - 1.0
				print("newY \(newY)")
                aPath.addLine(to: CGPoint(x:aPath.currentPoint.x  , y:newY))
                
                aPath.close()
                
                //print(aPath.currentPoint.x)
                x += 1
        }
       
        //If you want to stroke it with a Orange color
        UIColor.orange.set()
        aPath.stroke()
        //If you want to fill it as well
        aPath.fill()
		
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

	
        var multiplier = 1.0
		
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
//		изменить число элементов в points
        points = downSampledData.map{CGFloat($0)}
        
        
    }
    
}



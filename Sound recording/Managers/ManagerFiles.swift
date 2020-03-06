//
//  ManagerFiles.swift
//  MP3Player
//
//  Created by Username on 17.01.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation
import AVFoundation


//@objc protocol ProtocolMusic: class {
//    func nextTrack()
//    @objc optional func timeText(muchIsPlaying: String, muchIsLeft: String)
//}

class ManagerFiles: NSObject{

    static let shared = ManagerFiles()
    var audioPlayer: AVAudioPlayer?

    var playIndex: Int? = nil

    private var arrayName: [String] = []
    var arraySrtuct: [AudioFile] = []

    func initData(){

        print(FileManager.default.linksAudio)

        for link in FileManager.default.linksAudio {
            arraySrtuct.append(AudioFile(url: link))
        }

        arraySrtuct = arraySrtuct.sorted(by: {$0.name < $1.name})

    }


    private func getPaths() -> String? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory

        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        return NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true).first
    }


    func loadImageFromDiskWith(name: String) {
        if let dirPath = self.getPaths() {
//            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(name)
//            return image
        }
    }


    var activePlayer: Bool {
        return self.audioPlayer?.isPlaying ?? false
    }


    func playFor(_ index: Int){

//        if let url = arrayName[index].getURL(ofType: "m4a"){
//
//            do {
//                self.audioPlayer = try AVAudioPlayer(contentsOf: url)
//                self.audioPlayer?.delegate = self
//                audioPlayer?.play()
//                self.playIndex = index
//            } catch {
//                print(error)
//            }
//        }
    }

    func nextTrack(){

        guard var index = playIndex else {return}

        index += 1

        if index == arrayName.count {
            index = 0
        }

        playFor(index)
        playIndex = index

    }


//    func prevTrack(){
//
//        guard var index = playIndex else {return}
//
//        index -= 1
//
//        if index == -1 {
//            index = arrayName.count - 1
//        }
//
//        playFor(index)
//        playIndex = index
//    }
//
//    var getActiveStruct: AudioFile? {
//        guard let index = playIndex else {return nil}
//
//        return arraySrtuct[index]
//
//    }






}



extension FileManager {
    private func urls(skipsHiddenFiles: Bool = false ) -> [URL]? {
        let documentsURL = urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURLs = try? contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil, options: skipsHiddenFiles ? .skipsHiddenFiles : [] )
        return fileURLs
    }

    var linksAudio: [URL]{

        guard let array = self.urls()?.filter({$0.absoluteString.contains(expansionAudio)}) else {return []}

        return array

    }
}


//
//  UIAlertController.swift
//  TC5 ЕР
//
//  Created by Username on 23.01.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController{

    func customAlert(_ title: String, subtitle: String?){

        self.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = grayBlock
        self.view.tintColor = colorGrienButton

        self.setValue(NSAttributedString(string: title,
                                         attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: .semibold),
                                                      NSAttributedString.Key.foregroundColor : colorGrienButton]),
                      forKey: "attributedTitle")

        if let message = subtitle{

            self.setValue(NSAttributedString(string: message,
                                             attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: .regular),
                                                          NSAttributedString.Key.foregroundColor : colorGrienButton]),
                          forKey: "attributedMessage")

        }

    }

}

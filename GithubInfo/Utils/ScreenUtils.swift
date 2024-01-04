//
//  ScreenUtils.swift
//  GithubInfo
//
//  Created by Nayab Mehar on 03/01/24.
//

import Foundation
import SwiftUI

let ipadWidth = 393.0
let ipadHeight = 852.0

extension Double {
    func fractionOfHeight() -> Double {
        self * UIScreen.main.bounds.height
    }

    ////
    ///
    /// figma: 300 -> 50
    /// ourPhone.height * 50/300
    func responsiveWidth() -> Double {
        (self / ipadWidth) * UIScreen.main.bounds.width
    }

    func responsiveHeight() -> Double {
        (self / ipadHeight) * UIScreen.main.bounds.height
    }
}

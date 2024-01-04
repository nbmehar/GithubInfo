//
//  TextStyles.swift
//  GithubInfo
//
//  Created by Nayab Mehar on 03/01/24.
//

import Foundation
import SwiftUI

extension Text {
  
  func rmNueueRegular(_ size: CGFloat) -> some View {
    return font(.custom(FontStyles.rmNeue.rawValue, size: size))
  }
  
  func rmNueueBold(_ size: CGFloat) -> some View {
    return font(.custom(FontStyles.rmNeueBold.rawValue, size: size))
  }
  
}

enum FontStyles: String {
  case rmNeue = "RMNeueTRIAL-Regular"
  case rmNeueBold = "RMNeueTRIAL-Bold"
  case rmNeueBoldItalic = "RMNeueTRIAL-BoldItalic"
  case rmNeueLight = "RMNeueTRIAL-Light"
  case rmNeueItalic = "RMNeueTRIAL-Italic"
}

class TextStyles {}

extension View {
  
  func centerText() -> some View {
    return multilineTextAlignment(.center)
  }
  
  func white() -> some View {
    return foregroundStyle(.white)
  }
  
  func black() -> some View {
    return foregroundStyle(.black)
  }
  
}

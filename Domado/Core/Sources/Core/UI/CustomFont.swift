//
//  CustomFont.swift
//  Core
//
//  Created by 이종선 on 11/20/24.
//


import SwiftUI

public struct CustomFont: ViewModifier {
    
    public init(textStyle: TextStyle) {
        self.textStyle = textStyle
    }
    
    var textStyle: TextStyle
    
    var name: String {
        switch textStyle {
        case .headline_lg, .headline_md, .headline_sm, .batterynumber, .headline_xsm:
            return "NEXONLv1GothicOTFBold"
        case .station_lg_bold, .button_lg_bold, .body_md_bold:
            return "Pretendard-Bold"
        case .button_md_semibold:
            return "Pretendard-SemiBold"
        case .body_md_regular, .body_sm_regular, .caption_md_regular:
            return "Pretendard-Regular"
        case .caption_md_semibold:
            return "Pretendard-Medium"
        
        }
    }
    
    var size: CGFloat {
        switch textStyle {
        case .headline_lg:
            return 24
        case .headline_md:
            return 20
        case .headline_sm:
            return 18
        case .batterynumber:
            return 16
        case .headline_xsm:
            return 15
        case .station_lg_bold:
            return 20
        case .button_lg_bold:
            return 18
        case .body_md_bold:
            return 16
        case .button_md_semibold:
            return 16
        case .body_md_regular:
            return 16
        case .body_sm_regular:
            return 14
        case .caption_md_semibold:
            return 14
        case .caption_md_regular:
            return 12
        }
    }
    
    
    public func body(content: Content) -> some View {
        content.font(.custom(name, size: size))
    }
}

public extension View {
    func customFont(_ textStyle: TextStyle) -> some View {
        modifier(CustomFont(textStyle: textStyle))
    }
}

public enum TextStyle {
    case headline_lg
    case headline_md
    case headline_sm
    case batterynumber
    case headline_xsm
    case station_lg_bold
    case button_lg_bold
    case body_md_bold
    case button_md_semibold
    case body_md_regular
    case body_sm_regular
    case caption_md_semibold
    case caption_md_regular
}

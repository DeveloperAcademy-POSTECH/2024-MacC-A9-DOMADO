//
//  SheetDestination.swift
//  Domado
//
//  Created by 이종선 on 11/2/24.
//

import Foundation

/// Sheet 형태로 화면상에 보여줄 화면 목록입니다. 
public enum SheetDestination: Identifiable, Hashable {
    case qrScanner
    
    public var id:String {
        switch self {
        case .qrScanner: return "qrScanner"
    }
    }
}

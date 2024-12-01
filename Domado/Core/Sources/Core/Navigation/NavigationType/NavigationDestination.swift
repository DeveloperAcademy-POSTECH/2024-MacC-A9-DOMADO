//
//  NavigationDestination.swift
//  Domado
//
//  Created by 이종선 on 11/2/24.
//

import Foundation

/// NavigationStack 상에서 push, pop을 통해 이동가능한 화면 목록입니다.
public enum NavigationDestination: Hashable {
    /// 사용중
    case inUse
    /// 일시잠금
    case tempLock
    /// 반납완료
    case returnComplete
    
}

//
//  NavigationDestination.swift
//  Domado
//
//  Created by 이종선 on 11/2/24.
//

import Foundation

/// NavigationStack 상에서 push, pop을 통해 이동가능한 화면 목록입니다.
public enum NavigationDestination: Hashable {
    /// 스테이션 상세 정보
    //TODO: station을 연관값으로 받아 해당 station에 대한 DetailView를 보여줍니다.
    case stationDetail
    /// 사용중
    case inUse
    /// 일시잠금
    case tempLock
    /// 반납완료
    case returnComplete
    
    // MARK:  - Auth View list
    /// 회원가입 
    case singUp
}

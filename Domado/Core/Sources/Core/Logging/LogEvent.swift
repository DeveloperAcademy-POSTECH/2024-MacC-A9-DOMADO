//
//  LogEvent.swift
//  Core
//
//  Created by 이종선 on 9/29/24.
//

import OSLog

/// 로그 메시지의 이벤트를 정의하는 구조체입니다.
///
/// 이 구조체는 로그 메시지, 로그 레벨, 로그 카테고리를 포함하여,
/// 로깅 시스템 내에서 발생하는 모든 로그 이벤트를 캡슐화합니다.
///
/// - 로그 메시지의 구조화: 로그 메시지와 관련된 모든 정보를 한 곳에 모아서 관리할 수 있습니다.
/// - 확장성: 추가적인 로그 관련 정보(예: 타임스탬프, 사용자 정보 등)를 쉽게 추가할 수 있습니다.
///
/// ## 사용 예시:
///
/// ```swift
/// let logEvent = LogEvent(message: "사용자 로그인 성공", type: .info, category: .authentication)
/// ```
public struct LogEvent {
    /// 로그 메시지
    public let message: String
    
    /// 로그의 레벨을 나타내는 `OSLogType`
    public let type: OSLogType
    
    /// 로그의 카테고리
    public let category: LogCategory
    
    /// 로그 이벤트를 초기화합니다.
    ///
    /// - Parameters:
    ///   - message: 로그 메시지
    ///   - type: 로그의 레벨을 나타내는 `OSLogType`
    ///   - category: 로그의 카테고리
    public init(message: String, type: OSLogType, category: LogCategory) {
        self.message = message
        self.type = type
        self.category = category
    }
}


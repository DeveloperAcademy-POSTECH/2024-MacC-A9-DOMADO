//
//  LogCategory.swift
//  Core
//
//  Created by 이종선 on 9/28/24.
//

/// 로그 메시지의 카테고리를 정의하는 구조체입니다.
///
/// 이 구조체는 enum 대신 사용되어 모듈 간 의존성을 줄이고 동적인 카테고리 생성을 가능하게 합니다.
/// 미리 정의된 기본 카테고리를 제공하면서도, 필요에 따라 커스텀 카테고리를 생성할 수 있는 유연성을 제공합니다.
///
/// 이 구조체는 `Sendable` 프로토콜을 채택하여 동시성 환경에서의 안전성을 보장합니다.
/// 구조체의 불변성과 `Sendable` 준수로 인해, 여러 스레드에서 동시에 안전하게 사용할 수 있습니다.
///
/// ## 장점:
/// - 모듈 간 의존성 감소: 새로운 카테고리 추가 시 코어 모듈의 변경이 필요 없음
/// - 동적 카테고리 생성: 런타임에 새로운 카테고리를 쉽게 생성 가능
/// - 확장성: 다른 모듈에서 자유롭게 카테고리 확장 가능
/// - 동시성 안전: `Sendable` 프로토콜 준수로 멀티스레드 환경에서 안전하게 사용 가능
///
/// ## 사용 예시:
///
/// ```swift
/// // 기본 카테고리 사용
/// logger.info("데이터 로딩 완료", category: .database)
///
/// // 커스텀 카테고리 생성 및 사용
/// let paymentCategory = LogCategory.custom("Payment")
/// logger.error("결제 처리 실패", category: paymentCategory)
/// ```
public struct LogCategory: Hashable, Sendable {
    /// 카테고리의 이름
    public let name: String
    
    /// 새로운 LogCategory 인스턴스를 생성합니다.
    /// 이 생성자는 private으로 선언되어 있어, 직접적인 인스턴스 생성을 제한합니다.
    ///
    /// - Parameter name: 카테고리의 이름
    private init(name: String) {
        self.name = name
    }
    
    // MARK: - 기본 카테고리
    
    /// 네트워크 관련 로그를 위한 카테고리
    /// `static` 프로퍼티로 선언되어 타입 수준에서 접근 가능하며, 애플리케이션 전체에서 공유됩니다.
    /// 불변(immutable) 프로퍼티이므로 스레드 안전합니다.
    public static let network = LogCategory(name: "Network")
    
    /// 데이터베이스 관련 로그를 위한 카테고리
    public static let database = LogCategory(name: "Database")
    
    /// 사용자 인터페이스 관련 로그를 위한 카테고리
    public static let ui = LogCategory(name: "UI")
    
    /// 분석 관련 로그를 위한 카테고리
    public static let analytics = LogCategory(name: "Analytics")
    
    /// 일반적인 목적의 로그를 위한 카테고리
    public static let general = LogCategory(name: "General")
    
    /// 동적으로 새로운 카테고리를 생성합니다.
    ///
    /// 이 메서드를 사용하면 런타임에 필요한 새로운 카테고리를 쉽게 만들 수 있습니다.
    /// `static` 메서드로 선언되어 인스턴스 생성 없이 타입 수준에서 호출 가능합니다.
    ///
    /// - Parameter name: 새로운 카테고리의 이름
    /// - Returns: 생성된 LogCategory 인스턴스
    public static func custom(_ name: String) -> LogCategory {
        return LogCategory(name: name)
    }
}

//
//  HTTPMethod.swift
//  Core
//
//  Created by 이종선 on 10/1/24.
//

/// HTTP 요청에 사용되는 메서드를 나타내는 열거형입니다.
///
/// 이 열거형은 RESTful API와 상호 작용할 때 일반적으로 사용되는
/// 주요 HTTP 메서드를 정의합니다. 각 메서드는 특정 작업과 용도에 맞게 설계되었습니다.
public enum HTTPMethod: String {
    /// GET 메서드: 지정된 리소스의 표현을 요청합니다. ( 예: 사용자 프로필 조회 )
    case GET

    /// POST 메서드: 지정된 리소스에 데이터를 제출합니다. ( 예: 새 사용자 등록 )
    case POST

    /// PUT 메서드: 지정된 리소스를 생성하거나 대체합니다. ( 예: 사용자 프로필 전체 업데이트 )
    case PUT

    /// PATCH 메서드: 리소스의 부분적인 수정을 수행합니다. ( 예: 사용자 프로필 부분 업데이트 )
    case PATCH

    /// DELETE 메서드: 지정된 리소스를 삭제합니다. ( 예: 사용자 계정 삭제 )
    case DELETE
}

//
//  File.swift
//  Core
//
//  Created by 이종선 on 11/2/24.
//

/// 하위 계층에서 처리되지 않은 에러 래핑을 위한 AppError의 기본 구현체입니다.
public struct BaseAppError: AppError {
    public let errorDescription: String
    public let errorCode: Int
    
    public init(description: String, code: Int) {
        self.errorDescription = description
        self.errorCode = code
    }
}

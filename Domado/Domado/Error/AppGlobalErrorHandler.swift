//
//  AppGlobalErrorHandler.swift
//  Domado
//
//  Created by 이종선 on 11/3/24.
//

import Core
import Foundation

final class AppGlobalErrorHandler: GlobalErrorHandler {
    private let errorState: GlobalErrorState
    
    init(errorState: GlobalErrorState) {
        self.errorState = errorState
    }
    
    func handleGlobalError(_ error: AppError) {
        errorState.present(error)
    }
    
    func handle(_ error: Error) -> AppError? {
        if let appError = error as? AppError {
            handleGlobalError(appError)
            return nil
        }
        
        // 아래 계층에서 사전에 정의된 에러 타입중 어떠한 타입으로도 캐스팅이 안된 경우 (예상치 못한 에러)
        let unknownError = BaseAppError(description: "알수 없는 오류가 발생했습니다. 잠시 후 다시 시도해주세요.", code: 9999)
        
        handleGlobalError(unknownError)
        return nil
    }
}

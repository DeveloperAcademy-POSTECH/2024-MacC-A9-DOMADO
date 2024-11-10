//
//  AppErrorHandler.swift
//  Domado
//
//  Created by 이종선 on 11/9/24.
//

/// AppGlobalErrorHandler를 wrapping하여 싱글톤 형태로 앱 전역에서 유저에게 쉽게 에러를 표시할 수 있습니다. 
final class AppErrorHandler {
    static let shared = AppErrorHandler()
    private var errorHandler: AppGlobalErrorHandler?
    
    private init() {}
    
    func initialize(errorHandler: AppGlobalErrorHandler) {
        self.errorHandler = errorHandler
    }
    
    func handleError(_ error: Error){
       _ = errorHandler?.handle(error)
    }
}

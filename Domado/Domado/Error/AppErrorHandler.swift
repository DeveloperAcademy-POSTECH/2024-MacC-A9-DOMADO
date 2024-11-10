//
//  AppErrorHandler.swift
//  Domado
//
//  Created by 이종선 on 11/9/24.
//

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

//
//  GlobalErrorState.swift
//  Domado
//
//  Created by 이종선 on 11/3/24.
//

import Core
import Foundation

/// 앱 전역 단위로 에러 상태를 관리합니다.
final class GlobalErrorState: ObservableObject {
    @Published var currentError: AppError?
    @Published var showError: Bool = false
    
    //MARK: 에러 표시 관련 상태 관리
    func present(_ error: AppError){
        currentError = error
        showError = true
    }
    
    func dismiss(){
        currentError = nil
        showError = false
    }
    
    //TODO: 에러 종류별 다른 UI 표시
    
}

//
//  RootDependencies.swift
//  Domado
//
//  Created by 이종선 on 11/3/24.
//

import Core

struct RootDependencies {
    let router: AppRouter
    let globalErrorState: GlobalErrorState
    let globalErrorHandler: GlobalErrorHandler
}

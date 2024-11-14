//
//  Untitled 2.swift
//  Rent
//
//  Created by 고재보 on 11/14/24.
//

import Foundation

/// 반납 가능 여부 확인 결과 DTO
public struct ValidateReturnResult {
   /// 반납 가능 여부
   public let canReturn: Bool
   /// 반납 불가능한 경우의 메시지
   public let message: String?
   
   public init(canReturn: Bool, message: String? = nil) {
       self.canReturn = canReturn
       self.message = message
   }
}

//
//  BaseResponse.swift
//  Core
//
//  Created by 이종선 on 11/19/24.
//

public struct BaseResponse<T: Codable>: Codable {
    public let success: Bool
    public let data: T?
    public let error: String?
}

public struct Nothing: Codable {}

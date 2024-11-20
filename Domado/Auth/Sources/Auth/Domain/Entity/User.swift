//
//  User.swift
//  Auth
//
//  Created by 이종선 on 11/19/24.
//

public struct User: Codable, Sendable{
    let id: Int
    let email: String
    let name: String
    let phone: String
    let status: String
    let roles: [String]
    let hasRegisteredPayments: Bool
    let currentRentalId: Int?
    let stampCount: Int
    let couponCount: Int
    let createdAt: String
    let updatedAt: String
}

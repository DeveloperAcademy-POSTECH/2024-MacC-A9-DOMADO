//
//  AppUser.swift
//  Core
//
//  Created by 이종선 on 11/21/24.
//

public struct AppUser {
    let id: Int
    let name: String
    let hasRegisteredPayments: Bool
    let currentRentalId: Int?
    let stampCount: Int
    let couponCount: Int
    
    public init(id: Int, name: String, hasRegisteredPayments: Bool, currentRentalId: Int? = nil, stampCount: Int, couponCount: Int) {
        self.id = id
        self.name = name
        self.hasRegisteredPayments = hasRegisteredPayments
        self.currentRentalId = currentRentalId
        self.stampCount = stampCount
        self.couponCount = couponCount
    }
}

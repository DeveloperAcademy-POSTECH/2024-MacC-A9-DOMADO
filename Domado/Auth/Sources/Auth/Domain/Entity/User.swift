//
//  File.swift
//  Auth
//
//  Created by 이종선 on 11/19/24.
//

public struct User: Codable {
    let id: String
    let email: String
    let name: String
    
    public init(id: String, email: String, name: String) {
        self.id = id
        self.email = email
        self.name = name
    }
}

//
//  StorageProvider.swift
//  Domado
//
//  Created by 이종선 on 11/5/24.
//

/// 상태 저장소 인터페이스 
protocol StorageProvider {
    func save(_ data: Data, for key: StorageKey) throws
    func read(for key: StorageKey) throws -> Data
    func delete(for key: StorageKey) throws
    func exists(for key: StorageKey) -> Bool
}

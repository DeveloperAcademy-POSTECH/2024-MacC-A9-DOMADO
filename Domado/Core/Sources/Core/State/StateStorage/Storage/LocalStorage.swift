//
//  LocalStorage.swift
//  Domado
//
//  Created by 이종선 on 11/5/24.
//

import Foundation
final class LocalStorage: StorageProvider {
    private let fileManager: FileManager
    private let directory: URL
    private let queue = DispatchQueue(label: "com.domado.localStorage") // 추가된 직렬 큐
    
    init(
        fileManager: FileManager = .default,
        baseDirectory: URL? = nil
    ) throws {
        self.fileManager = fileManager
        
        // baseDirectory가 주입되지 않은 경우 기본 documents 디렉토리 사용
        let documentsDirectory = baseDirectory ?? fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        self.directory = documentsDirectory.appendingPathComponent("LocalStorage", isDirectory: true)
        
        // 초기화 시 디렉토리 생성은 초기화 시점에만 발생하므로 queue.sync 불필요
        if !fileManager.fileExists(atPath: directory.path) {
            do {
                try fileManager.createDirectory(at: directory, withIntermediateDirectories: true)
            } catch {
                throw StorageDomainError.directoryCreationFailed
            }
        }
    }
    
    private func fileURL(for key: StorageKey) -> URL {
        directory.appendingPathComponent(key.rawValue)
    }
    
    func save(_ data: Data, for key: StorageKey) throws {
        try queue.sync {
            do {
                let fileURL = self.fileURL(for: key)
                try data.write(to: fileURL, options: .atomicWrite)
            } catch {
                throw StorageDomainError.saveFailed(key: key)
            }
        }
    }
    
    func read(for key: StorageKey) throws -> Data {
        try queue.sync {
            do {
                let fileURL = self.fileURL(for: key)
                return try Data(contentsOf: fileURL)
            } catch {
                throw StorageDomainError.dataNotFound(key: key)
            }
        }
    }
    
    func delete(for key: StorageKey) throws {
        try queue.sync {
            let fileURL = self.fileURL(for: key)
            if fileManager.fileExists(atPath: fileURL.path) {
                do {
                    try fileManager.removeItem(at: fileURL)
                } catch {
                    throw StorageDomainError.deleteFailed(key: key)
                }
            }
        }
    }
    
    func exists(for key: StorageKey) -> Bool {
        queue.sync {
            fileManager.fileExists(atPath: fileURL(for: key).path)
        }
    }
}

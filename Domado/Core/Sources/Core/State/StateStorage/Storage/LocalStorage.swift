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
    
    init(
        fileManager: FileManager = .default,
        baseDirectory: URL? = nil
    ) throws {
        self.fileManager = fileManager
        
        // baseDirectory가 주입되지 않은 경우 기본 documents 디렉토리 사용
        let documentsDirectory = baseDirectory ?? fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        self.directory = documentsDirectory.appendingPathComponent("LocalStorage", isDirectory: true)
        
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
        do {
            let fileURL = self.fileURL(for: key)
            try data.write(to: fileURL, options: .atomicWrite)
        } catch {
            throw StorageDomainError.saveFailed(key: key)
        }
    }
    
    func read(for key: StorageKey) throws -> Data {
        do {
            let fileURL = self.fileURL(for: key)
            return try Data(contentsOf: fileURL)
        } catch {
            throw StorageDomainError.dataNotFound(key: key)
        }
    }
    
    func delete(for key: StorageKey) throws {
        let fileURL = self.fileURL(for: key)
        if fileManager.fileExists(atPath: fileURL.path) {
            do {
                try fileManager.removeItem(at: fileURL)
            } catch {
                throw StorageDomainError.deleteFailed(key: key)
            }
        }
    }
    
    func exists(for key: StorageKey) -> Bool {
        fileManager.fileExists(atPath: fileURL(for: key).path)
    }
}

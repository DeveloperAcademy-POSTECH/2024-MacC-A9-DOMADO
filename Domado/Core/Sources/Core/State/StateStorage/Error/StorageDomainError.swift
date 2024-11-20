//
//  StorageDomainError.swift
//  Domado
//
//  Created by 이종선 on 11/5/24.
//


/// 상태 저장소 이용시 발생가능한 에러 목록입니다.
public enum StorageDomainError: DomainError {
    case dataNotFound(key: StorageKey)
    case encodingFailed(type: Any.Type)
    case decodingFailed(type: Any.Type)
    case saveFailed(key: StorageKey)
    case deleteFailed(key: StorageKey)
    case directoryCreationFailed

    public var errorDescription: String {
        switch self {
        case .dataNotFound(let key):
            return "데이터를 찾을 수 없습니다: \(key.rawValue)"
        case .encodingFailed(let type):
            return "\(type) 데이터 인코딩에 실패했습니다"
        case .decodingFailed(let type):
            return "\(type) 데이터 디코딩에 실패했습니다"
        case .saveFailed(let key):
            return "데이터 저장에 실패했습니다: \(key.rawValue)"
        case .deleteFailed(let key):
            return "데이터 삭제에 실패했습니다: \(key.rawValue)"
        case .directoryCreationFailed:
            return "저장소 디렉토리 생성에 실패했습니다"
        }
    }
    
    public var errorCode: Int {
        switch self {
        case .dataNotFound: return 1001
        case .encodingFailed: return 1002
        case .decodingFailed: return 1003
        case .saveFailed: return 1004
        case .deleteFailed: return 1005
        case .directoryCreationFailed: return 1006
        }
    }
    
    public var underlyingError: Error? { nil }

}

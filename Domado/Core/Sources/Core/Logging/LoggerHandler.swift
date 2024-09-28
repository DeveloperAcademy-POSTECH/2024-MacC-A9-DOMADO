//
//  File.swift
//  Core
//
//  Created by 이종선 on 9/28/24.
//

/// 로그 핸들러의 기본 인터페이스를 정의하는 프로토콜입니다.
///
/// 이 프로토콜을 준수하는 타입은 로그 메시지를 처리하는 방법을 구현해야 합니다.
/// 예를 들어, 파일에 쓰기, 콘솔에 출력, 네트워크로 전송 등의 동작을 수행할 수 있습니다.
///
/// ## 사용 예시:
///
/// ```swift
/// public class FileLoggerHandler: LoggerHandler {
///     private let fileURL: URL
///
///     public init(fileName: String = "app.log") {
///         let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
///         fileURL = paths[0].appendingPathComponent(fileName)
///     }
///
///     public func handleLog(message: String, category: LogCategory) {
///         let logEntry = "[\(category.name.uppercased())] \(message)\n"
///         if let data = logEntry.data(using: .utf8) {
///             if FileManager.default.fileExists(atPath: fileURL.path) {
///                 if let fileHandle = try? FileHandle(forWritingTo: fileURL) {
///                     defer {
///                         fileHandle.closeFile()
///                     }
///                     fileHandle.seekToEndOfFile()
///                     fileHandle.write(data)
///                 }
///             } else {
///                 try? data.write(to: fileURL, options: .atomic)
///             }
///         }
///     }
/// }
///
/// let fileHandler = FileLoggerHandler(fileName: "myapp.log")
/// fileHandler.handleLog(message: "애플리케이션 시작", category: .general)
/// ```
///
/// 참고: 실제 구현 시 고려해야 할 사항
/// 1. 파일 크기 관리: 로그 파일이 너무 커지지 않도록 로테이션 구현
/// 2. 동시성 처리: 여러 스레드에서 동시에 로그를 쓸 때의 동기화 문제
/// 3. 에러 처리: 파일 쓰기 실패 시의 대응 방안
/// 4. 성능 최적화: 빈번한 파일 I/O를 줄이기 위한 버퍼링 전략
/// 5. 보안: 민감한 정보의 암호화 또는 마스킹
public protocol LoggerHandler {
    /// 로그 메시지를 처리합니다.
    ///
    /// - Parameters:
    ///   - message: 로그 메시지 내용
    ///   - category: 로그 카테고리 (예: network, database, ui)
    func handleLog(message: String, category: LogCategory)
}

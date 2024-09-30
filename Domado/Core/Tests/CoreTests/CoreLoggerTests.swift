import XCTest
@testable import Core
import Foundation

final class CoreLoggerTests: XCTestCase {
    
    // MockLoggerHandler는 LoggerHandler 프로토콜을 준수하며, 로그 이벤트를 기록합니다.
    class MockLoggerHandler: LoggerHandler, @unchecked Sendable {
        var handledEvents: [LogEvent] = []
        
        func handle(logEvent: LogEvent) {
            handledEvents.append(logEvent)
        }
    }
    
    var logger: CoreLogger!
    var mockHandler1: MockLoggerHandler!
    var mockHandler2: MockLoggerHandler!
    
    override func setUp() {
        super.setUp()
        logger = CoreLogger.shared
        mockHandler1 = MockLoggerHandler()
        mockHandler2 = MockLoggerHandler()
        logger.addHandler(mockHandler1)
        logger.addHandler(mockHandler2)
        logger.flush()
    }
    
    override func tearDown() {
        logger.removeHandler()
        mockHandler1.handledEvents.removeAll()
        mockHandler2.handledEvents.removeAll()
        super.tearDown()
    }
    
    // 1. 싱글톤 인스턴스 검증
    func test_shared_returnsSameInstance() {
        // Given: CoreLogger.shared는 setUp에서 이미 초기화됨
        
        // When:
        let logger1 = CoreLogger.shared
        let logger2 = CoreLogger.shared
        
        // Then:
        XCTAssertTrue(logger1 === logger2, "CoreLogger.shared는 동일한 인스턴스를 반환해야 합니다.")
    }
    
    // 2. 로그 레벨 테스트
    func test_logLevels_allLevelsAreHandledByHandlers() {
        // Given: 두 개의 MockLoggerHandler가 setUp에서 logger에 추가됨
        
        // When:
        logger.debug("Debug message", category: .general)
        logger.info("Info message", category: .general)
        logger.warning("Warning message", category: .general)
        logger.error("Error message", category: .general)
        logger.critical("Critical message", category: .general)
        logger.flush()
        
        // Then:
        XCTAssertEqual(mockHandler1.handledEvents.count, 5, "모든 로그 레벨이 handler1에 의해 처리되어야 합니다.")
        XCTAssertEqual(mockHandler2.handledEvents.count, 5, "모든 로그 레벨이 handler2에 의해 처리되어야 합니다.")
        
        let levels = mockHandler1.handledEvents.map { $0.type }
        XCTAssertTrue(levels.contains(.debug), "debug 레벨을 포함해야 합니다.")
        XCTAssertTrue(levels.contains(.info), "info 레벨을 포함해야 합니다.")
        XCTAssertTrue(levels.contains(.default), "warning 레벨을 포함해야 합니다.")
        XCTAssertTrue(levels.contains(.error), "error 레벨을 포함해야 합니다.")
        XCTAssertTrue(levels.contains(.fault), "critical 레벨을 포함해야 합니다.")
    }
    
    // 3. 로그 카테고리 테스트
    func test_logCategories_allCategoriesAreHandledByHandlers() {
        // Given: 두 개의 MockLoggerHandler가 setUp에서 logger에 추가됨
        
        // When:
        logger.info("General message", category: .general)
        logger.info("Network message", category: .network)
        logger.info("Database message", category: .database)
        logger.info("UI message", category: .ui)
        logger.flush()
        
        // Then:
        XCTAssertEqual(mockHandler1.handledEvents.count, 4, "모든 로그 카테고리가 handler1에 의해 처리되어야 합니다.")
        XCTAssertEqual(mockHandler2.handledEvents.count, 4, "모든 로그 카테고리가 handler2에 의해 처리되어야 합니다.")
        
        let categories = mockHandler1.handledEvents.map { $0.category }
        XCTAssertTrue(categories.contains(.general), "general 카테고리를 포함해야 합니다.")
        XCTAssertTrue(categories.contains(.network), "network 카테고리를 포함해야 합니다.")
        XCTAssertTrue(categories.contains(.database), "database 카테고리를 포함해야 합니다.")
        XCTAssertTrue(categories.contains(.ui), "ui 카테고리를 포함해야 합니다.")
    }
    
    // 4. 핸들러 추가 및 호출 테스트
    func test_addHandler_newHandlerIsCalledWhenLogging() {
        // Given: 두 개의 MockLoggerHandler가 setUp에서 logger에 추가됨
        let newMockHandler = MockLoggerHandler()
        
        // When:
        logger.addHandler(newMockHandler)
        logger.info("Test message for multiple handlers", category: .general)
        logger.flush()
        
        // Then:
        XCTAssertEqual(mockHandler1.handledEvents.count, 1, "mockHandler1은 하나의 이벤트를 처리해야 합니다.")
        XCTAssertEqual(mockHandler2.handledEvents.count, 1, "mockHandler2은 하나의 이벤트를 처리해야 합니다.")
        XCTAssertEqual(newMockHandler.handledEvents.count, 1, "newMockHandler는 하나의 이벤트를 처리해야 합니다.")
    }
    
    // 5. flush 메서드 기능 확인
    func test_flush_completesAllLogging() {
        // Given: 초기 설정은 setUp에서 완료됨
        
        // When:
        let numberOfLogs = 500
        for i in 0..<numberOfLogs {
            logger.info("Flush test log \(i)", category: .general)
        }
        logger.flush()
        
        // Then:
        XCTAssertEqual(mockHandler1.handledEvents.count, numberOfLogs, "flush 후 모든 로그가 handler1에 의해 처리되어야 합니다.")
        XCTAssertEqual(mockHandler2.handledEvents.count, numberOfLogs, "flush 후 모든 로그가 handler2에 의해 처리되어야 합니다.")
    }
    
}

import XCTest
@testable import CoordinatorKit

final class CoordinatorLocatorTests: XCTestCase {
    
    // MARK: - Life cycle methods
    
    // MARK: - Tests
    
    func testCoordinatorLocatorPush() {
        let firstChildCoordinator = MockChildCoordinator()
        let secondChildCoordinator = MockChildCoordinator()
        let childLocator: CoordinatorLocatorProtocol = CoordinatorLocator()
        
        childLocator.push(firstChildCoordinator, by: "first")
        childLocator.push(secondChildCoordinator)
        
        XCTAssertTrue(
            childLocator.coordiantors.count == 2,
            "Wrong amount of stored coordiantors. Push doesn't work properly"
        )
    }
    
    func testCoordinatorLocatorPop() {
        let firstChildCoordinator = MockChildCoordinator()
        let secondChildCoordinator = MockChildCoordinator()
        let childLocator: CoordinatorLocatorProtocol = CoordinatorLocator()
        
        childLocator.push(firstChildCoordinator, by: "first")
        childLocator.push(secondChildCoordinator)
        
        childLocator.pop(secondChildCoordinator)
        
        XCTAssertTrue(
            childLocator.coordiantors.count == 1,
            "Wrong amount of stored coordiantors. Pop doesn't work properly"
        )
        
        childLocator.popAll()
        
        XCTAssertTrue(
            childLocator.coordiantors.isEmpty,
            "Wrong amount of stored coordiantors. Pop all doesn't work properly"
        )
    }
    
    func testCoordinatorLocatorReplace() {
        let firstChildCoordinator = MockChildCoordinator()
        let secondChildCoordinator = MockChildCoordinator()
        let childLocator: CoordinatorLocatorProtocol = CoordinatorLocator()
        
        childLocator.push(firstChildCoordinator)
        childLocator.replace(firstChildCoordinator, on: secondChildCoordinator)
        
        XCTAssertTrue(
            childLocator.coordiantors.count == 1,
            "Wrong amount of stored coordiantors. Pop doesn't work properly"
        )
    }
    
    func testCoordinatorLocatorKey() {
        let firstChildCoordinator = MockChildCoordinator()
        let firstKey = "first"
        
        let secondChildCoordinator = MockChildCoordinator()
        let secondKey = String(describing: MockChildCoordinator.self)
        
        let childLocator: CoordinatorLocatorProtocol = CoordinatorLocator()
        
        childLocator.push(firstChildCoordinator, by: firstKey)
        childLocator.push(secondChildCoordinator)
        
        let isFirstHasSameKey = childLocator.key(of: firstChildCoordinator) == firstKey
        let isFirstHasSameAddress = childLocator[firstKey] === firstChildCoordinator
        
        let isSecondHasSameKey = childLocator.key(of: secondChildCoordinator) == secondKey
        let isSecondHasSameAddress = childLocator[secondKey] === secondChildCoordinator
        
        XCTAssertTrue(
            isFirstHasSameKey && isFirstHasSameAddress,
            "Wrong key of first stored coordinator"
        )

        XCTAssertTrue(
            isSecondHasSameKey && isSecondHasSameAddress,
            "Wrong key of second stored coordinator"
        )
    }
}

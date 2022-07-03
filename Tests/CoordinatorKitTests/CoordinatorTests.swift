import XCTest
@testable import CoordinatorKit

final class CoordinatorTests: XCTestCase {
    
    // MARK: - Life cycle methods
    
    // MARK: - Tests
    
    func testCoordinatorLocatorStartAndFinish() {
        let mainCoordinator: Coordinatable = MockMainCoordinator()
        mainCoordinator.start(animated: false)
        
        XCTAssertTrue(
            !mainCoordinator.childLocator.coordiantors.isEmpty,
            "start() function in MockMainCoordinator doesn't work"
        )
        
        mainCoordinator.finish(animated: false)
        
        XCTAssertTrue(
            mainCoordinator.childLocator.coordiantors.isEmpty,
            "finish() function in MockChildCoordinators doesn't work"
        )
    }
}

//
//  MockMainCoordinator.swift
//  
//
//  Created by Тарас Коцур on 22.06.2022.
//

import CoordinatorKit
import UIKit

final class MockMainCoordinator: Coordinatable {
    
    // MARK: - Properties
    
    let tabBarController: UITabBarController
    var rootViewController: UIViewController? { tabBarController }
    var childLocator: CoordinatorLocatorProtocol = CoordinatorLocator()
    var parent: Coordinatable?
    
    // MARK: - Initializers
    
    init(
        tabBarController: UITabBarController = .init()
    ) {
        self.tabBarController = tabBarController
    }
    
    // MARK: - Methods
    
    func start(animated: Bool) {
        let mockChildCoordinator = MockChildCoordinator()
        mockChildCoordinator.delegate = self
        mockChildCoordinator.parent = self
        childLocator.push(mockChildCoordinator)
        start(coordinator: mockChildCoordinator, animated: animated)
        tabBarController.viewControllers = [mockChildCoordinator.navigationController]
    }
    
    
    func finish(animated: Bool) {
        childLocator.coordiantors.forEach { coordinator in
            finish(coordinator: coordinator, animated: animated)
        }
    }
}

extension MockMainCoordinator: MockChildCoordinatorDelegate {
    func didFinishFlow(_ coordinator: MockChildCoordinator) {
        childLocator.pop(coordinator)
    }
}

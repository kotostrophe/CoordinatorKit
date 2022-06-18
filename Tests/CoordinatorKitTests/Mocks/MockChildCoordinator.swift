//
//  MockChildCoordinator.swift
//  
//
//  Created by Тарас Коцур on 22.06.2022.
//

#if os(iOS) || canImport(UIKit)

import Foundation
import CoordinatorKit
import UIKit

protocol MockChildCoordinatorDelegate: AnyObject {
    func didFinishFlow(_ coordinator: MockChildCoordinator)
}

final class MockChildCoordinator: Coordinatable {
    
    // MARK: - Properties
    
    let navigationController: UINavigationController
    var rootViewController: UIViewController? { navigationController }
    var childLocator: CoordinatorLocatorProtocol = CoordinatorLocator()
    weak var parent: Coordinatable?
    weak var delegate: MockChildCoordinatorDelegate?
    
    // MARK: - Initializers
    
    init(
        navigationController: UINavigationController = .init()
    ) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    
    func start(animated: Bool) {
        let view = UIViewController()
        navigationController.pushViewController(view, animated: animated)
    }
    
    func finish(animated: Bool) {
        delegate?.didFinishFlow(self)
    }
}

#endif

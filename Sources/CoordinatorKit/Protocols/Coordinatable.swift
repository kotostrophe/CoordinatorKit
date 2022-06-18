//
//  Coordinatable.swift
//  
//
//  Created by Тарас Коцур on 19.06.2022.
//

#if os(iOS) || canImport(UIKit)

import UIKit

public protocol Coordinatable: AnyObject {
    var rootViewController: UIViewController? { get }
    var childLocator: CoordinatorLocatorProtocol { get }
    var parent: Coordinatable? { get }

    func start(animated: Bool)
    func start(coordinator: Coordinatable, animated: Bool)
    func finish(animated: Bool)
    func finish(coordinator: Coordinatable, animated: Bool)
}

public extension Coordinatable {
    
    func start(coordinator: Coordinatable, animated: Bool = true) {
        coordinator.start(animated: animated)
    }
    
    func finish(coordinator: Coordinatable, animated: Bool = true) {
        coordinator.finish(animated: animated)
    }
}

#endif

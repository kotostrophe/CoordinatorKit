//
//  CoordinatorLocator.swift
//  
//
//  Created by Тарас Коцур on 19.06.2022.
//

#if os(iOS) || canImport(UIKit)

public protocol CoordinatorLocatorProtocol: AnyObject {
    var coordiantors: [Coordinatable] { get }
    
    func key<Coordinator>(
        of coordinator: Coordinator
    ) -> String? where Coordinator: Coordinatable
    
    func push<Coordinator>(
        _ coordinator: Coordinator,
        by key: String
    ) where Coordinator: Coordinatable

    func replace<Coordinator>(
        coordiantor: Coordinator,
        by key: String
    ) where Coordinator: Coordinatable
    
    @discardableResult
    func pop<Coordinator>(
        _ coordinator: Coordinator,
        by key: String
    ) -> Coordinator?
    
    @discardableResult
    func popAll() -> [Coordinatable]
    
    subscript(key: String) -> Coordinatable? { get }
}

extension CoordinatorLocatorProtocol {
    
    public func push<Coordinator>(
        _ coordinator: Coordinator
    ) where Coordinator: Coordinatable {
        let key = String(describing: Coordinator.self)
        push(coordinator, by: key)
    }

    public func replace<Coordinator>(
        _ coordiantor: Coordinator,
        on newCoordinator: Coordinator
    ) where Coordinator: Coordinatable {
        let key = String(describing: Coordinator.self)
        replace(coordiantor: newCoordinator, by: key)
    }
    
    @discardableResult
    public func pop<Coordinator>(_ coordinator: Coordinator) -> Coordinator? {
        let key = String(describing: Coordinator.self)
        return pop(coordinator, by: key)
    }
}

public final class CoordinatorLocator: CoordinatorLocatorProtocol {
    // MARK: - Private properties
    
    private var coordinatorsDictionary: [String: AnyObject] = [:]
    
    // MARK: - Public properties
    
    public var coordiantors: [Coordinatable] {
        coordinatorsDictionary.values.compactMap({ $0 as? Coordinatable })
    }

    // MARK: - Initializers

    public init() {}

    // MARK: - Methods

    public func key<Coordinator>(
        of coordinator: Coordinator
    ) -> String? where Coordinator: Coordinatable {
        coordinatorsDictionary.first(
            where: { key, value in value === coordinator }
        )?.key
    }
    
    public func push<Coordinator>(
        _ coordinator: Coordinator,
        by key: String = String(describing: Coordinator.self)
    ) where Coordinator: Coordinatable {
        coordinatorsDictionary[key] = coordinator
    }

    public func replace<Coordinator>(
        coordiantor: Coordinator,
        by key: String = String(describing: Coordinator.self)
    ) where Coordinator: Coordinatable {
        coordinatorsDictionary.updateValue(coordiantor, forKey: key)
    }
    
    @discardableResult
    public func pop<Coordinator>(
        _ coordinator: Coordinator,
        by key: String = String(describing: Coordinator.self)
    ) -> Coordinator? {
        coordinatorsDictionary.removeValue(forKey: key) as? Coordinator
    }
    
    @discardableResult
    public func popAll() -> [Coordinatable] {
        let tempCoordinators = coordiantors
        coordinatorsDictionary.removeAll()
        return tempCoordinators
    }
    
    public subscript(key: String) -> Coordinatable? {
        coordinatorsDictionary[key] as? Coordinatable
    }
}

#endif

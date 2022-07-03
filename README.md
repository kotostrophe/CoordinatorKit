# CoordinatorKit

[![CI](https://github.com/kotostrophe/CoordinatorKit/actions/workflows/CoordinatorKitTests.yml/badge.svg?branch=main&event=push)](https://github.com/kotostrophe/CoordinatorKit/actions/workflows/CoordinatorKitTests.yml)

Lightweight library to construct node-like structure to start flows. Good solution for non-storyboard projects.

## Navigation

- [Installation](#installation)
    - [Swift Package Manager](#swift-package-manager)
    - [Manually](#manually)
- [Usage](#usage)

## Installation

Ready to use on iOS 9+

### Swift Package Manager

In Xcode go to `File`  → `Packages`  → `Update to Latest Package Versions` and insert url: 

```url
https://github.com/kotostrophe/CoordiantorKit
```

or add it to the `dependencies` value of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/kotostrophe/CoordinatorKit", branch: "main")
]
```


### Manually

If you prefer not to use any of dependency managers, you can integrate manually. Put `Sources/CoordiantorKit` folder in your Xcode project. Make sure to enable `Copy items if needed` and `Create groups`.


## Usage

Use `Coordinatable` protocol as a node to construct tree-like structure. 

```swift
import CoordinatorKit

final class ApplicationCoordinator: Coordinatable {
    ...
}
```

`Coordinatable` protocol requires list of properties and methods that will help you to control the data. All the properties are typed as protocol to achieve `dependency inversion` principle.

```swift
public protocol Coordinatable: AnyObject {
    var rootViewController: UIViewController? { get } // root of view controller (bassically there is UINavigationController)
    var childLocator: CoordinatorLocatorProtocol { get } // object that stores children coordinators
    var parent: Coordinatable? { get } // stores reference to parent coordinator (must be marked as `weak`)

    func start(animated: Bool) // methods that start life cycle of this coordiantor
    func finish(animated: Bool) // method uses to finish all the proceses inside of this coordinator
}
```

Example, how can look initial point of application.

```swift
final class ApplicationCoordinator: Coordinatable {
    
    // MARK: - Private properties
    
    unowned private var window: UIWindow
    
    // MARK: - Public properties
    
    var rootViewController: UIViewController? { window.rootViewController }
    var childLocator: CoordinatorLocatorProtocol = CoordinatorLocator()
    weak var parent: Coordinatable?
    
    // MARK: - Initializers
    
    init(window: UIWindow) {
        self.window = window
    }
    
    convenience init(windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        self.init(window: window)
    }
    
    // MARK: - Methods
    
    func start(animated: Bool) {
        ...
    }
    
    func finish(animated: Bool) {
        ...
    }
}
```

`start(animated:)` method can be used in different ways. There can be UIViewController that initialize `window.rootViewController` property or it can be another (child) coordinator that runs his own flow of controllers.

```swift
func start(animated: Bool) {

    // child coordinator
    let mainCoordinator = MainCoordinator()
    mainCoordinator.parent = self
    mainCoordinator.start(animated: animated)
    childLocator.push(mainCoordinator, by: "main")

    window.rootViewController = mainCoordinator.rootViewController
    window.makeKeyAndVisible()

    // or controller
    let viewControler = UIViewController()
    window.rootViewController = viewControler
    window.makeKeyAndVisible()
}
```

As said below, initial point of application can be started right after application initialization. 

```swift
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - Properties
    
    var applicationCoordinator: ApplicationCoordinator?
    var window: UIWindow?

    // MARK: - UIWindowSceneDelegate
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let applicationCoordinator = ApplicationCoordinator(window: window)
        self.applicationCoordinator = applicationCoordinator
        applicationCoordinator.start(animated: true)
    }
}
```

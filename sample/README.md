# [simprokcore](https://github.com/simprok-dev/simprokcore-ios) sample

## Introduction

This sample is created to showcase the main features of the framework. In order to demonstrate the simplicity of it comparing to the basic example, we are making the same [sample](https://github.com/simprok-dev/simprokmachine-ios/tree/main/sample) as in ```simprokmachine```.


The sample is divided into 10 easy steps demonstrating the flow of the app development and API usage.


## Step 0 - Describe application's behavior

Let's assume we want to create a counter app that shows a number on the screen and logcat each time it is incremented. When we reopen the app we want to see the same number. So the state must be saved in persistent storage. 


## Step 1 - Code application's state and event

Here is our global state of the application.

```Swift
struct AppState {
    let value: Int
    
    init(_ value: Int) {
        self.value = value
    }
}
```

Here are our events of the application.

```Swift
enum AppEvent {
    case storage(Int)
    case click
}
```


## Step 2 - List down APIs

Here is our APIs we are going to use.

- ```UIKit```
- ```UserDefaults```
- ```print()```

Each API is going to be our layer.

## Step 3 - Code UI layer

- State:

```Swift
public struct UILayerState {
    public let text: String
}
```

- Event:

```Swift
public enum UILayerEvent {
    case click
}
```

- Machine hierarchy:

```Swift
extension MainViewController: ChildMachine {
    typealias Input = UILayerState
    typealias Output = UILayerEvent
    
    var queue: MachineQueue { .main }
    
    func process(input: UILayerState?, callback: @escaping Handler<UILayerEvent>) {
        label.text = "\(input?.text ?? "loading")"
        listener = { callback(.click) }
    }
}
```

```Swift
extension UIWindow: ParentMachine {
    public typealias Input = UILayerState
    public typealias Output = UILayerEvent
    
    public var child: Machine<Input, Output> {
        if let rootVC = rootViewController as? MainViewController {
            return rootVC.machine
        } else {
            fatalError("unexpected behavior") // we can return an empty machine here but for the example let's crash it
        }
    }
}
```

- Layer class:


```Swift
struct UILayer: LayerType {
    typealias GlobalState = AppState
    typealias GlobalEvent = AppEvent
    typealias State = UILayerState
    typealias Event = UILayerEvent
    
    var machine: Machine<UILayerState, UILayerEvent> {
        UIApplication.shared.delegate!.window!!.machine
    }
    
    func map(state: AppState) -> UILayerState {
        .init(text: "\(state.value)")
    }
    
    func map(event: UILayerEvent) -> AppEvent {
        switch event {
        case .click:
            return .click
        }
    }
}
```

## Step 4 - Code storage layer

- State:

```Swift
public struct StorageLayerState {
    public let value: Int
    
    public init(_ value: Int) {
        self.value = value
    }
}
```

- Event:

```Swift
public struct StorageLayerEvent {
    public let value: Int
    
    public init(_ value: Int) {
        self.value = value
    }
}
```

- Machine hierarchy:

```Swift
extension UserDefaults: ChildMachine {
    public typealias Input = StorageLayerState
    public typealias Output = StorageLayerEvent
    
    public var queue: MachineQueue { .main }
    
    private var key: String { "storage" }
    
    public func process(input: Input?, callback: @escaping Handler<Output>) {
        if let input = input {
            set(input.value, forKey: key)
        } else {
            callback(.init(integer(forKey: key)))
        }
    }
}
```

- Layer class:

```Swift
struct StorageLayer: LayerType {
    
    var machine: Machine<StorageLayerState, StorageLayerEvent> {
        UserDefaults.standard.machine
    }
    
    func map(state: AppState) -> StorageLayerState {
        .init(state.value)
    }
    
    func map(event: StorageLayerEvent) -> AppEvent {
        .storage(event.value)
    }
}
```

## Step 6 - Code Logger layer

- State is going to be ```String```.

- Event is going to be ```Void``` as we don't send any events.


- Logger machine:

```Swift
class LoggerMachine: ChildMachine {
    typealias Input = String
    typealias Output = Void
    
    var queue: MachineQueue { .main }
    
    func process(input: Input?, callback: @escaping Handler<Output>) {
        print("\(input ?? "loading")")
    }
}
```

- Consumer Layer as we don't emit any events.

```Swift
struct LoggerLayer: ConsumerLayer {
    
    var machine: Machine<String, Void> {
        ~LoggerMachine()
    }
    
    func map(state: AppState) -> String {
        "\(state.value)"
    }
}
```
    
## Step 7 - Code Core class
    
Now when we have all layers prepared we must connect them together. To do this, we need to extend our ```AppDelegate``` with ```Core``` protocol conformance.

```Swift
extension AppDelegate: Core {
    typealias Event = AppEvent
    typealias State = AppState
    
    var layers: [Layer<AppEvent, AppState>] {[
        ~UILayer(),
        Layer(StorageLayer()),
        LoggerLayer().layer()
    ]}
    
    func reduce(state: AppState?, event: AppEvent) -> ReducerResult<AppState> {
        switch event {
        case .click:
            if let state = state {
                return .set(.init(state.value + 1))
            } else {
                return .skip
            }
        case .storage(let value):
            return .set(.init(value))
        }
    }
}
```

## Step 8 - Run the flow!

Call a ```start()``` method of the ```Core``` to trigger the flow. You can call ```stop()``` any time later to stop the flow.

```Swift

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
    window = UIWindow()
    window?.makeKeyAndVisible()
    window?.rootViewController = MainViewController()
        
    start()
        
    return true
}

```

## Step 9 - Enjoy yourself once again

Run the app and see how things are working.


![result](https://github.com/simprok-dev/simprokcore-ios/blob/main/sample/images/results.gif)


## To sum up

As you can see this template is way simpler and more straightforward than using a ```simprokmachine``` for your architectural design.

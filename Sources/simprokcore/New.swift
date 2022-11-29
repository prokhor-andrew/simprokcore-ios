//
//  File.swift
//  
//
//  Created by Andriy Prokhorenko on 27.11.2022.
//

import simprokmachine


public protocol ModuleType {
    associatedtype Domain
    associatedtype Input
    associatedtype Output

    var machine: Machine<Input, Output> { get }
    
    var gateways: [Gateway<Domain, Input, Output>] { get }
}

public extension ModuleType {
    
    var module: Module<Domain> {
        Module(self)
    }
    
    prefix static func ~(operand: Self) -> Module<Domain> {
        operand.module
    }
}

public struct Module<Domain> {
    
    internal let machine: Machine<Domain, Domain>
    
    public init<Input, Output>(machine: Machine<Input, Output>, gateways: [Gateway<Domain, Input, Output>]) {
        self.machine = machine.outward { output in
            gateways.flatMap { $0.outward(output) }
        }.inward { input in
            gateways.flatMap { $0.inward(input) }
        }
    }
    
    public init<Input, Output>(machine: Machine<Input, Output>, gateways: Gateway<Domain, Input, Output>...) {
        self.init(machine: machine, gateways: gateways)
    }
    
    public init<MT: ModuleType>(_ module: MT) where MT.Domain == Domain {
        self.init(machine: module.machine, gateways: module.gateways)
    }
}

public protocol LayerGateType {
    associatedtype Feature
    associatedtype Input
    associatedtype Output
    
    func inward(_ input: Feature) -> [Input]
    
    func outward(_ output: Output) -> [Feature]
}

public extension LayerGateType {
    
    // TODO: add operators
    func connect<Gate: DomainGateType>(to gate: Gate) -> Gateway<Gate.Domain, Input, Output> where Feature == Gate.Feature {
        Gateway(
            inward: { input in gate.inward(input).flatMap { inward($0) } },
            outward: { output in outward(output).flatMap { gate.outward($0) } }
        )
    }
    
    prefix static func ~(operand: Self) -> LayerGate<Feature, Input, Output> {
        LayerGate(inward: operand.inward, outward: operand.outward)
    }
}

public func +<LG: LayerGateType, DG: DomainGateType>(
    lhs: LG,
    rhs: DG
) -> Gateway<DG.Domain, LG.Input, LG.Output> where LG.Feature == DG.Feature {
    lhs.connect(to: rhs)
}


public protocol DomainGateType {
    associatedtype Domain
    associatedtype Feature
    
    func inward(_ input: Domain) -> [Feature]
    
    func outward(_ output: Feature) -> [Domain]
}

public struct DomainGate<Domain, Feature>: DomainGateType {
    
    public let inward: Mapper<Domain, [Feature]>
    public let outward: Mapper<Feature, [Domain]>
    
    public init(
        inward: @escaping Mapper<Domain, [Feature]>,
        outward: @escaping Mapper<Feature, [Domain]>
    ) {
        self.inward = inward
        self.outward = outward
    }
    
    public func inward(_ input: Domain) -> [Feature] {
        inward(input)
    }
    
    public func outward(_ output: Feature) -> [Domain] {
        outward(output)
    }
}


public struct Gateway<Domain, Input, Output> {
    
    public let inward: Mapper<Domain, [Input]>
    public let outward: Mapper<Output, [Domain]>
    
    public init(
        inward: @escaping Mapper<Domain, [Input]>,
        outward: @escaping Mapper<Output, [Domain]>
    ) {
        self.inward = inward
        self.outward = outward
    }
}


public struct LayerGate<Feature, Input, Output>: LayerGateType {

    public let inward: Mapper<Feature, [Input]>
    public let outward: Mapper<Output, [Feature]>
    
    public init(
        inward: @escaping Mapper<Feature, [Input]>,
        outward: @escaping Mapper<Output, [Feature]>
    ) {
        self.inward = inward
        self.outward = outward
    }
    
    public func inward(_ input: Feature) -> [Input] {
        inward(input)
    }
    
    public func outward(_ output: Output) -> [Feature] {
        outward(output)
    }
}

public extension MachineType {

    func gateways<Event>(_ gates: [Gateway<Event, Input, Output>]) -> Module<Event> {
        Module(
            machine: Machine(self),
            gateways: gates
        )
    }
    
    func gateways<Event>(_ gates: Gateway<Event, Input, Output>...) -> Module<Event> {
        gateways(gates)
    }
}



struct MyInput1 {
    
}

struct MyOutput1 {
    
}

struct MyInput2 {
    
}

struct MyOutput2 {
    
}

struct MyFeatureA {
    
    struct Module1Gate: LayerGateType {
        typealias Feature = MyFeatureA
        typealias Input = MyInput1
        typealias Output = MyOutput1
        
        func inward(_ input: MyFeatureA) -> [MyInput1] {
            []
        }
        
        func outward(_ output: MyOutput1) -> [MyFeatureA] {
            []
        }
    }
    
    struct Module2Gate: LayerGateType {
        typealias Feature = MyFeatureA
        typealias Input = MyInput2
        typealias Output = MyOutput2
        
        func inward(_ input: MyFeatureA) -> [MyInput2] {
            []
        }
        
        func outward(_ output: MyOutput2) -> [MyFeatureA] {
            []
        }
    }
}

struct MyFeatureB {
    
    struct Module1Gate: LayerGateType {
        typealias Feature = MyFeatureB
        typealias Input = MyInput1
        typealias Output = MyOutput1
        
        func inward(_ input: MyFeatureB) -> [MyInput1] {
            []
        }
        
        func outward(_ output: MyOutput1) -> [MyFeatureB] {
            []
        }
    }
    
    struct Module2Gate: LayerGateType {
        typealias Feature = MyFeatureB
        typealias Input = MyInput2
        typealias Output = MyOutput2
        
        func inward(_ input: MyFeatureB) -> [MyInput2] {
            []
        }
        
        func outward(_ output: MyOutput2) -> [MyFeatureB] {
            []
        }
    }
}

struct Module1: ModuleType {
    typealias Domain = MyApp
    typealias Input = MyInput1
    typealias Output = MyOutput1
    
    
    var machine: Machine<MyInput1, MyOutput1> {
        fatalError()
    }
    
    var gateways: [Gateway<MyApp, MyInput1, MyOutput1>] {[
        MyFeatureA.Module1Gate() + MyApp.MyFeatureAGate(),
        MyFeatureB.Module1Gate() + MyApp.MyFeatureBGate()
    ]}
}

struct Module2: ModuleType {
    typealias Domain = MyApp
    typealias Input = MyInput2
    typealias Output = MyOutput2
    
    var machine: Machine<MyInput2, MyOutput2> {
        fatalError()
    }
    
    var gateways: [Gateway<MyApp, MyInput2, MyOutput2>] {[
        MyFeatureA.Module2Gate() + MyApp.MyFeatureAGate(),
        MyFeatureB.Module2Gate() + MyApp.MyFeatureBGate()
    ]}
}

struct MyApp {
    
    struct MyFeatureAGate: DomainGateType {
        typealias Domain = MyApp
        typealias Feature = MyFeatureA
        
        func inward(_ input: MyApp) -> [MyFeatureA] {
            []
        }
        
        func outward(_ output: MyFeatureA) -> [MyApp] {
            []
        }
    }
    
    struct MyFeatureBGate: DomainGateType {
        typealias Domain = MyApp
        typealias Feature = MyFeatureB
        
        func inward(_ input: MyApp) -> [MyFeatureB] {
            []
        }
        
        func outward(_ output: MyFeatureB) -> [MyApp] {
            []
        }
    }
}

struct MyAppFeature: Feature {
    typealias Event = MyApp
    
    func scenario() -> State<MyApp> {
        final()
    }
}

class MyCore: Core {
    typealias Event = MyApp
    
    var layers: [Module<MyApp>] {[
        ~Module1(),
        ~Module2()
    ]}
    
    var feature: MyAppFeature {
        .init()
    }
}

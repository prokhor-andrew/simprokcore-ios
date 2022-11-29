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

public protocol DomainGatePassable {
    associatedtype Domain
    
    static func map(input: Domain) -> [Self]
    
    static func map(output: Self) -> [Domain]
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
    
    public init<LG: LayerGateType>(_ gate: LG) where LG.Input == Input, LG.Output == Output, LG.Feature: DomainGatePassable, LG.Feature.Domain == Domain {
        let gateway = gate + DomainGate(
            inward: { LG.Feature.map(input: $0) },
            outward: { LG.Feature.map(output: $0) }
        )
        self.init(inward: gateway.inward, outward: gateway.outward)
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


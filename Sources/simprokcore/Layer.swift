//
//  Layer.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


/// A general structure that describes a type that represents a layer object.
public struct Layer<GlobalState> {
    
    internal let machine: Machine<StateAction<GlobalState>, StateAction<GlobalState>>
    
    /// - parameter machine: Layer's machine that receives the result of `mapper` method and emits event objects that are sent into `reducer` method.
    /// - parameter mapper: Triggered every time the global state is changed.
    /// - parameter reducer: Triggered every time the machine sends an output event.
    public init<State, Event>(
        _ machine: Machine<State, Event>,
        mapper: @escaping Mapper<GlobalState, State>,
        reducer: @escaping BiMapper<GlobalState?, Event, ReducerResult<GlobalState>>
    ) {
        self.machine = machine.inward {
            switch $0 {
            case .stateWillUpdate:
                return .set()
            case .stateDidUpdate(let state):
                return .set(mapper(state))
            }
        }
        .outward { event in .set(.stateWillUpdate { reducer($0, event) })}
    }
    
    /// - parameter machine: A function that returns a machine that receives the result of `mapper` method and emits event objects that are sent into `reducer` method.
    /// - parameter mapper: Triggered every time the global state is changed.
    /// - parameter reducer: Triggered every time the machine sends an output event.
    public init<State, Event>(
        _ machine: Supplier<Machine<State, Event>>,
        mapper: @escaping Mapper<GlobalState, State>,
        reducer: @escaping BiMapper<GlobalState?, Event, ReducerResult<GlobalState>>
    ) {
        self.init(machine(), mapper: mapper, reducer: reducer)
    }
    
    /// - parameter layerType: a `LayerType` object used for creating an instance.
    public init<L: LayerType>(_ layerType: L) where L.GlobalState == GlobalState {
        self.init(
            layerType.machine,
            mapper: layerType.map(state:),
            reducer: layerType.reduce(state:event:)
        )
    }
    
    /// - parameter layerType: a function that returns a `LayerType` object used for creating an instance.
    public init<L: LayerType>(_ layerType: Supplier<L>) where L.GlobalState == GlobalState {
        self.init(layerType())
    }
    
    /// - parameter machine: Layer's machine that receives the result of `mapper` method and *does not* emit event objects.
    /// - parameter mapper: Triggered every time the global state is changed.
    public init<State, Output>(
        _ machine: Machine<State, Output>,
        mapper: @escaping Mapper<GlobalState, State>
    ) {
        self.machine = machine.outward { _ in .set() }.inward {
            switch $0 {
            case .stateWillUpdate:
                return .set()
            case .stateDidUpdate(let state):
                return .set(mapper(state))
            }
        }
    }
    
    /// - parameter machine: A function that returns a machine that receives the result of `mapper` method and *does not* emit event objects.
    /// - parameter mapper: Triggered every time the global state is changed.
    public init<State, Output>(
        _ machine: Supplier<Machine<State, Output>>,
        mapper: @escaping Mapper<GlobalState, State>
    ) {
        self.init(machine(), mapper: mapper)
    }
    
    /// - parameter layerType: a `ConsumerLayer` object used for creating an instance.
    public init<C: ConsumerLayer>(_ layerType: C) where C.GlobalState == GlobalState {
        self.init(
            layerType.machine,
            mapper: layerType.map(state:)
        )
    }
    
    /// - parameter layerType: a function that returns a `ConsumerLayer` object used for creating an instance.
    public init<C: ConsumerLayer>(_ layerType: Supplier<C>) where C.GlobalState == GlobalState {
        self.init(layerType())
    }
    
    
    /// - parameter machine: Layer's machine that emits event objects that are sent into `reducer` method and *does not* receive state as input.
    /// - parameter reducer: Triggered every time the machine sends an output event.
    public init<Event, Input>(
        _ machine: Machine<Input, Event>,
        reducer: @escaping BiMapper<GlobalState?, Event, ReducerResult<GlobalState>>
    ) {
        self.machine = machine.inward { _ in .set() }.outward { event in .set(.stateWillUpdate { reducer($0, event) })}
    }
    
    /// - parameter machine: A function that returns a machine that emits event objects that are sent into `reducer` method and *does not* receive state as input.
    /// - parameter reducer: Triggered every time the machine sends an output event.
    public init<Event, Input>(
        _ machine: Supplier<Machine<Input, Event>>,
        reducer: @escaping BiMapper<GlobalState?, Event, ReducerResult<GlobalState>>
    ) {
        self.init(machine(), reducer: reducer)
    }
    
    /// - parameter layerType: a `ProducerLayer` object used for creating an instance.
    public init<P: ProducerLayer>(_ layerType: P) where P.GlobalState == GlobalState {
        self.init(layerType.machine, reducer: layerType.reduce(state:event:))
    }
    
    /// - parameter layerType: a function that returns a `ProducerLayer` object used for creating an instance.
    public init<P: ProducerLayer>(_ layerType: Supplier<P>) where P.GlobalState == GlobalState {
        self.init(layerType())
    }
}

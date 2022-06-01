//
//  Layer.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


/// A general structure that describes a type that represents a layer object.
public struct Layer<GlobalState, GlobalEvent> {

    internal let machine: Machine<StateAction<GlobalState, GlobalEvent>, StateAction<GlobalState, GlobalEvent>>

    private init<State, Event>(
        _ machine: Machine<State, Event>,
        stateMapper: @escaping Mapper<GlobalState, State>,
        eventMapper: @escaping Mapper<Event, GlobalEvent>
    ) {
        self.machine = machine.inward {
            switch $0 {
            case .stateWillUpdate:
                return .set()
            case .stateDidUpdate(let state):
                return .set(stateMapper(state))
            }
        }
        .outward { event in .set(.stateWillUpdate(eventMapper(event))) }
    }

    private init<State, Event>(
        _ machine: Machine<State, Event>,
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
    
    private init<State, Event>(
        _ machine: Machine<State, Event>,
        mapper: @escaping Mapper<Event, GlobalEvent>
    ) {
        self.machine = machine.inward { _ in .set() }.outward {
            .set(.stateWillUpdate(mapper($0)))
        }
    }
        
    private init<Event>(
        _ machine: Machine<GlobalState, Event>,
        mapper: @escaping Mapper<Event, GlobalEvent>
    ) {
        self.machine = machine.inward {
            switch $0 {
            case .stateWillUpdate:
                return .set()
            case .stateDidUpdate(let state):
                return .set(state)
            }
        }
        .outward { event in .set(.stateWillUpdate(mapper(event))) }
    }
    
    private init<State>(
        _ machine: Machine<State, GlobalEvent>,
        mapper: @escaping Mapper<GlobalState, State>
    ) {
        self.machine = machine.inward {
            switch $0 {
            case .stateWillUpdate:
                return .set()
            case .stateDidUpdate(let state):
                return .set(mapper(state))
            }
        }
        .outward { event in .set(.stateWillUpdate(event)) }
    }
    
    private init(
        _ machine: Machine<GlobalState, GlobalEvent>
    ) {
        self.machine = machine.inward {
            switch $0 {
            case .stateWillUpdate:
                return .set()
            case .stateDidUpdate(let state):
                return .set(state)
            }
        }
        .outward { event in .set(.stateWillUpdate(event)) }
    }
    
    
    // MARK: LayerType constructors
    
    /// creates Layer object
    /// - parameter machine - a machine that receives input state and produces events into global reducer
    /// - parameter stateMapper - a state mapper
    /// - parameter eventMapper - an event mapper
    public static func layer<State, Event>(
        _ machine: Machine<State, Event>,
        stateMapper: @escaping Mapper<GlobalState, State>,
        eventMapper: @escaping Mapper<Event, GlobalEvent>
    ) -> Layer<GlobalState, GlobalEvent> {
        .init(machine, stateMapper: stateMapper, eventMapper: eventMapper)
    }
    
    /// creates Layer object
    /// - parameter machine - a supplier that provides a machine that receives input state and produces events into global reducer
    /// - parameter stateMapper - a state mapper
    /// - parameter eventMapper - an event mapper
    public static func layer<State, Event>(
        _ machine: Supplier<Machine<State, Event>>,
        stateMapper: @escaping Mapper<GlobalState, State>,
        eventMapper: @escaping Mapper<Event, GlobalEvent>
    ) -> Layer<GlobalState, GlobalEvent> {
        layer(machine(), stateMapper: stateMapper, eventMapper: eventMapper)
    }
    
    /// creates Layer object
    /// - parameter layerType - an object of type that represents a layer that receives state and produces events
    public static func layer<L: LayerType>(
        _ layerType: L
    ) -> Layer<GlobalState, GlobalEvent>
    where L.GlobalState == GlobalState, L.GlobalEvent == GlobalEvent {
        layer(layerType.machine, stateMapper: layerType.map(state:), eventMapper: layerType.map(event:))
    }
    
    /// creates Layer object
    /// - parameter layerType - a supplier of an object of type that represents a layer that receives state and produces events
    public static func layer<L: LayerType>(
        _ layerType: Supplier<L>
    ) -> Layer<GlobalState, GlobalEvent>
    where L.GlobalState == GlobalState, L.GlobalEvent == GlobalEvent {
        layer(layerType())
    }
    
    // MARK: ConsumerLayer constructors
    
    /// creates Layer object
    /// - parameter machine - a machine that receives input state and *does not* produce events into global reducer
    /// - parameter mapper - a state mapper
    public static func consumer<State, Event>(
        _ machine: Machine<State, Event>,
        mapper: @escaping Mapper<GlobalState, State>
    ) -> Layer<GlobalState, GlobalEvent> {
        .init(machine, mapper: mapper)
    }
    
    /// creates Layer object
    /// - parameter machine - a supplier of a machine that receives input state and *does not* produce events into global reducer
    /// - parameter mapper - a state mapper
    public static func consumer<State, Event>(
        _ machine: Supplier<Machine<State, Event>>,
        mapper: @escaping Mapper<GlobalState, State>
    ) -> Layer<GlobalState, GlobalEvent> {
        consumer(machine(), mapper: mapper)
    }
    
    /// creates Layer object
    /// - parameter layerType - an object of type that represents a layer that receives state and *does not* produce events
    public static func consumer<L: ConsumerLayer>(
        _ layerType: L
    ) -> Layer<GlobalState, GlobalEvent>
    where L.GlobalState == GlobalState {
        consumer(layerType.machine, mapper: layerType.map(state:))
    }
    
    /// creates Layer object
    /// - parameter layerType - a supplier of an object of type that represents a layer that receives state and *does not* produce events
    public static func consumer<L: ConsumerLayer>(
        _ layerType: Supplier<L>
    ) -> Layer<GlobalState, GlobalEvent>
    where L.GlobalState == GlobalState {
        consumer(layerType())
    }
    
    // MARK: ProducerLayer constructors
    
    /// creates Layer object
    /// - parameter machine - a machine that *does not* receive input state and produces events into global reducer
    /// - parameter mapper - an event mapper
    public static func producer<State, Event>(
        _ machine: Machine<State, Event>,
        mapper: @escaping Mapper<Event, GlobalEvent>
    ) -> Layer<GlobalState, GlobalEvent> {
        .init(machine, mapper: mapper)
    }
    
    /// creates Layer object
    /// - parameter machine - a supplier of a machine that *does not* receive input state and produces events into global reducer
    /// - parameter mapper - an event mapper
    public static func producer<State, Event>(
        _ machine: Supplier<Machine<State, Event>>,
        mapper: @escaping Mapper<Event, GlobalEvent>
    ) -> Layer<GlobalState, GlobalEvent> {
        producer(machine(), mapper: mapper)
    }

    /// creates Layer object
    /// - parameter layerType - an object of type that represents a layer that *does not* receive state and produces events
    public static func producer<L: ProducerLayer>(
        _ layerType: L
    ) -> Layer<GlobalState, GlobalEvent>
    where L.GlobalEvent == GlobalEvent {
        producer(layerType.machine, mapper: layerType.map(event:))
    }

    /// creates Layer object
    /// - parameter layerType - a supplier of an object of type that represents a layer that *does not* receive state and produces events
    public static func producer<L: ProducerLayer>(
        _ layerType: Supplier<L>
    ) -> Layer<GlobalState, GlobalEvent>
    where L.GlobalEvent == GlobalEvent {
        producer(layerType())
    }
    
    
    // MARK: MapEventLayer constructors
    
    /// creates Layer object
    /// - parameter machine - a machine that receives non-mapped input state and produces events into global reducer
    /// - parameter mapper - an event mapper
    public static func event<Event>(
        _ machine: Machine<GlobalState, Event>,
        mapper: @escaping Mapper<Event, GlobalEvent>
    ) -> Layer<GlobalState, GlobalEvent> {
        .init(machine, mapper: mapper)
    }
    
    /// creates Layer object
    /// - parameter machine - a supplier of a machine that receives non-mapped input state and produces events into global reducer
    /// - parameter mapper - an event mapper
    public static func event<Event>(
        _ machine: Supplier<Machine<GlobalState, Event>>,
        mapper: @escaping Mapper<Event, GlobalEvent>
    ) -> Layer<GlobalState, GlobalEvent> {
        event(machine(), mapper: mapper)
    }
    
    /// creates Layer object
    /// - parameter layerType - an object of type that represents a layer that receives non-mapped state and produces events
    public static func event<L: MapEventLayer>(
        _ layerType: L
    ) -> Layer<GlobalState, GlobalEvent>
    where L.GlobalEvent == GlobalEvent, L.GlobalState == GlobalState {
        event(layerType.machine, mapper: layerType.map(event:))
    }
    
    /// creates Layer object
    /// - parameter layerType - a supplier of an object of type that represents a layer that receives non-mapped state and produces events
    public static func event<L: MapEventLayer>(
        _ layerType: Supplier<L>
    ) -> Layer<GlobalState, GlobalEvent>
    where L.GlobalEvent == GlobalEvent, L.GlobalState == GlobalState {
        event(layerType())
    }
    
    // MARK: MapStateLayer constructors
    
    /// creates Layer object
    /// - parameter machine - a machine that receives input state and produces non-mapped events into global reducer
    /// - parameter mapper - a state mapper
    public static func state<State>(
        _ machine: Machine<State, GlobalEvent>,
        mapper: @escaping Mapper<GlobalState, State>
    ) -> Layer<GlobalState, GlobalEvent> {
        .init(machine, mapper: mapper)
    }
    
    /// creates Layer object
    /// - parameter machine - a supplier of a machine that receives input state and produces non-mapped events into global reducer
    /// - parameter mapper - a state mapper
    public static func state<State>(
        _ machine: Supplier<Machine<State, GlobalEvent>>,
        mapper: @escaping Mapper<GlobalState, State>
    ) -> Layer<GlobalState, GlobalEvent> {
        state(machine(), mapper: mapper)
    }
    
    /// creates Layer object
    /// - parameter layerType - an object of type that represents a layer that receives state and produces non-mapped events
    public static func state<L: MapStateLayer>(
        _ layerType: L
    ) -> Layer<GlobalState, GlobalEvent>
    where L.GlobalState == GlobalState, L.GlobalEvent == GlobalEvent {
        state(layerType.machine, mapper: layerType.map(state:))
    }
    
    /// creates Layer object
    /// - parameter layerType - a supplier of an object of type that represents a layer that receives state and produces non-mapped events
    public static func state<L: MapStateLayer>(
        _ layerType: Supplier<L>
    ) -> Layer<GlobalState, GlobalEvent>
    where L.GlobalState == GlobalState, L.GlobalEvent == GlobalEvent {
        state(layerType())
    }
    
    // MARK: NoMapLayer constructors
    
    /// creates Layer object
    /// - parameter machine -  a machine that receives non-mapped input state and produces non-mapped events into global reducer
    public static func nomap(
        _ machine: Machine<GlobalState, GlobalEvent>
    ) -> Layer<GlobalState, GlobalEvent> {
        .init(machine)
    }
    
    /// creates Layer object
    /// - parameter machine - a supplier of a machine that receives non-mapped input state and produces non-mapped events into global reducer
    public static func nomap(
        _ machine: Supplier<Machine<GlobalState, GlobalEvent>>
    ) -> Layer<GlobalState, GlobalEvent> {
        nomap(machine())
    }
    
    /// creates Layer object
    /// - parameter layerType - an object of type that represents a layer that receives non-mapped state and produces non-mapped events
    public static func nomap<L: NoMapLayer>(
        _ layerType: L
    ) -> Layer<GlobalState, GlobalEvent>
    where L.GlobalEvent == GlobalEvent, L.GlobalState == GlobalState {
        nomap(layerType.machine)
    }
    
    /// creates Layer object
    /// - parameter layerType - a supplier of an object of type that represents a layer that receives non-mapped state and produces non-mapped events
    public static func nomap<L: NoMapLayer>(
        _ layerType: Supplier<L>
    ) -> Layer<GlobalState, GlobalEvent>
    where L.GlobalEvent == GlobalEvent, L.GlobalState == GlobalState {
        nomap(layerType())
    }
}

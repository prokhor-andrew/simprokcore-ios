//
//  Layer.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


/// A general structure that describes a type that represents a layer object.
public struct Layer<Event> {

    internal let machine: Machine<StateAction<Event>, StateAction<Event>>

    private init<Input, Output>(
        _ machine: Machine<Input, Output>,
        stateMapper: @escaping Mapper<Event, Input>,
        eventMapper: @escaping Mapper<Output, Event>
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

    private init<Input, Output>(
        _ machine: Machine<Input, Output>,
        mapper: @escaping Mapper<Event, Input>
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
    
    private init<Input, Output>(
        _ machine: Machine<Input, Output>,
        mapper: @escaping Mapper<Output, Event>
    ) {
        self.machine = machine.inward { _ in .set() }.outward {
            .set(.stateWillUpdate(mapper($0)))
        }
    }
        
    private init<Output>(
        _ machine: Machine<Event, Output>,
        mapper: @escaping Mapper<Output, Event>
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
    
    private init<Input>(
        _ machine: Machine<Input, Event>,
        mapper: @escaping Mapper<Event, Input>
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
        _ machine: Machine<Event, Event>
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
    public static func layer<Input, Output>(
        _ machine: Machine<Input, Output>,
        stateMapper: @escaping Mapper<Event, Input>,
        eventMapper: @escaping Mapper<Output, Event>
    ) -> Layer<Event> {
        .init(machine, stateMapper: stateMapper, eventMapper: eventMapper)
    }
    
    /// creates Layer object
    /// - parameter machine - a supplier that provides a machine that receives input state and produces events into global reducer
    /// - parameter stateMapper - a state mapper
    /// - parameter eventMapper - an event mapper
    public static func layer<Input, Output>(
        _ machine: Supplier<Machine<Input, Output>>,
        stateMapper: @escaping Mapper<Event, Input>,
        eventMapper: @escaping Mapper<Output, Event>
    ) -> Layer<Event> {
        layer(machine(), stateMapper: stateMapper, eventMapper: eventMapper)
    }
    
    /// creates Layer object
    /// - parameter layerType - an object of type that represents a layer that receives state and produces events
    public static func layer<L: LayerType>(
        _ layerType: L
    ) -> Layer<Event>
    where L.Event == Event {
        layer(layerType.machine, stateMapper: layerType.map(event:), eventMapper: layerType.map(output:))
    }
    
    /// creates Layer object
    /// - parameter layerType - a supplier of an object of type that represents a layer that receives state and produces events
    public static func layer<L: LayerType>(
        _ layerType: Supplier<L>
    ) -> Layer<Event>
    where L.Event == Event {
        layer(layerType())
    }
    
    // MARK: ConsumerLayer constructors
    
    /// creates Layer object
    /// - parameter machine - a machine that receives input state and *does not* produce events into global reducer
    /// - parameter mapper - a state mapper
    public static func consumer<Input, Output>(
        _ machine: Machine<Input, Output>,
        mapper: @escaping Mapper<Event, Input>
    ) -> Layer<Event> {
        .init(machine, mapper: mapper)
    }
    
    /// creates Layer object
    /// - parameter machine - a supplier of a machine that receives input state and *does not* produce events into global reducer
    /// - parameter mapper - a state mapper
    public static func consumer<Input, Output>(
        _ machine: Supplier<Machine<Input, Output>>,
        mapper: @escaping Mapper<Event, Input>
    ) -> Layer<Event> {
        consumer(machine(), mapper: mapper)
    }
    
    /// creates Layer object
    /// - parameter layerType - an object of type that represents a layer that receives state and *does not* produce events
    public static func consumer<L: ConsumerLayer>(
        _ layerType: L
    ) -> Layer<Event>
    where L.Event == Event {
        consumer(layerType.machine, mapper: layerType.map(event:))
    }
    
    /// creates Layer object
    /// - parameter layerType - a supplier of an object of type that represents a layer that receives state and *does not* produce events
    public static func consumer<L: ConsumerLayer>(
        _ layerType: Supplier<L>
    ) -> Layer<Event>
    where L.Event == Event {
        consumer(layerType())
    }
    
    // MARK: ProducerLayer constructors
    
    /// creates Layer object
    /// - parameter machine - a machine that *does not* receive input state and produces events into global reducer
    /// - parameter mapper - an event mapper
    public static func producer<Input, Output>(
        _ machine: Machine<Input, Output>,
        mapper: @escaping Mapper<Output, Event>
    ) -> Layer<Event> {
        .init(machine, mapper: mapper)
    }
    
    /// creates Layer object
    /// - parameter machine - a supplier of a machine that *does not* receive input state and produces events into global reducer
    /// - parameter mapper - an event mapper
    public static func producer<Input, Output>(
        _ machine: Supplier<Machine<Input, Output>>,
        mapper: @escaping Mapper<Output, Event>
    ) -> Layer<Event> {
        producer(machine(), mapper: mapper)
    }

    /// creates Layer object
    /// - parameter layerType - an object of type that represents a layer that *does not* receive state and produces events
    public static func producer<L: ProducerLayer>(
        _ layerType: L
    ) -> Layer<Event>
    where L.Event == Event {
        producer(layerType.machine, mapper: layerType.map(output:))
    }

    /// creates Layer object
    /// - parameter layerType - a supplier of an object of type that represents a layer that *does not* receive state and produces events
    public static func producer<L: ProducerLayer>(
        _ layerType: Supplier<L>
    ) -> Layer<Event>
    where L.Event == Event {
        producer(layerType())
    }
    
    
    // MARK: MapEventLayer constructors
    
    /// creates Layer object
    /// - parameter machine - a machine that receives non-mapped input state and produces events into global reducer
    /// - parameter mapper - an event mapper
    public static func output<Output>(
        _ machine: Machine<Event, Output>,
        mapper: @escaping Mapper<Output, Event>
    ) -> Layer<Event> {
        .init(machine, mapper: mapper)
    }
    
    /// creates Layer object
    /// - parameter machine - a supplier of a machine that receives non-mapped input state and produces events into global reducer
    /// - parameter mapper - an event mapper
    public static func output<Output>(
        _ machine: Supplier<Machine<Event, Output>>,
        mapper: @escaping Mapper<Output, Event>
    ) -> Layer<Event> {
        output(machine(), mapper: mapper)
    }
    
    /// creates Layer object
    /// - parameter layerType - an object of type that represents a layer that receives non-mapped state and produces events
    public static func output<L: MapOutputLayer>(
        _ layerType: L
    ) -> Layer<Event>
    where L.Event == Event {
        output(layerType.machine, mapper: layerType.map(output:))
    }
    
    /// creates Layer object
    /// - parameter layerType - a supplier of an object of type that represents a layer that receives non-mapped state and produces events
    public static func output<L: MapOutputLayer>(
        _ layerType: Supplier<L>
    ) -> Layer<Event>
    where L.Event == Event {
        output(layerType())
    }
    
    // MARK: MapStateLayer constructors
    
    /// creates Layer object
    /// - parameter machine - a machine that receives input state and produces non-mapped events into global reducer
    /// - parameter mapper - a state mapper
    public static func input<Input>(
        _ machine: Machine<Input, Event>,
        mapper: @escaping Mapper<Event, Input>
    ) -> Layer<Event> {
        .init(machine, mapper: mapper)
    }
    
    /// creates Layer object
    /// - parameter machine - a supplier of a machine that receives input state and produces non-mapped events into global reducer
    /// - parameter mapper - a state mapper
    public static func input<Input>(
        _ machine: Supplier<Machine<Input, Event>>,
        mapper: @escaping Mapper<Event, Input>
    ) -> Layer<Event> {
        input(machine(), mapper: mapper)
    }
    
    /// creates Layer object
    /// - parameter layerType - an object of type that represents a layer that receives state and produces non-mapped events
    public static func input<L: MapInputLayer>(
        _ layerType: L
    ) -> Layer<Event>
    where L.Event == Event {
        input(layerType.machine, mapper: layerType.map(event:))
    }
    
    /// creates Layer object
    /// - parameter layerType - a supplier of an object of type that represents a layer that receives state and produces non-mapped events
    public static func input<L: MapInputLayer>(
        _ layerType: Supplier<L>
    ) -> Layer<Event>
    where L.Event == Event {
        input(layerType())
    }
    
    // MARK: NoMapLayer constructors
    
    /// creates Layer object
    /// - parameter machine -  a machine that receives non-mapped input state and produces non-mapped events into global reducer
    public static func nomap(
        _ machine: Machine<Event, Event>
    ) -> Layer<Event> {
        .init(machine)
    }
    
    /// creates Layer object
    /// - parameter machine - a supplier of a machine that receives non-mapped input state and produces non-mapped events into global reducer
    public static func nomap(
        _ machine: Supplier<Machine<Event, Event>>
    ) -> Layer<Event> {
        nomap(machine())
    }
    
    /// creates Layer object
    /// - parameter layerType - an object of type that represents a layer that receives non-mapped state and produces non-mapped events
    public static func nomap<L: NoMapLayer>(
        _ layerType: L
    ) -> Layer<Event>
    where L.Event == Event {
        nomap(layerType.machine)
    }
    
    /// creates Layer object
    /// - parameter layerType - a supplier of an object of type that represents a layer that receives non-mapped state and produces non-mapped events
    public static func nomap<L: NoMapLayer>(
        _ layerType: Supplier<L>
    ) -> Layer<Event>
    where L.Event == Event {
        nomap(layerType())
    }
}

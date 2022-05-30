//
//  Layer.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


/// A general structure that describes a type that represents a layer object.
public struct Layer<GlobalEvent, GlobalState> {

    internal let machine: Machine<StateAction<GlobalEvent, GlobalState>, StateAction<GlobalEvent, GlobalState>>

    public init<State, Event>(
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

    public init<State, Event>(
        _ machine: Supplier<Machine<State, Event>>,
        stateMapper: @escaping Mapper<GlobalState, State>,
        eventMapper: @escaping Mapper<Event, GlobalEvent>
    ) {
        self.init(machine(), stateMapper: stateMapper, eventMapper: eventMapper)
    }

    public init<L: LayerType>(_ layerType: L) where L.GlobalState == GlobalState, L.GlobalEvent == GlobalEvent {
        self.init(
            layerType.machine,
            stateMapper: layerType.map(state:),
            eventMapper: layerType.map(event:)
        )
    }

    public init<L: LayerType>(_ layerType: Supplier<L>) where L.GlobalState == GlobalState, L.GlobalEvent == GlobalEvent {
        self.init(layerType())
    }

    public init<State, Event>(
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

    public init<State, Event>(
        _ machine: Supplier<Machine<State, Event>>,
        mapper: @escaping Mapper<GlobalState, State>
    ) {
        self.init(machine(), mapper: mapper)
    }

    public init<C: ConsumerLayer>(_ layerType: C) where C.GlobalState == GlobalState {
        self.init(
            layerType.machine,
            mapper: layerType.map(state:)
        )
    }

    public init<C: ConsumerLayer>(_ layerType: Supplier<C>) where C.GlobalState == GlobalState {
        self.init(layerType())
    }

    public init<Event, State>(
        _ machine: Machine<State, Event>,
        mapper: @escaping Mapper<Event, GlobalEvent>
    ) {
        self.machine = machine.inward { _ in .set() }.outward {
            .set(.stateWillUpdate(mapper($0)))
        }
    }

    public init<Event, State>(
        _ machine: Supplier<Machine<State, Event>>,
        mapper: @escaping Mapper<Event, GlobalEvent>
    ) {
        self.init(machine(), mapper: mapper)
    }

    public init<P: ProducerLayer>(_ layerType: P) where P.GlobalEvent == GlobalEvent {
        self.init(layerType.machine, mapper: layerType.map(event:))
    }

    public init<P: ProducerLayer>(_ layerType: Supplier<P>) where P.GlobalEvent == GlobalEvent {
        self.init(layerType())
    }
        
    public init<Event>(
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
    
    public init<Event>(
        _ machine: Supplier<Machine<GlobalState, Event>>,
        mapper: @escaping Mapper<Event, GlobalEvent>
    ) {
        self.init(machine(), mapper: mapper)
    }
    
    public init<L: MapEventLayer>(
        _ layerType: L
    ) where L.GlobalEvent == GlobalEvent {
        self.init(
            layerType.machine,
            mapper: layerType.map(event:)
        )
    }
    
    public init<L: MapEventLayer>(
        _ layerType: Supplier<L>
    ) where L.GlobalEvent == GlobalEvent {
        self.init(layerType())
    }
    
    public init<State>(
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
    
    public init<State>(
        _ machine: Supplier<Machine<State, GlobalEvent>>,
        mapper: @escaping Mapper<GlobalState, State>
    ) {
        self.init(machine(), mapper: mapper)
    }
    
    public init<L: MapStateLayer>(
        _ layerType: L
    ) where L.GlobalState == GlobalState {
        self.init(layerType.machine, mapper: layerType.map(state:))
    }
    
    public init<L: MapStateLayer>(
        _ layerType: Supplier<L>
    ) where L.GlobalState == GlobalState {
        self.init(layerType())
    }
    
    public init(
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
    
    public init(
        _ machine: Supplier<Machine<GlobalState, GlobalEvent>>
    ) {
        self.init(machine())
    }
    
    public init<L: NoMapLayer>(
        _ layerType: L
    ) where L.GlobalEvent == GlobalEvent, L.GlobalState == GlobalState {
        self.init(layerType.machine)
    }
    
    public init<L: NoMapLayer>(
        _ layerType: Supplier<L>
    ) where L.GlobalEvent == GlobalEvent, L.GlobalState == GlobalState {
        self.init(layerType())
    }
}

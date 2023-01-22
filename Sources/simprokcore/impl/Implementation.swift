//
//  Implementation.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine
import simprokstate

fileprivate var subscriptions: [ObjectIdentifier: AnyObject] = [:]

internal func _start<AppEvent>(
    sender: AnyObject,
    feature: CoreFeature<AppEvent>,
    sources: Sources<AppEvent>
) {
    // check if there is already a subscription for this Core

    if subscriptions[ObjectIdentifier(sender)] != nil {
        return
    }

    // subscribe to a machine merged from modules

    let sourced: [ParentMachine<ImplCoreEvent<AppEvent>, ImplCoreEvent<AppEvent>>] = sources.sources.map {
        $0.machine.outward { [.fromModule($0)] }
            .inward {
                switch $0 {
                case .fromReducer(let event):
                    return [event]
                case .fromModule:
                    return []
                }
            }
    }

    let reducer: ParentMachine<ImplCoreEvent<AppEvent>, ImplCoreEvent<AppEvent>> = FeatureMachine(
        FeatureTransition(feature)
    ).outward { [.fromReducer($0)] }
        .inward {
            switch $0 {
            case .fromReducer:
                return []
            case .fromModule(let event):
                return [event]
            }
        }

    // it is important to save it into an array above the "state()" function
    let machines: Machines<ImplCoreEvent<AppEvent>, ImplCoreEvent<AppEvent>> = Machines(sourced.copy(add: reducer))

    func state() -> CoreFeature<ImplCoreEvent<AppEvent>> {
        FeatureObject(machines: machines) { _, event in
            switch event {
            case .ext:
                return nil
            case .int(let value):
                return FeatureTransition(state(), effects: .int(value))
            }
        }
    }
    
    subscriptions[ObjectIdentifier(sender)] = FeatureMachine(FeatureTransition(state())).subscribe { _, _ in }
}

internal func _stop(_ sender: AnyObject) {
    subscriptions.removeValue(forKey: ObjectIdentifier(sender))
}

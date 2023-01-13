//
//  Implementation.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine
import simprokstate

fileprivate var subscriptions: [ObjectIdentifier: AnyObject] = [:]

internal func _start<
    AppEvent,
    AppFeature: DomainFeatureMildProtocol
>(
    sender: AnyObject,
    feature: AppFeature,
    modules: Modules<AppEvent>
) where AppFeature.ExternalTrigger == AppEvent, AppFeature.ExternalEffect == AppEvent {
    // check if there is already a subscription for this Core
    
    if subscriptions[ObjectIdentifier(sender)] != nil { return }
    
    // subscribe to a machine merged from modules
    
    let moduled: [ParentAutomaton<CoreEvent<AppEvent>, CoreEvent<AppEvent>>] = modules.machines.map {
        ParentAutomaton($0.outward { [.fromModule($0)] }.inward {
            switch $0 {
            case .fromReducer(let event):
                return [event]
            case .fromModule:
                return []
            }
        })
    }
    
    let reducer: ParentAutomaton<CoreEvent<AppEvent>, CoreEvent<AppEvent>> = ParentAutomaton(FeatureAutomaton(FeatureTransition(feature)).outward {
        [.fromReducer($0)]
    }.inward {
        switch $0 {
        case .fromReducer:
            return []
        case .fromModule(let event):
            return [event]
        }
    })
    
    // it is important to save it into an array above the "state()" function
    let machines: [ParentAutomaton<CoreEvent<AppEvent>, CoreEvent<AppEvent>>] = moduled.copy(add: reducer)
    
    func state() -> FeatureSelfishObject<CoreEvent<AppEvent>, CoreEvent<AppEvent>, CoreEvent<AppEvent>, CoreEvent<AppEvent>> {
        FeatureSelfishObject(machines: machines) {
            switch $0 {
            case .ext:
                return nil
            case .int(let value):
                return FeatureTransition(state(), effects: .int(value))
            }
        }
    }
    
    subscriptions[ObjectIdentifier(sender)] = FeatureAutomaton(FeatureTransition(state())).subscribe { _,_ in }
}

internal func _stop(_ sender: AnyObject) {
    subscriptions.removeValue(forKey: ObjectIdentifier(sender))
}

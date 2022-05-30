//
//  UILayer.swift
//  sample
//
//  Created by Andrey Prokhorenko on 19.02.2022.
//

import simprokmachine
import simprokcore
import UIKit


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

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
    typealias State = UILayerState
    typealias Event = UILayerEvent
    
    var machine: Machine<UILayerState, UILayerEvent> {
        UIApplication.shared.delegate!.window!!.machine
    }
    
    func map(state: AppState) -> UILayerState {
        .init(text: "\(state.value)")
    }
    
    func reduce(state: AppState?, event: UILayerEvent) -> ReducerResult<AppState> {
        if let state = state {
            switch event {
            case .click:
                return .set(.init(state.value + 1))
            }
        } else {
            switch event {
            case .click:
                return .skip
            }
        }
    }
}

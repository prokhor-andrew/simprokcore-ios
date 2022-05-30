//
//  StorageLayer.swift
//  sample
//
//  Created by Andrey Prokhorenko on 19.02.2022.
//

import Foundation
import simprokmachine
import simprokcore


struct StorageLayer: LayerType {
    
    var machine: Machine<StorageLayerState, StorageLayerEvent> {
        UserDefaults.standard.machine
    }
    
    func map(state: AppState) -> StorageLayerState {
        .init(state.value)
    }
    
    func map(event: StorageLayerEvent) -> AppEvent {
        .storage(event.value)
    }
}

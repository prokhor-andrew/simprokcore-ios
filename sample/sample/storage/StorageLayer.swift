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
        
    var machine: Machine<StorageLayerInput, StorageLayerOutput> {
        UserDefaults.standard.machine
    }

    func map(input: AppEvent) -> Ward<StorageLayerInput> {
        switch input {
        case .storage:
            return .set()
        case .click:
            return .set(.click)
        }
    }

    func map(output: StorageLayerOutput) -> Ward<AppEvent> {
        .set(.storage(output.value))
    }
}

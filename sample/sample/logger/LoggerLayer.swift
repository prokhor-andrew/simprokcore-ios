//
//  LoggerLayer.swift
//  sample
//
//  Created by Andrey Prokhorenko on 19.02.2022.
//

import simprokmachine
import simprokcore


struct LoggerLayer: ConsumerLayer {
    
    var machine: Machine<String, Void> {
        ~LoggerMachine()
    }
    
    func map(state: AppState) -> String {
        "\(state.value)"
    }
}

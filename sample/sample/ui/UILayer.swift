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
    typealias Event = AppEvent
    typealias Input = UILayerInput
    typealias Output = UILayerOutput
    
    var machine: Machine<UILayerInput, UILayerOutput> {
        UIApplication.shared.delegate!.window!!.machine
    }
    
    func map(input: AppEvent) -> Ward<UILayerInput> {
        .set(.init(text: "\(input)"))
    }
    
    func map(output: UILayerOutput) -> Ward<AppEvent> {
        switch output {
        case .click:
            return .set(.click)
        }
    }
}

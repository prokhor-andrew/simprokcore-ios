//
//  UIWindow+Machine.swift
//  simprokmachine-sample
//
//  Created by Andrey Prokhorenko on 29.01.2022.
//

import simprokmachine
import UIKit


extension UIWindow: ParentMachine {
    public typealias Input = UILayerState
    public typealias Output = UILayerEvent
    
    public var child: Machine<Input, Output> {
        if let rootVC = rootViewController as? MainViewController {
            return rootVC.machine
        } else {
            fatalError("unexpected behavior") // we can return an empty machine here but for the example let's crash it
        }
    }
}

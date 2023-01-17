//
//  ModulesBuilder.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

import simprokmachine

@resultBuilder
public struct ModulesBuilder<AppEvent> {
    
    private init() {
        
    }
    
    public static func buildBlock(_ components: Modules<AppEvent>...) -> [ParentMachine<AppEvent, AppEvent>] {
        components.flatMap { $0.machines }
    }
    
    public static func buildBlock<M0: Module>(_ m0: M0) -> [ParentMachine<AppEvent, AppEvent>] where M0.AppEvent == AppEvent {
        [m0.withMappersApplied]
    }
    
    public static func buildBlock<M0: Module, M1: Module>(_ m0: M0, _ m1: M1) -> [ParentMachine<AppEvent, AppEvent>] where M0.AppEvent == AppEvent, M1.AppEvent == AppEvent {
        [m0.withMappersApplied, m1.withMappersApplied]
    }
    
    public static func buildBlock<M0: Module, M1: Module, M2: Module>(_ m0: M0, _ m1: M1, _ m2: M2) -> [ParentMachine<AppEvent, AppEvent>] where M0.AppEvent == AppEvent, M1.AppEvent == AppEvent, M2.AppEvent == AppEvent {
        [m0.withMappersApplied, m1.withMappersApplied, m2.withMappersApplied]
    }
    
    public static func buildBlock<M0: Module, M1: Module, M2: Module, M3: Module>(_ m0: M0, _ m1: M1, _ m2: M2, _ m3: M3) -> [ParentMachine<AppEvent, AppEvent>] where M0.AppEvent == AppEvent, M1.AppEvent == AppEvent, M2.AppEvent == AppEvent, M3.AppEvent == AppEvent {
        [m0.withMappersApplied, m1.withMappersApplied, m2.withMappersApplied, m3.withMappersApplied]
    }
    
    public static func buildBlock<M0: Module, M1: Module, M2: Module, M3: Module, M4: Module>(_ m0: M0, _ m1: M1, _ m2: M2, _ m3: M3, _ m4: M4) -> [ParentMachine<AppEvent, AppEvent>] where M0.AppEvent == AppEvent, M1.AppEvent == AppEvent, M2.AppEvent == AppEvent, M3.AppEvent == AppEvent, M4.AppEvent == AppEvent {
        [m0.withMappersApplied, m1.withMappersApplied, m2.withMappersApplied, m3.withMappersApplied, m4.withMappersApplied]
    }
    
    public static func buildBlock<M0: Module, M1: Module, M2: Module, M3: Module, M4: Module, M5: Module>(_ m0: M0, _ m1: M1, _ m2: M2, _ m3: M3, _ m4: M4, _ m5: M5) -> [ParentMachine<AppEvent, AppEvent>] where M0.AppEvent == AppEvent, M1.AppEvent == AppEvent, M2.AppEvent == AppEvent, M3.AppEvent == AppEvent, M4.AppEvent == AppEvent, M5.AppEvent == AppEvent {
        [m0.withMappersApplied, m1.withMappersApplied, m2.withMappersApplied, m3.withMappersApplied, m4.withMappersApplied, m5.withMappersApplied]
    }
    
    public static func buildBlock<M0: Module, M1: Module, M2: Module, M3: Module, M4: Module, M5: Module, M6: Module>(_ m0: M0, _ m1: M1, _ m2: M2, _ m3: M3, _ m4: M4, _ m5: M5, _ m6: M6) -> [ParentMachine<AppEvent, AppEvent>] where M0.AppEvent == AppEvent, M1.AppEvent == AppEvent, M2.AppEvent == AppEvent, M3.AppEvent == AppEvent, M4.AppEvent == AppEvent, M5.AppEvent == AppEvent, M6.AppEvent == AppEvent {
        [m0.withMappersApplied, m1.withMappersApplied, m2.withMappersApplied, m3.withMappersApplied, m4.withMappersApplied, m5.withMappersApplied, m6.withMappersApplied]
    }
    
    public static func buildBlock<M0: Module, M1: Module, M2: Module, M3: Module, M4: Module, M5: Module, M6: Module, M7: Module>(_ m0: M0, _ m1: M1, _ m2: M2, _ m3: M3, _ m4: M4, _ m5: M5, _ m6: M6, _ m7: M7) -> [ParentMachine<AppEvent, AppEvent>] where M0.AppEvent == AppEvent, M1.AppEvent == AppEvent, M2.AppEvent == AppEvent, M3.AppEvent == AppEvent, M4.AppEvent == AppEvent, M5.AppEvent == AppEvent, M6.AppEvent == AppEvent, M7.AppEvent == AppEvent {
        [m0.withMappersApplied, m1.withMappersApplied, m2.withMappersApplied, m3.withMappersApplied, m4.withMappersApplied, m5.withMappersApplied, m6.withMappersApplied, m7.withMappersApplied]
    }
    
    public static func buildBlock<M0: Module, M1: Module, M2: Module, M3: Module, M4: Module, M5: Module, M6: Module, M7: Module, M8: Module>(_ m0: M0, _ m1: M1, _ m2: M2, _ m3: M3, _ m4: M4, _ m5: M5, _ m6: M6, _ m7: M7, _ m8: M8) -> [ParentMachine<AppEvent, AppEvent>] where M0.AppEvent == AppEvent, M1.AppEvent == AppEvent, M2.AppEvent == AppEvent, M3.AppEvent == AppEvent, M4.AppEvent == AppEvent, M5.AppEvent == AppEvent, M6.AppEvent == AppEvent, M7.AppEvent == AppEvent, M8.AppEvent == AppEvent {
        [m0.withMappersApplied, m1.withMappersApplied, m2.withMappersApplied, m3.withMappersApplied, m4.withMappersApplied, m5.withMappersApplied, m6.withMappersApplied, m7.withMappersApplied, m8.withMappersApplied]
    }
    
    public static func buildBlock<M0: Module, M1: Module, M2: Module, M3: Module, M4: Module, M5: Module, M6: Module, M7: Module, M8: Module, M9: Module>(_ m0: M0, _ m1: M1, _ m2: M2, _ m3: M3, _ m4: M4, _ m5: M5, _ m6: M6, _ m7: M7, _ m8: M8, _ m9: M9) -> [ParentMachine<AppEvent, AppEvent>] where M0.AppEvent == AppEvent, M1.AppEvent == AppEvent, M2.AppEvent == AppEvent, M3.AppEvent == AppEvent, M4.AppEvent == AppEvent, M5.AppEvent == AppEvent, M6.AppEvent == AppEvent, M7.AppEvent == AppEvent, M8.AppEvent == AppEvent, M9.AppEvent == AppEvent {
        [m0.withMappersApplied, m1.withMappersApplied, m2.withMappersApplied, m3.withMappersApplied, m4.withMappersApplied, m5.withMappersApplied, m6.withMappersApplied, m7.withMappersApplied, m8.withMappersApplied, m9.withMappersApplied]
    }
}

fileprivate extension Module {
 
    
    var withMappersApplied: ParentMachine<AppEvent, AppEvent> {
        let tuple = gateways.array.reduce(
            (
                { _ in [] },
                { _ in [] }
            )
        ) { acc, element in
            (
                { acc.0($0) + element.mapInput($0) },
                { acc.1($0) + element.mapOutput($0) }
            )
        }
        
        return ParentMachine(machine.inward(tuple.0).outward(tuple.1))
    }
}

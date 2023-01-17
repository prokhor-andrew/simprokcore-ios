//
//  GatewaysBuilder.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//


@resultBuilder
public struct GatewaysBuilder<AppEvent, Input, Output> {

    private init() {}
    
    public static func buildBlock(_ components: Gateways<AppEvent, Input, Output>...) -> [Gateway<AppEvent, Input, Output>] {
        components.flatMap { $0.array }
    }
    
    public static func buildBlock<M0: GateProtocol>(_ m0: M0) -> [Gateway<AppEvent, Input, Output>] where M0.Feature.AppEvent == AppEvent, M0.Input == Input, M0.Output == Output {
        [Gateway(m0)]
    }
    
    public static func buildBlock<M0: GateProtocol, M1: GateProtocol>(_ m0: M0, _ m1: M1) -> [Gateway<AppEvent, Input, Output>] where M0.Feature.AppEvent == AppEvent, M0.Input == Input, M0.Output == Output, M1.Feature.AppEvent == AppEvent, M1.Input == Input, M1.Output == Output {
        [Gateway(m0), Gateway(m1)]
    }
    
    public static func buildBlock<M0: GateProtocol, M1: GateProtocol, M2: GateProtocol>(_ m0: M0, _ m1: M1, _ m2: M2) -> [Gateway<AppEvent, Input, Output>] where M0.Feature.AppEvent == AppEvent, M0.Input == Input, M0.Output == Output, M1.Feature.AppEvent == AppEvent, M1.Input == Input, M1.Output == Output, M2.Input == Input, M2.Output == Output, M2.Feature.AppEvent == AppEvent {
        [Gateway(m0), Gateway(m1), Gateway(m2)]
    }
    
    public static func buildBlock<M0: GateProtocol, M1: GateProtocol, M2: GateProtocol, M3: GateProtocol>(_ m0: M0, _ m1: M1, _ m2: M2, _ m3: M3) -> [Gateway<AppEvent, Input, Output>] where M0.Feature.AppEvent == AppEvent, M0.Input == Input, M0.Output == Output, M1.Feature.AppEvent == AppEvent, M1.Input == Input, M1.Output == Output, M2.Input == Input, M2.Output == Output, M2.Feature.AppEvent == AppEvent, M3.Input == Input, M3.Output == Output, M3.Feature.AppEvent == AppEvent {
        [Gateway(m0), Gateway(m1), Gateway(m2), Gateway(m3)]
    }
    
    public static func buildBlock<M0: GateProtocol, M1: GateProtocol, M2: GateProtocol, M3: GateProtocol, M4: GateProtocol>(_ m0: M0, _ m1: M1, _ m2: M2, _ m3: M3, _ m4: M4) -> [Gateway<AppEvent, Input, Output>] where M0.Feature.AppEvent == AppEvent, M0.Input == Input, M0.Output == Output, M1.Feature.AppEvent == AppEvent, M1.Input == Input, M1.Output == Output, M2.Input == Input, M2.Output == Output, M2.Feature.AppEvent == AppEvent, M3.Input == Input, M3.Output == Output, M3.Feature.AppEvent == AppEvent, M4.Input == Input, M4.Output == Output, M4.Feature.AppEvent == AppEvent {
        [Gateway(m0), Gateway(m1), Gateway(m2), Gateway(m3), Gateway(m4)]
    }
    
    public static func buildBlock<M0: GateProtocol, M1: GateProtocol, M2: GateProtocol, M3: GateProtocol, M4: GateProtocol, M5: GateProtocol>(_ m0: M0, _ m1: M1, _ m2: M2, _ m3: M3, _ m4: M4, _ m5: M5) -> [Gateway<AppEvent, Input, Output>] where M0.Feature.AppEvent == AppEvent, M0.Input == Input, M0.Output == Output, M1.Feature.AppEvent == AppEvent, M1.Input == Input, M1.Output == Output, M2.Input == Input, M2.Output == Output, M2.Feature.AppEvent == AppEvent, M3.Input == Input, M3.Output == Output, M3.Feature.AppEvent == AppEvent, M4.Input == Input, M4.Output == Output, M4.Feature.AppEvent == AppEvent, M5.Input == Input, M5.Output == Output, M5.Feature.AppEvent == AppEvent {
        [Gateway(m0), Gateway(m1), Gateway(m2), Gateway(m3), Gateway(m4), Gateway(m5)]
    }
    
    public static func buildBlock<M0: GateProtocol, M1: GateProtocol, M2: GateProtocol, M3: GateProtocol, M4: GateProtocol, M5: GateProtocol, M6: GateProtocol>(_ m0: M0, _ m1: M1, _ m2: M2, _ m3: M3, _ m4: M4, _ m5: M5, _ m6: M6) -> [Gateway<AppEvent, Input, Output>] where M0.Feature.AppEvent == AppEvent, M0.Input == Input, M0.Output == Output, M1.Feature.AppEvent == AppEvent, M1.Input == Input, M1.Output == Output, M2.Input == Input, M2.Output == Output, M2.Feature.AppEvent == AppEvent, M3.Input == Input, M3.Output == Output, M3.Feature.AppEvent == AppEvent, M4.Input == Input, M4.Output == Output, M4.Feature.AppEvent == AppEvent, M5.Input == Input, M5.Output == Output, M5.Feature.AppEvent == AppEvent, M6.Input == Input, M6.Output == Output, M6.Feature.AppEvent == AppEvent {
        [Gateway(m0), Gateway(m1), Gateway(m2), Gateway(m3), Gateway(m4), Gateway(m5), Gateway(m6)]
    }
    
    public static func buildBlock<M0: GateProtocol, M1: GateProtocol, M2: GateProtocol, M3: GateProtocol, M4: GateProtocol, M5: GateProtocol, M6: GateProtocol, M7: GateProtocol>(_ m0: M0, _ m1: M1, _ m2: M2, _ m3: M3, _ m4: M4, _ m5: M5, _ m6: M6, _ m7: M7) -> [Gateway<AppEvent, Input, Output>] where M0.Feature.AppEvent == AppEvent, M0.Input == Input, M0.Output == Output, M1.Feature.AppEvent == AppEvent, M1.Input == Input, M1.Output == Output, M2.Input == Input, M2.Output == Output, M2.Feature.AppEvent == AppEvent, M3.Input == Input, M3.Output == Output, M3.Feature.AppEvent == AppEvent, M4.Input == Input, M4.Output == Output, M4.Feature.AppEvent == AppEvent, M5.Input == Input, M5.Output == Output, M5.Feature.AppEvent == AppEvent, M6.Input == Input, M6.Output == Output, M6.Feature.AppEvent == AppEvent, M7.Input == Input, M7.Output == Output, M7.Feature.AppEvent == AppEvent {
        [Gateway(m0), Gateway(m1), Gateway(m2), Gateway(m3), Gateway(m4), Gateway(m5), Gateway(m6), Gateway(m7)]
    }
    
    public static func buildBlock<M0: GateProtocol, M1: GateProtocol, M2: GateProtocol, M3: GateProtocol, M4: GateProtocol, M5: GateProtocol, M6: GateProtocol, M7: GateProtocol, M8: GateProtocol>(_ m0: M0, _ m1: M1, _ m2: M2, _ m3: M3, _ m4: M4, _ m5: M5, _ m6: M6, _ m7: M7, _ m8: M8) -> [Gateway<AppEvent, Input, Output>] where M0.Feature.AppEvent == AppEvent, M0.Input == Input, M0.Output == Output, M1.Feature.AppEvent == AppEvent, M1.Input == Input, M1.Output == Output, M2.Input == Input, M2.Output == Output, M2.Feature.AppEvent == AppEvent, M3.Input == Input, M3.Output == Output, M3.Feature.AppEvent == AppEvent, M4.Input == Input, M4.Output == Output, M4.Feature.AppEvent == AppEvent, M5.Input == Input, M5.Output == Output, M5.Feature.AppEvent == AppEvent, M6.Input == Input, M6.Output == Output, M6.Feature.AppEvent == AppEvent, M7.Input == Input, M7.Output == Output, M7.Feature.AppEvent == AppEvent, M8.Input == Input, M8.Output == Output, M8.Feature.AppEvent == AppEvent {
        [Gateway(m0), Gateway(m1), Gateway(m2), Gateway(m3), Gateway(m4), Gateway(m5), Gateway(m6), Gateway(m7), Gateway(m8)]
    }
    
    public static func buildBlock<M0: GateProtocol, M1: GateProtocol, M2: GateProtocol, M3: GateProtocol, M4: GateProtocol, M5: GateProtocol, M6: GateProtocol, M7: GateProtocol, M8: GateProtocol, M9: GateProtocol>(_ m0: M0, _ m1: M1, _ m2: M2, _ m3: M3, _ m4: M4, _ m5: M5, _ m6: M6, _ m7: M7, _ m8: M8, _ m9: M9) -> [Gateway<AppEvent, Input, Output>] where M0.Feature.AppEvent == AppEvent, M0.Input == Input, M0.Output == Output, M1.Feature.AppEvent == AppEvent, M1.Input == Input, M1.Output == Output, M2.Input == Input, M2.Output == Output, M2.Feature.AppEvent == AppEvent, M3.Input == Input, M3.Output == Output, M3.Feature.AppEvent == AppEvent, M4.Input == Input, M4.Output == Output, M4.Feature.AppEvent == AppEvent, M5.Input == Input, M5.Output == Output, M5.Feature.AppEvent == AppEvent, M6.Input == Input, M6.Output == Output, M6.Feature.AppEvent == AppEvent, M7.Input == Input, M7.Output == Output, M7.Feature.AppEvent == AppEvent, M8.Input == Input, M8.Output == Output, M8.Feature.AppEvent == AppEvent, M9.Input == Input, M9.Output == Output, M9.Feature.AppEvent == AppEvent {
        [Gateway(m0), Gateway(m1), Gateway(m2), Gateway(m3), Gateway(m4), Gateway(m5), Gateway(m6), Gateway(m7), Gateway(m8), Gateway(m9)]
    }
}

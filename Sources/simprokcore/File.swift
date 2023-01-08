//
//  File.swift
//  
//
//  Created by Andriy Prokhorenko on 08.01.2023.
//

import simprokmachine
import simprokstate

public enum ChildlessFeatureTransition<F: ChildlessFeatured> {
    case skip
    case set(F)
}

public protocol ChildlessFeatured: Featured
where ExternalTrigger == Input,
      ExternalEffect == Output,
      ToFeatured == ToChildlessFeatured {
    
    associatedtype Input
    associatedtype Output
    
    associatedtype ToChildlessFeatured: ChildlessFeatured where ToChildlessFeatured.Input == Input, ToChildlessFeatured.Output == Output
    
    func outputs() -> [Output]
    
    func transit(input: Input) -> ChildlessFeatureTransition<ToChildlessFeatured>
}

public extension ChildlessFeatured {
    
    var machines: [ParentAutomaton<InternalEffect, InternalTrigger>] { [] }
    
    func effects() -> [FeatureEvent<InternalEffect, ExternalEffect>] {
        outputs().map { .ext($0) }
    }
    
    func transit(trigger: FeatureEvent<InternalTrigger, ExternalTrigger>) -> FeatureTransition<ToFeatured> {
        switch trigger {
        case .int:
            return .skip
        case .ext(let value):
            switch transit(input: value) {
            case .skip:
                return .skip
            case .set(let childlessFeatured):
                return .set(childlessFeatured)
            }
        }
    }
}

public struct MyTest: ChildlessFeatured {
    public typealias InternalTrigger = Void
    public typealias InternalEffect = Void
    public typealias ExternalTrigger = Int
    public typealias ExternalEffect = Double
//    public typealias Input = Int
//    public typealias Output = Double
    public typealias ToChildlessFeatured = MyTest
    
    public func outputs() -> [Double] {
        []
    }
    
    public func transit(input: Int) -> ChildlessFeatureTransition<MyTest> {
        .skip
    }
}

//public protocol AppFeatured: ChildlessFeatured where InternalEffect == {
//
//}

//
//  Sources.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

import simprokmachine


public struct Sources<AppEvent> {
 
    internal let sources: [Source<AppEvent>]
    
    public init(_ array: [Source<AppEvent>] = []) {
        self.sources = array
    }
    
    public init(@SourcesBuilder<AppEvent> _ build: Supplier<[Source<AppEvent>]>) {
        self.init(build())
    }
}

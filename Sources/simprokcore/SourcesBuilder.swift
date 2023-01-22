//
//  SourcesBuilder.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

@resultBuilder
public struct SourcesBuilder<AppEvent> {
    
    private init() {
        
    }
    
    public static func buildBlock(_ components: Sources<AppEvent>...) -> [Source<AppEvent>] {
        components.flatMap { $0.sources }
    }
    
    public static func buildBlock(_ components: Source<AppEvent>...) -> [Source<AppEvent>] {
        components
    }
}

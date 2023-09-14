//
//  PluginsBuilder.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//

@resultBuilder
public struct PluginsBuilder: Sendable {
    
    private init() {
        
    }
    
    public static func buildBlock(_ components: Plugin...) -> [Plugin] {
        components
    }
}

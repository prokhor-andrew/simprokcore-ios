//
//  SourceBuilder.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.
//


@resultBuilder
public struct SourceBuilder<AppEvent, Input, Output> {

    private init() {
    }

    public static func buildBlock(_ components: Gateway<AppEvent, Input, Output>...) -> [Gateway<AppEvent, Input, Output>] {
        components
    }
}

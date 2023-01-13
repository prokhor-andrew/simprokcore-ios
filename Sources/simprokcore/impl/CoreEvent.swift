//
//  CoreEvent.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.


internal enum CoreEvent<AppEvent> {
    case fromReducer(AppEvent)
    case fromModule(AppEvent)
}

//
//  ReducerResult.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.


/// A type that represents a behavior of global reducer.
public enum ReducerResult<GlobalState> {
    /// Returning this value from `Core.reducer()` method ensures that the global state will be changed to the passed value.
    case set(GlobalState)
    
    /// Returning this value from `Core.reducer()` method ensures that the global state won't be changed.
    case skip
}

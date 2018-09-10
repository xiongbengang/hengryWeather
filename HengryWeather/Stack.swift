//
//  Stack.swift
//  HengryWeather
//
//  Created by CC on 2018/9/4.
//  Copyright © 2018年 puerjia. All rights reserved.
//

import Foundation

public struct Stack<T>: CustomStringConvertible {
    private var elements: [T]
    
    init() {
        self.elements = [T]()
    }
    
    init(_ elements:[T]) {
        self.elements = elements
    }
    
    public var isEmpty: Bool {
        return self.elements.isEmpty
    }
    
    public var count: Int {
        return self.elements.count
    }
    
    public mutating func push(_ element: T) {
        self.elements.append(element)
    }
    
    public func top() -> T? {
        if self.isEmpty { return nil }
        return self.elements.last
    }
    
    @discardableResult
    public mutating func pop() -> T? {
        if self.isEmpty { return nil }
        return self.elements.removeLast()
    }
    
    public var description: String {
        var desc = ""
        for (index, e) in self.elements.enumerated() {
            if index == 0 {
                desc.append("\(e)")
            } else {
                desc.append(" \(e)")
            }
        }
        desc.append(" Top")
        return desc
    }
}

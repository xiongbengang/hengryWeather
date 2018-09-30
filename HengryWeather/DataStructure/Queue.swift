//
//  Queu.swift
//  HengryWeather
//
//  Created by CC on 2018/9/4.
//  Copyright © 2018年 puerjia. All rights reserved.
//

import Foundation

public struct Queue<T>: CustomStringConvertible {
    private var elements: [T]
    public init(_ elements: [T]) {
        self.elements = elements
    }
    
    public init() {
        self.elements = [T]()
    }
    
    public var isEmpty: Bool {
        return self.elements.isEmpty
    }
    
    public var count: Int {
        return self.elements.count
    }
    
    public mutating func enqueue(_ element: T) {
        self.elements.append(element)
    }
    
    public mutating func dequeue() -> T {
        if self.isEmpty { fatalError("queue is empty") }
        return self.elements.removeFirst()
    }
    
    public var description: String {
        var desc = "Front"
        for (idx, e) in self.elements.enumerated() {
            if idx == 0 {
                desc.append("\(e)")
            } else {
                desc.append(" \(e)")
            }
        }
        desc.append(" Tail")
        return desc
    }
    
}

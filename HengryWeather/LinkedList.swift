//
//  LinkedList.swift
//  HengryWeather
//
//  Created by CC on 2018/9/4.
//  Copyright © 2018年 puerjia. All rights reserved.
//

import Foundation

public class Node<T>: CustomStringConvertible {
    var value: T
    var next: Node<T>?
    init(value:T) {
        self.value = value
    }
    init?(with array:[T]) {
        if array.count <= 0 { return nil }
        self.value = array.first!
        var previous:Node<T> = self
        for (index, value) in array.enumerated() {
            if index != 0 {
                previous.next = Node(value: value)
                previous = previous.next!
            }
        }
    }
    public var description: String {
        if self.next == nil {
            return "\(value) -> NULL"
        } else {
            return "\(value) -> \(self.next!.description)"
        }
    }
    
    public func reversed() -> Node<T>{
        var previous:Node<T>? = nil
        var current = self
        var next = current.next
        while next != nil {
            let nextNext = next?.next
            current.next = previous
            next?.next = current
            previous = current
            current = next!
            next = nextNext
        }
        return current
    }
}

public let testLinkList:Node = Node(with: [1,2,3,4,5,6,7,8])!

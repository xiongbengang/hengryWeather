//
//  LinkedList.swift
//  HengryWeather
//
//  Created by CC on 2018/9/4.
//  Copyright © 2018年 puerjia. All rights reserved.
//

import Foundation

public class LinkedList<T: Comparable>: CustomStringConvertible {
    
    private class Node<T>: CustomStringConvertible {
        var value: T?
        var next: Node<T>?
        init() {
            self.value = nil;
            self.next = nil
        }
        init(value: T, next: Node? = nil) {
            self.value = value
            self.next = next
        }
        var description: String {
            if let value = self.value {
                return "\(value)"
            } else {
                return "DummyHead"
            }
        }
    }
    
    private var dummyHead: Node = Node<T>()
    public var count: Int = 0
    
    init() {
        self.count = 0
        self.dummyHead = Node()
    }
    
    public var isEmpty: Bool {
        return count <= 0
    }
    
    public func addAtHead(element: T) {
        dummyHead.next = Node(value: element, next: dummyHead.next)
        count += 1
    }
    
    public func addAtTail(element: T) {
        var previous: Node<T> = dummyHead
        while let next = previous.next {
            previous = next
        }
        previous.next = Node(value: element)
        count += 1
    }
    
    public func remove(element: T) {
        var previous = dummyHead
        var curr = dummyHead.next
        while curr != nil {
            if curr!.value == element {
                previous.next = curr!.next
                curr = curr!.next
            } else {
                previous = curr!
                curr = curr!.next
            }
        }
    }
    
    public func reverse() {
        var pre: Node<T>? = nil
        var cur: Node<T>? = dummyHead.next
        var next: Node<T>? = cur?.next
        while next != nil {
            let nextNext = next!.next
            next?.next = cur
            cur?.next = pre
            pre = cur
            cur = next
            next = nextNext
        }
        dummyHead.next = cur
    }
    
    private func description(head: Node<T>?) -> String {
        guard let head = head else { return "NULL" }
        return "\(head) -> \(self.description(head: head.next))"
    }
    
    public var description: String {
        return description(head: dummyHead.next)
    }
}

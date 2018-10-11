//
//  MaxHeap.swift
//  HengryWeather
//
//  Created by bengang on 2018/9/28.
//  Copyright © 2018年 puerjia. All rights reserved.
//

import Foundation

public struct MaxHeap<E: Comparable>: CustomStringConvertible {
    private var datas: [E]
    public init(_ elements: [E]) {
        self.init()
        for element in elements {
            datas.append(element)
        }
        for index in stride(from: datas.count-1, through: 0, by: -1) {
            shiftDown(index: index)
        }
    }
    
    public init() {
        self.datas = []
    }
    
    public var count: Int {
        return datas.count
    }
    
    public var isEmpty: Bool {
        return count <= 0
    }
    
    public mutating func add(_ element: E) {
        datas.append(element)
        shiftUp(index: datas.count - 1)
    }
    
    public func peek() -> E? {
        if self.isEmpty {
            return nil
        }
        return self.datas.first
    }
    
    public mutating func extractMax() -> E {
        if self.isEmpty {
            fatalError("cann't extractMax when empty!")
        }
        let element = self.datas[0]
        datas.swapAt(0, self.datas.count-1)
        datas.removeLast()
        shiftDown(index: 0)
        return element
    }
    
    private mutating func shiftDown(index: Int) {
        var index = index
        while leftChild(of: index) < datas.count {
            var j = leftChild(of: index)
            let right = j+1
            if right < datas.count && datas[right] > datas[j] {
                j = right
            }
            if datas[index] > datas[j] { break }
            datas.swapAt(index, j)
            index = j;
        }
    }
    
    private mutating func shiftUp(index: Int) {
        var index = index
        while index > 0 && datas[index] > datas[parent(of: index)] {
            datas.swapAt(index, parent(of: index))
            index = parent(of: index)
        }
    }
    
    private func parent(of index: Int) -> Int {
        return (index - 1) / 2
    }
    
    private func leftChild(of index: Int) -> Int {
        return index * 2 + 1
    }
    
    private func rightChild(of index: Int) -> Int {
        return index * 2 + 2
    }
    
    public var description: String {
        if self.isEmpty {
            return "NULL"
        }
        return BinaryTreeLogger.treeString(0) { (index: Int) -> (String, Int?, Int?) in
            let left: Int? = leftChild(of: index) < self.datas.count ? leftChild(of: index) : nil
            let right: Int? = rightChild(of: index) < self.datas.count ? rightChild(of: index) : nil
            return ("\(index)", left, right)
        }
    }
}

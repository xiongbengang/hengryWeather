//
//  Algorithm.swift
//  HengryWeather
//
//  Created by CC on 2018/9/4.
//  Copyright © 2018年 puerjia. All rights reserved.
//

import Foundation

class Algorithm {
    func main() {
        testTreeNodeTraverse()
        testStack()
        
        print(sum(100))
        print(tailSum(100))
        
        var mergeArra = [1,6,7,8,3,4,2,4,5,7,2,3,54,5]
//        mergeSort(&mergeArra)
        insertSort(&mergeArra)
        print(mergeArra)
    }
    func testTreeNodeTraverse() {
        print("preorder:\(testNode.inorderPath())")
        print("inorder:\(testNode.inorderPath())")
        print("tailorder:\(testNode.postorderPath())")
        print("bstTraverse: \(testNode.bsfTraverse())")
    }
    
    func testStack() {
        var stack = Stack([1,2,3,4,5,6,7,8,9])
        print(stack)
        stack.push(10)
        print(stack)
        
        print("top is :\(stack.top()!)")
        print("pop a element: \(stack.pop()!)")
        print("after pop: \(stack)")
    }
    
    func sum(_ n:Int) -> Int {
        if n == 0 { return 0 }
        return n + sum(n-1)
    }
    
    func tailSum(_ n: Int) -> Int {
        func tailSum(n: Int, current: Int) -> Int {
            if n == 0 { return current }
            return tailSum(n: n-1, current: current + n)
        }
        return tailSum(n: n, current: 0)
    }
    
    public func mergeSort(_ array: inout [Int]) {
        
        func mergeSort(_ array: inout [Int], left: Int, right: Int) {
            if left >= right { return }
            let mid = left + (right - left)/2
            mergeSort(&array, left: left, right: mid)
            mergeSort(&array, left: mid+1, right: right)
            merge(&array, left: left, mid: mid, right: right)
        }
        
        func merge(_ array: inout [Int], left:Int, mid:Int, right:Int) {
            var res = [Int](repeating:0, count: right-left+1)
            for i in left...right {
                res[i-left] = array[i]
            }
            var i = left, j = mid + 1
            for k in left...right {
                if i > mid {
                    array[k] = res[j-left]
                    j += 1
                } else if (j > right) {
                    array[k] = res[i-left]
                    i += 1
                } else if res[i-left] < res[j-left] {
                    array[k] = res[i-left]
                    i += 1
                } else {
                    array[k] = res[j-left]
                    j += 1
                }
            }
        }
        mergeSort(&array, left: 0, right: array.count-1)
    }
    
    public func selectionSort(_ array: inout [Int]) {
        for i in 0..<array.count {
            var minIndex = i
            for j in i+1..<array.count {
                if array[j] < array[minIndex] {
                    minIndex = j
                }
            }
            if(i != minIndex) {
                array.swapAt(i, minIndex)
            }
        }
    }
    
    public func bubbleSort(_ array: inout [Int]) {
        for i in 0..<array.count {
            var swaped = false
            for j in 0..<array.count-i-1 {
                if array[j] > array[j+1] {
                    array.swapAt(j, j+1)
                    swaped = true
                }
            }
            if !swaped {
                break
            }
        }
    }
    
    public func insertSort(_ array: inout [Int]) {
        for i in 1..<array.count {
            var j = i
            while j > 0 && array [j] < array[j-1] {
                array.swapAt(j, j-1)
                j -= 1
            }
        }
    }
    
    public func quickSort(_ array: inout [Int]) {
        // 对array[l...r]进行partation操作 返回p 使得array[l...p-1] < array[p], array[p+1...r] > array[p]
        func partation(_ array: inout [Int], l: Int, r: Int) -> Int {
            let v = array[l]
            
            // array[l+1...j] < v   array[j+1...i) > v
            var i = l+1, j = l
            while i <= r {
                if array[i] > v {
                    i += 1
                } else {
                    array.swapAt(j+1, i)
                    j += 1
                    i += 1
                }
            }
            array.swapAt(l, j)
            return j
        }
    }
}

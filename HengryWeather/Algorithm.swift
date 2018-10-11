//
//  Algorithm.swift
//  HengryWeather
//
//  Created by CC on 2018/9/4.
//  Copyright © 2018年 puerjia. All rights reserved.
//

import Foundation

class Algorithm {
    
    var name: String?
    
    func main() {
        let bst = BinarySearchTree<Int>()

        bst.add(element: 23)
        bst.add(element: 19)
        bst.add(element: 44)
//        bst.add(element: 29)
//        bst.add(element: 12)
//        bst.add(element: 9)
//        bst.add(element: 10)
//        bst.add(element: 50)
//        bst.add(element: 1)
//        bst.add(element: 40)
//        bst.add(element: 15)
//        bst.add(element: 18)
//        bst.add(element: 32)
//        bst.add(element: 22)
//        bst.add(element: 21)
//        bst.add(element: 19)
//        bst.add(element: 14)
//        bst.add(element: 24)
//        bst.add(element: 20)
    
        var maxHeap = MaxHeap<Int>()
        var datas = [Int]()
        for _ in 0...10 {
            let randomNumber = Int.random(in: 0...100)
            datas.append(randomNumber)
            maxHeap.add(randomNumber)
        }
        
        print("maxHeap datas: \(datas)")
        print("before extractMax---------------")
        print(maxHeap)
        print("*********************************")
        
        var orderedDatas:String = "["
        while !maxHeap.isEmpty {
            let e = maxHeap.extractMax()
            if maxHeap.isEmpty {
                orderedDatas.append("\(e)")
            } else {
                orderedDatas.append("\(e) ")
            }
            print("extra a element: \(e)")
            print("after extractMax---------------")
            print(maxHeap)
        }
        orderedDatas.append("]")
        print("ordered elements:\(orderedDatas)")
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
}

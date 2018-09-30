//
//  Algorithm.swift
//  HengryWeather
//
//  Created by CC on 2018/9/3.
//  Copyright © 2018年 puerjia. All rights reserved.
//

import Foundation

public class TreeNode<T>:CustomStringConvertible {
    var value:T
    var left:TreeNode<T>?
    var right:TreeNode<T>?
    init(_ value:T) {
        self.value = value
        self.left = nil
        self.right = nil
    }
    public init(_ value: T, left: TreeNode<T>? = nil, right: TreeNode<T>? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }
    
    public var description: String {
        if let left = left, let right = right {
            return "[\(left) <- \(value) -> \(right)]"
        } else if let left = left {
            return "[\(left) <- \(value)]"
        } else if let right = right {
            return "[\(value) -> \(right)]"
        } else {
            return "[\(value)]"
        }
    }
    
    public func reversed() -> TreeNode<T> {
        return reverseTree(root: self)!
    }
    
    private func reverseTree<T>(root:TreeNode<T>?) -> TreeNode<T>? {
        guard let root = root else {
            return nil
        }
        let reversedLeft = reverseTree(root: root.right)
        let reversedRight = reverseTree(root: root.left)
        root.left = reversedLeft
        root.right = reversedRight
        return root
    }
    
    public func allPath<T>(from root: TreeNode<T>) -> [String] {
        var result: [String] = [String]()
        fillPath(from: root, path: "", to: &result)
        return result
    }
    
    private func fillPath<T>(from root: TreeNode<T>, path:String, to result: inout [String]) {
        var newPath = path
        if path.count == 0 {
            newPath.append("\(root.value)")
        } else {
            newPath.append(" -> \(root.value)")
        }
        if root.left == nil && root.right == nil {  // 叶子节点
            result.append(newPath)
            return
        }
        if let left = root.left {
            fillPath(from: left, path: newPath, to: &result)
        }
        if let right = root.right {
            fillPath(from: right, path: newPath, to: &result)
        }
    }
    
    public var level: Int {
        return level(of: self, currentLevel: 0)
    }
    
    private func level(of root: TreeNode<T>, currentLevel:Int) -> Int {
        let recentLevel = currentLevel+1
        if root.left == nil && root.right == nil {
            return recentLevel
        }
        var leftLevel = 0
        var rightLevel = 0
        if let left = root.left {
            leftLevel = level(of: left, currentLevel: recentLevel)
        }
        if let right = root.right {
            rightLevel = level(of: right, currentLevel: recentLevel)
        }
        return max(leftLevel, rightLevel)
    }
    
    public func bsfTraverse() -> String {
        var queue = Queue<TreeNode>()
        queue.enqueue(self)
        var path = ""
        while !queue.isEmpty {
            let top = queue.dequeue()
            if path.isEmpty {
                path.append("\(top.value)")
            } else {
                path.append(" -> \(top.value)")
            }
            if let left = top.left {
                queue.enqueue(left)
            }
            if let right = top.right {
                queue.enqueue(right)
            }
        }
        return path
    }
    
    public func preorderPath() -> String {
        var info = ""
        preorder(node: self, printInfo: &info)
        return info
    }
    
    public func inorderPath() -> String {
        var info = ""
        inorder(node: self, printInfo: &info)
        return info
    }
    
    public func postorderPath() -> String {
        var info = ""
        postorder(node: self, printInfo: &info)
        return info
    }
    
    private func preorder(node: TreeNode, printInfo:inout String) {
        if printInfo.count == 0 {
            printInfo.append("\(node.value)")
        } else {
            printInfo.append(" -> \(node.value)")
        }
        if let left = node.left {
            preorder(node: left, printInfo: &printInfo)
        }
        if let right = node.right {
            preorder(node: right, printInfo: &printInfo)
        }
    }
    
    private func inorder(node: TreeNode, printInfo: inout String) {
        if let left = node.left {
            inorder(node: left, printInfo: &printInfo)
        }
        if printInfo.count == 0 {
            printInfo.append("\(node.value)")
        } else {
            printInfo.append(" -> \(node.value)")
        }
        if let right = node.right {
            inorder(node: right, printInfo: &printInfo)
        }
    }
    
    private func postorder(node: TreeNode, printInfo: inout String) {
        if let left = node.left {
            postorder(node: left, printInfo: &printInfo)
        }
        if let right = node.right {
            postorder(node: right, printInfo: &printInfo)
        }
        if printInfo.count == 0 {
            printInfo.append("\(node.value)")
        } else {
            printInfo.append(" -> \(node.value)")
        }
    }
}

public let testNode:TreeNode<Int> = {
    let eight = TreeNode(8)
    let nine = TreeNode(9)
    let four = TreeNode(4)
    let six = TreeNode(6)
    let ten = TreeNode(10)
    let three = TreeNode(3, left:eight, right: nine)
    let two = TreeNode(2, left: three, right: four)
    let seven = TreeNode(7, right: ten)
    let five = TreeNode(5, left: six, right: seven)
    let root = TreeNode(1, left: two, right: five)
    return root
}()



//
//  BinarySearchTree.swift
//  HengryWeather
//
//  Created by bengang on 2018/9/28.
//  Copyright © 2018年 puerjia. All rights reserved.
//

import Foundation

public class BinarySearchTree<T: Comparable>: CustomStringConvertible {
    
    fileprivate class Node {
        var value: T
        var left: Node?
        var right: Node?
        var level: Int = 1
    
        init(value: T) {
            self.value = value
            self.left = nil;
            self.right = nil;
        }
    }
    
    public var count: Int = 0
    
    fileprivate var root: Node?
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    public func add(element: T) {
        root = add(element: element, to: root, level: 0)
    }
    
    private func add(element:T, to root:Node?, level:Int) -> Node {
        guard let root = root else {
            let newNode = Node(value: element)
            count += 1
            newNode.level = level+1
            return newNode
        }
        if element < root.value {
            root.left = add(element: element, to: root.left, level: level + 1)
        } else {
            root.right = add(element: element, to: root.right, level: level + 1)
        }
        return root
    }
    
    public func removeMax() -> T? {
        guard let rootNode = root else { return nil }
        return removeMax(root: rootNode)?.value
    }
    
    private func removeMax(root: Node) -> Node? {
        guard let right = root.right else {
            let leftNode = root.left
            root.left = nil
            count -= 1
            return leftNode
        }
        root.right = removeMax(root: right)
        return root
    }
    
    public func removeMin() -> T? {
        guard let rootNode = root else { return nil }
        return removeMin(root: rootNode)?.value
    }
    
    private func removeMin(root: Node) -> Node? {
        guard let leftNode = root.left else {
            let rightNode = root.right
            root.right = nil
            count -= 1
            return rightNode
        }
        root.left = removeMin(root: leftNode)
        return root
    }
    
    public func remove(element: T) {
        guard let root = root else { return }
        self.root = remove(element: element, from: root)
    }
    
    private func remove(element: T, from root: Node) -> Node? {
        if element < root.value {
            guard let leftNode = root.left else { return nil }
            root.left = remove(element: element, from: leftNode)
            return root
        } else if element > root.value {
            guard let rightNode = root.right else { return nil }
            root.right = remove(element: element, from: rightNode)
            return rightNode
        } else {
            guard let leftNode = root.left else {
                let rightNode = root.right
                root.right = nil
                count -= 1
                return rightNode
            }
            guard let rightNode = root.right else {
                let leftNode = root.left
                root.left = nil
                count -= 1
                return leftNode
            }
            
            let successor = min(root: rightNode)
            successor.right = removeMin(root: rightNode)
            successor.left = leftNode
            root.left = nil
            root.right = nil
            return successor
        }
    }
    
    public func max() -> T? {
        guard let root = root else {
            return nil
        }
        return max(root: root).value
    }
    
    private func max(root: Node) -> Node {        // 不存在右子树了 则该节点为最大值
        guard let right = root.right else { return root }
        return max(root: right)
    }
    
    public func min() -> T? {
        guard let root = root else { return nil }
        return min(root: root).value
    }
    
    private func min(root: Node) -> Node{
        guard let left = root.left else { return root }       // 不存在左子树了  则该节点为最小值
        return min(root: left)
    }
    
    public func contains(element: T) -> Bool {
        return contains(element: element, root: root)
    }
    
    private func contains(element: T, root: Node?) -> Bool {
        guard let root = root else { return false }
        if root.value == element {
            return true
        } else if element < root.value {
            return contains(element: element, root: root.left)
        } else {
            return contains(element: element, root: root.right)
        }
    }
    
    public typealias TraverseAction = (T) -> ()
    
    public func preOrder(action: TraverseAction?) {
        preOrder(root: root, action: nil)
    }
    
    private func preOrder(root: Node?, action:TraverseAction?) {
        guard let root = root else { return }
        action?(root.value)
        preOrder(root: root.left, action: action)
        preOrder(root: root.right, action: action)
    }
    
    public func inOrder(action: TraverseAction?) {
        inOrder(root: root, action: action)
    }
    
    private func inOrder(root: Node?, action: TraverseAction?) {
        guard let root = root else {
            return
        }
        inOrder(root: root.left, action: action)
        action?(root.value)
        inOrder(root: root.right, action: action)
    }
    
    public func levelOrder(action: TraverseAction?) {
        guard let root = root else { return }
        var queue = Queue<Node>()
        queue.enqueue(root)
        while !queue.isEmpty {
            let e:Node = queue.dequeue()
            action?(e.value)
            if let left = e.left {
                queue.enqueue(left)
            }
            if let right = e.right {
                queue.enqueue(right)
            }
        }
    }
    
    public func levelPrint() {
        levelOrder { (e) in
            print(e, terminator: " ")
        }
        print("")
    }
    
    public var height: Int {
        return height(for: root, level: 0)
    }
    
    private func height(for root: Node?, level: Int) -> Int {
        guard let root = root else {
            return level
        }
        let leftHeight = height(for: root.left, level: level+1)
        let rightHeight = height(for: root.right, level: level+1)
        return Swift.max(leftHeight, rightHeight)
    }

    public var description: String {
        guard let root = root else { return "NULL" }
        return BinaryTreeLogger.treeString(root) { (node:Node) -> (String, Node?, Node?) in
            return ("\(node.value)", node.left, node.right)
        }
    }
}

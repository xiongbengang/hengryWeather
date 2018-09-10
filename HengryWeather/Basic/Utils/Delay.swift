//
//  Delay.swift
//  HengryWeather
//
//  Created by Bengang on 2018/8/16.
//  Copyright © 2018 puerjia. All rights reserved.
//

import Foundation

public typealias DelayedTask = (Bool) -> Void

@discardableResult
public func delay(_ time:TimeInterval, task:@escaping ()->()) -> DelayedTask? {
    func dispatch_later(block:@escaping ()->()) {
        let t = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: t, execute: block)
    }
    var closure:(()->())? = task
    var result:DelayedTask?
    
    let delayClosure:DelayedTask = {
        (cancel:Bool) in
        if let internalClosure = closure {
            if cancel == false {
                DispatchQueue.main.async(execute: internalClosure)
            }
        } else {
            print("task is canceled")
        }
        closure = nil
        result = nil
    }
    result = delayClosure
    
    dispatch_later {
        print("执行dispatch_later after\(time)")
        if let delayedClosure = result {
            delayedClosure(false)
        }
    }
    return result
}

public func cancel(_ task:DelayedTask?) {
    print("取消task")
    task?(true)
}


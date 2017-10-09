//
//  Dispatcher.swift
//  DifferDemo
//
//  Created by corin on 2017/10/09.
//  Copyright © 2017年 yusuke takahashi. All rights reserved.
//

import UIKit

final class Dispatcher {

    static let shared = Dispatcher()
    private let queue = DispatchQueue(label: "corin8823.DifferDemo.dispatcher", attributes: .concurrent)

    private var observers = [ObserverInfo]()

    private struct ObserverInfo {
        let observer: AnyObject
        let handler: Any
        let key: Any
    }

    private init() {

    }

    func register<T, U: Equatable>(observer: AnyObject, key: U, handler: @escaping (T) -> Void) {
       self.queue.sync {
            let info = ObserverInfo(observer: observer, handler: handler, key: key)
            self.observers.append(info)
        }
    }

    func unregister(observer: AnyObject) {
        self.queue.sync {
            self.observers = self.observers.filter { $0.observer !== observer }
        }
    }

    func dispatch<T, U: Equatable>(obj: T, key: U) {
        self.observers.forEach { observer in
            guard
                let handler = observer.handler as? ((T) -> Void),
                let k = observer.key as? U,
                equal(obj: obj, handler: observer.handler) else {
                    return
            }

            if k != key {
                return
            }
            handler(obj)
        }
    }
}

private extension Dispatcher {

    func equal<T>(obj: T, handler: Any) -> Bool {
        return Mirror(reflecting: handler).subjectType is ((T) -> Void).Type
    }
}

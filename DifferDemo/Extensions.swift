//
//  Collection.swift
//  DifferDemo
//
//  Created by corin on 2017/10/09.
//  Copyright © 2017年 yusuke takahashi. All rights reserved.
//

import Foundation

extension Collection {

    func findFirst(_ predicate: (Iterator.Element) -> Bool) -> Iterator.Element? {
        for e in self {
            if predicate(e) {
                return e
            }
        }
        return nil
    }
}

extension Collection {

    subscript(safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Array where Element: Equatable {

    @discardableResult
    public mutating func remove(element: Element) -> Bool {
        guard let index = self.index(of: element) else { return false }
        self.remove(at: index)
        return true
    }

    public mutating func remove(elements: [Element]) {
        elements.forEach {
            self.remove(element: $0)
        }
    }

    @discardableResult
    public mutating func removeFindFirst(_ predicate: (Iterator.Element) -> Bool) -> Bool {
        if let e = self.findFirst(predicate) {
            return self.remove(element: e)
        }
        return false
    }
}

func random(_ n: Int) -> String {
    let a = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
    var s = ""
    for _ in 0..<n {
        let r = Int(arc4random_uniform(UInt32(a.count)))
        s += String(a[a.index(a.startIndex, offsetBy: r)])
    }
    return s
}

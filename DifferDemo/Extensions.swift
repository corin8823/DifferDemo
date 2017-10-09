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

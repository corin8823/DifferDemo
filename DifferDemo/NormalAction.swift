//
//  NormalAction.swift
//  DifferDemo
//
//  Created by corin on 2017/10/09.
//  Copyright © 2017年 yusuke takahashi. All rights reserved.
//

import UIKit

struct NormalAction {

    enum List {
        case add
        case delete
    }

    private let dispatcher: Dispatcher

    init(dispatcher: Dispatcher = .shared) {
        self.dispatcher = dispatcher
    }

    func add(str: String) {
        self.dispatcher.dispatch(obj: str, key: List.add)
    }

    func delete(str: String) {
        self.dispatcher.dispatch(obj: str, key: List.delete)
    }
}

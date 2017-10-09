//
//  DifferStore.swift
//  DifferDemo
//
//  Created by corin on 2017/10/09.
//  Copyright © 2017年 yusuke takahashi. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class DifferStore {

    deinit {
        Dispatcher.shared.unregister(observer: self)
    }

    private(set) var strings = Variable<[String]>([])

    required init(dispatcher: Dispatcher = .shared) {
        dispatcher.register(observer: self, key: DifferAction.List.add) { [weak self] (str: String) in
            self?.strings.value.append(str)
        }

        dispatcher.register(observer: self, key: DifferAction.List.delete) { [weak self] (str: String) in
            self?.strings.value.removeFindFirst({ $0 == str })
        }
    }
}

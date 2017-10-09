//
//  DifferViewController.swift
//  DifferDemo
//
//  Created by corin on 2017/10/09.
//  Copyright © 2017年 yusuke takahashi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Differ

final class DifferViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var store = DifferStore()
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Differ"
        self.prepareNavigationBar()
        self.prepareFlux()
    }

    @objc func didTapAdd() {
        DifferAction().add(str: random(10))
    }

    @objc func didTapDelete() {
        let strings = self.store.strings.value
        let index = Int(arc4random_uniform(UInt32(strings.count)))
        if let str = strings[safe: index] {
            DifferAction().delete(str: str)
        }
    }
}

extension DifferViewController: UITableViewDelegate {

}

extension DifferViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.store.strings.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        let string = self.store.strings.value[indexPath.row]
        cell.textLabel?.text = string
        return cell
    }
}

private extension DifferViewController {

    func prepareNavigationBar() {
        let add = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(didTapAdd))
        let delete = UIBarButtonItem(title: "delete", style: .plain, target: self, action: #selector(didTapDelete))
        self.navigationItem.rightBarButtonItem = add
        self.navigationItem.leftBarButtonItem = delete
    }

    func prepareFlux() {
        self.store.strings
            .asObservable()
            .scan([]) { [weak self] (old, new) -> [String] in
                self?.tableView.animateRowChanges(oldData: old, newData: new)
                return new
            }
            .bind { _ in

            }
            .disposed(by: self.disposeBag)
    }
}

//
//  NormalViewController.swift
//  DifferDemo
//
//  Created by corin on 2017/10/09.
//  Copyright © 2017年 yusuke takahashi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class NormalViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var store = NormalStore()
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Normal"
        self.prepareNavigationBar()
        self.prepareFlux()
    }

    @objc func didTapAdd() {
        NormalAction().add(str: "text")
    }

    @objc func didTapDelete() {
        NormalAction().delete(str: "text")
    }
}

extension NormalViewController: UITableViewDelegate {

}

extension NormalViewController: UITableViewDataSource {

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

private extension NormalViewController {

    func prepareNavigationBar() {
        let add = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(didTapAdd))
        let delete = UIBarButtonItem(title: "delete", style: .plain, target: self, action: #selector(didTapDelete))
        self.navigationItem.rightBarButtonItem = add
        self.navigationItem.leftBarButtonItem = delete
    }

    func prepareFlux() {
        self.store.strings
            .asObservable()
            .bind { [weak self] _ in
                self?.tableView.reloadData()
            }
            .disposed(by: self.disposeBag)
    }
}

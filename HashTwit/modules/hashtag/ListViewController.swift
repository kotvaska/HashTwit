//
// Created by Anastasia Zolotykh on 09.03.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import UIKit
import RxKeyboard
import RxSwift
import TwitterKit

class ListViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private let cellIdentifier = "ListCellIdentifier"
    private let bag = DisposeBag()

    var presenter: ListPresenterInterface?
    var displayData: ListData?

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }

    private func configure() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 68

        searchBar.delegate = self
        presenter?.onSearchQueryChanged(searchBar.rx.text.orEmpty.asObservable())

        RxKeyboard.instance.visibleHeight
                .drive(onNext: { keyboardVisibleHeight in
                    self.tableView.contentInset.bottom = keyboardVisibleHeight
                })
                .disposed(by: bag)

        presenter?.updateView()

    }

}

extension ListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

}

extension ListViewController: ListViewInterface {

    func showSearchBar() {
        searchBar.isHidden = false
    }

    func updateDisplayData(_ data: ListData) {
        displayData = data
        tableView.reloadData()
    }

    func showErrorView() {
        searchBar.isHidden = true
        tableView.isHidden = true
        activityIndicator.isHidden = true
        errorView.isHidden = false
    }

    func showLoading() {
        searchBar.isHidden = true
        tableView.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        errorView.isHidden = true
    }

    func hideLoading() {
        searchBar.isHidden = false
        tableView.isHidden = false
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        errorView.isHidden = true
    }

}

extension ListViewController: UITableViewDelegate {

}

extension ListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayData?.tweets.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let upcomingItem = displayData?.tweets[(indexPath as NSIndexPath).row]

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as UITableViewCell

        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = upcomingItem?.text;
        cell.selectionStyle = UITableViewCellSelectionStyle.none;

        return cell
    }

}

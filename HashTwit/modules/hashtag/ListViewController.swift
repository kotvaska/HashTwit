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

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshList), for: UIControlEvents.valueChanged)
        refreshControl.layer.zPosition -= 1

        return refreshControl
    }()

    private let cellIdentifier = "ListCellIdentifier"
    private let bag = DisposeBag()

    var presenter: ListPresenterInterface?
    var displayData: [Tweet]?

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
        tableView.addSubview(refreshControl)
        tableView.sendSubview(toBack: refreshControl)

        searchBar.delegate = self
        presenter?.onSearchQueryChanged(searchBar.rx.text.orEmpty.asObservable())

        RxKeyboard.instance.visibleHeight
                .drive(onNext: { keyboardVisibleHeight in
                    self.tableView.contentInset.bottom = keyboardVisibleHeight
                })
                .disposed(by: bag)

        presenter?.updateView()

    }

    @objc private func refreshList() {
        presenter?.refreshList()
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

    func updateDisplayData(_ data: [Tweet]) {
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

    func hideRefreshLoader() {
        refreshControl.endRefreshing()
    }

}

extension ListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension ListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayData?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let upcomingItem = displayData?[(indexPath as NSIndexPath).row]

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as UITableViewCell

        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = upcomingItem?.text;
        cell.selectionStyle = UITableViewCellSelectionStyle.none;

        return cell
    }

}

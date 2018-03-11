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

    private let bag = DisposeBag()

    var presenter: ListPresenterInterface?
    var dataSource: ListViewControllerDataSource?
    var delegate: ListViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }

    private func configure() {
        tableView.register(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: TweetTableViewCell.CELL_ID)
        tableView.register(UINib(nibName: "IndicatorTableViewCell", bundle: nil), forCellReuseIdentifier: IndicatorTableViewCell.CELL_ID)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 105
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

    func hideLastCell(indexPath: IndexPath) {
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }

    func showSearchBar() {
        searchBar.isHidden = false
    }

    func reloadTable() {
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

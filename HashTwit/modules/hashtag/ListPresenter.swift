//
// Created by Anastasia Zolotykh on 10.03.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import RxSwift

class ListPresenter: NSObject, BasePresenter {

    var router: ListRouter?
    var view: ListViewInterface?
    var interactor: ListInteractorInput?

    private var hashtag = ""
    private let bag = DisposeBag()
    private var displayData: [Tweet]?
    private var loadMore = false

    func onError() {
        view?.showErrorView()
    }

    private func mergeItems(old: [Tweet], new: [Tweet]) -> [Tweet]? {
        var set = Set<Tweet>()
        set.formUnion(new)
        set.formUnion(old)

        let m = Array(set)

        let tweets: [Tweet] = m.sorted { element, element1 in
            element.id == element1.id ? (element.createdAt > element1.createdAt) : (element.id > element1.id)
        }

        return tweets
    }

}

extension ListPresenter: ListPresenterInterface {

    func refreshList() {
        view?.hideRefreshLoader()
        updateView()
    }

    func onSearchQueryChanged(_ observable: Observable<String>) {
        view?.showLoading()
        observable
                .subscribe(onNext: { query in
                    self.hashtag = query
                    self.view?.showLoading()
                    self.displayData = nil
                    self.updateView()

                }, onError: { e in
                    self.view?.hideLoading()
                    self.view?.showErrorView()

                })
                .disposed(by: bag)
    }

    func updateView() {
        interactor?.findTweets(with: hashtag)
    }

}

extension ListPresenter: ListInteractorOutput {

    func showError(_ error: Error) {
        onError()
        view?.showSearchBar()
    }

    func showTweets(_ tweets: [Tweet]) {
        view?.hideLoading()

        displayData = mergeItems(old: displayData ?? [], new: tweets)

        if displayData?.count == 0 {
            onError()
            view?.showSearchBar()
        } else {
            self.displayData = tweets
            view?.reloadTable()
        }
    }

}

extension ListPresenter: ListViewControllerDataSource {

    private enum ListCellType {
        case tweet, indicator
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = displayData?.count ?? 0
        return count > 0 ? count + 1 : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch getCellType(indexPath.row) {
        case .tweet:
            return router?.showTweetCell(tableView: tableView, indexPath: indexPath, tweet: displayData?[indexPath.row]) ?? UITableViewCell()

        case .indicator:
            self.updateView()
            return router?.showIndicatorCell(tableView: tableView, indexPath: indexPath) ?? UITableViewCell()

        }

    }

    private func getCellType(_ row: Int) -> ListCellType {
        return row == (displayData?.count ?? 0) ? ListCellType.indicator : ListCellType.tweet
    }

}

extension ListPresenter: ListViewControllerDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

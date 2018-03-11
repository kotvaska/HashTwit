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

    func onError() {
        view?.showErrorView()
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

        if tweets.count == 0 {
            onError()
            view?.showSearchBar()
        } else {
            self.displayData = tweets
            view?.reloadTable()
        }
    }

}

extension ListPresenter: ListViewControllerDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayData?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let upcomingItem = displayData?[(indexPath as NSIndexPath).row]

        let cell = tableView.dequeueReusableCell(withIdentifier: listCellIdentifier, for: indexPath) as UITableViewCell

        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = upcomingItem?.text;
        cell.selectionStyle = UITableViewCellSelectionStyle.none;

        return cell
    }

}

extension ListPresenter: ListViewControllerDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

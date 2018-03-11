//
// Created by Anastasia Zolotykh on 10.03.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import RxSwift

class ListPresenter: BasePresenter {

    var router: ListRouter?
    var view: ListViewInterface?
    var interactor: ListInteractorInput?

    private var hashtag = ""
    private let bag = DisposeBag()

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
            view?.updateDisplayData(tweets)
        }
    }

}
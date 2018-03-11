//
// Created by Anastasia Zolotykh on 08.03.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import UIKit
import TwitterKit

class AppConfiguration {

    private let consumerKey = "zdG5IipHkwT28ZtZuWTvOG11X"
    private let consumerSecret = "YkarBOsKIoKroznihUPSzuyPRtQmEOtKrfrhZQtOIBwoypkI1b"

    let listRouter: ListRouter = ListRouter()

    init() {
        TWTRTwitter.sharedInstance().start(withConsumerKey: consumerKey, consumerSecret: consumerSecret)
        configure()
    }

    func showController(from window: UIWindow) {
        listRouter.showFrom(from: window)
    }

    func configure() {

        // MARK: Table view controller

        let networkClient = TwitterNetworkClient()
        let interactor = TweetInteractor(networkClient: networkClient)
        let listPresenter = ListPresenter()

        interactor.output = listPresenter

        listPresenter.interactor = interactor
        listPresenter.router = listRouter

        listRouter.presenter = listPresenter

        // MARK: Tweet cell

        let tweetRouter = TweetTableRouter()
        let tweetPresenter = TweetTablePresenter()

        tweetPresenter.router = tweetRouter
        tweetRouter.presenter = tweetPresenter
        listRouter.tweetRouter = tweetRouter


        // MARK: Indicator cell

        let indicatorRouter = IndicatorTableRouter()
        let indicatorPresenter = IndicatorTablePresenter()

        indicatorPresenter.router = indicatorRouter
        indicatorRouter.presenter = indicatorPresenter
        listRouter.indicatorRouter = indicatorRouter

    }

}

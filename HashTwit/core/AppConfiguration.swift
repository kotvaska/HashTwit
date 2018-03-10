//
// Created by Anastasia Zolotykh on 08.03.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import UIKit
import TwitterKit

class AppConfiguration {

    private let consumerKey = "iXZxKcnj7Xu3iDD9UdCthSpTk"
    private let consumerSecret = "FO0S1BLdhecv37fu1Ac4l7jiRpMwRSHwYp8boUw5Eay0wkpGut"

    let listRouter: ListRouter = ListRouter()

    init() {
        TWTRTwitter.sharedInstance().start(withConsumerKey: consumerKey, consumerSecret: consumerSecret)
        configure()
    }

    func showController(from window: UIWindow) {
        listRouter.showFrom(from: window)
    }

    func configure() {
        let networkClient = TwitterNetworkClient()
        let interactor = TweetInteractor(networkClient: networkClient)
        let listPresenter = ListPresenter()

        interactor.output = listPresenter

        listPresenter.interactor = interactor
        listPresenter.router = listRouter

        listRouter.presenter = listPresenter

    }

}

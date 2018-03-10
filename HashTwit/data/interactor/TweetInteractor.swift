//
// Created by Anastasia Zolotykh on 10.03.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

class TweetInteractor {

    let networkClient: NetworkClient
    var output: ListInteractorOutput?

    init(networkClient: TwitterNetworkClient) {
        self.networkClient = networkClient
    }

}

extension TweetInteractor: ListInteractorInput {

    func findTweets(with hashtag: String) {
        networkClient.loadTweets(with: hashtag)
    }

}

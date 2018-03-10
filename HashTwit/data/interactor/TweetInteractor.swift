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
        let completion: (Data?, Error?) -> () = { data, error in
            if let data = data, let tweets: Status = try? JSONDecoder().decode(Status.self, from: data) {
                self.output?.showTweets(tweets.statuses)
            }
            self.output?.showTweets([])
        }

        networkClient.loadTweets(with: hashtag, completion: completion)
    }

}

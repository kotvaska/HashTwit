//
// Created by Anastasia Zolotykh on 10.03.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import TwitterKit

class TwitterNetworkClient: NetworkClient {

    let client = TWTRAPIClient()

    func loadTweets(with hashtag: String, completion: @escaping (Data?, Error?) -> ()) {

        let method = "GET"
        let endPoint = "https://api.twitter.com/1.1/search/tweets.json"
        let param = ["q": hashtag.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)]
        var error: NSError?

        let request = client.urlRequest(withMethod: method, urlString: endPoint, parameters: param, error: &error)

        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            completion(data, error)
        }

    }

}

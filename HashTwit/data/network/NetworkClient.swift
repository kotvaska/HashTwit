//
// Created by Anastasia Zolotykh on 08.03.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

protocol NetworkClient {

    func loadTweets(with hashtag: String, completion: @escaping (Data?, Error?) -> ())

}

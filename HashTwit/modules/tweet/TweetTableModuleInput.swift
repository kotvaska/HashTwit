//
// Created by Anastasia Zolotykh on 11.03.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

protocol TweetTableModuleInput {

    func setInputData(tweet: Tweet?)

    func setInputIndex(indexPath: IndexPath)

    func setParentTableView(tableView: UITableView)

}

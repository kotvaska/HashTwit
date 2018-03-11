//
// Created by Anastasia Zolotykh on 11.03.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

class TweetTableRouter {

    var view: TweetTableViewCell?
    var presenter: TweetTablePresenter?

    func presentCell(tableView: UITableView, indexPath: IndexPath, tweet: Tweet?) -> TweetTableViewCell? {
        presenter?.setInputData(tweet: tweet)
        presenter?.setInputIndex(indexPath: indexPath)
        presenter?.setParentTableView(tableView: tableView)

        return presenter?.presentCellView()

    }

}

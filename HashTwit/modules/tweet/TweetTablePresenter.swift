//
// Created by Anastasia Zolotykh on 11.03.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

class TweetTablePresenter: TweetTablePresenterInterface {

    var view: TweetTableViewInterface?
    var router: TweetTableRouter?

    private var tweet: Tweet?
    private var indexPath: IndexPath?
    private var tableView: UITableView?

    func presentCellView() -> TweetTableViewCell? {
        let cell = tableView?.dequeueReusableCell(withIdentifier: TweetTableViewCell.CELL_ID, for: indexPath ?? IndexPath()) as! TweetTableViewCell
        cell.tweetTextLabel.text = tweet?.text
        cell.dateLabel.text = tweet?.createdAt
        cell.authorLabel.text = tweet?.author.name
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        return cell
    }

}

extension TweetTablePresenter: TweetTableModuleInput {

    func setInputIndex(indexPath: IndexPath) {
        self.indexPath = indexPath
    }

    func setParentTableView(tableView: UITableView) {
        self.tableView = tableView
    }

    func setInputData(tweet: Tweet?) {
        self.tweet = tweet
    }

}

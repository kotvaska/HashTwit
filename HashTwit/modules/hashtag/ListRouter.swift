//
// Created by Anastasia Zolotykh on 09.03.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import UIKit

class ListRouter: BaseRouter {

    typealias C = ListViewController
    var controller: C?

    var presenter: ListPresenter?
    var tweetRouter: TweetTableRouter?
    var indicatorRouter: IndicatorTableRouter?

    func showFrom(from window: UIWindow) {
        let viewController = viewControllerFromStoryboard(with: "ListViewController") as! ListViewController
        viewController.presenter = presenter
        viewController.dataSource = presenter
        viewController.delegate = presenter
        controller = viewController
        presenter?.view = viewController
        showRootViewController(viewController, in: window)
    }

    func showTweetCell(tableView: UITableView, indexPath: IndexPath, tweet: Tweet?) -> TweetTableViewCell? {
        return tweetRouter?.presentCell(tableView: tableView, indexPath: indexPath, tweet: tweet)
    }

    func showIndicatorCell(tableView: UITableView, indexPath: IndexPath) -> IndicatorTableViewCell? {
        return indicatorRouter?.presentCell(tableView: tableView, indexPath: indexPath)
    }

}

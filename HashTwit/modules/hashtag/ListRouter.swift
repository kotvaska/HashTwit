//
// Created by Anastasia Zolotykh on 09.03.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import UIKit

class ListRouter: BaseRouter {

    typealias C = ListViewController

    var controller: C?

    func showFrom(from window: UIWindow) {
        let viewController = viewControllerFromStoryboard(with: "ListViewController") as! ListViewController
//        viewController.eventHandler = listPresenter
//        listViewController = viewController
//        listPresenter?.userInterface = viewController
        showRootViewController(viewController, in: window)
    }

}

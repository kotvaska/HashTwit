//
// Created by Anastasia Zolotykh on 31.03.17.
// Copyright (c) 2017 chedev. All rights reserved.
//

import Foundation
import UIKit

protocol BaseRouter {

    associatedtype C: UIViewController

    var controller: C? { get set }

}

extension BaseRouter {

    func showRootViewController(_ viewController: UIViewController, in window: UIWindow) {
        let navigationController = self.navigationController(from: window)
        navigationController.viewControllers = [viewController]
    }

    func navigationController(from window: UIWindow) -> UINavigationController {
        let navigationController = window.rootViewController as! UINavigationController
        return navigationController
    }

    func viewControllerFromStoryboard(with identifier: String) -> UIViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        return viewController
    }

    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }

    func openController(viewController: UIViewController) {
        if !pushNavigation(viewController: viewController) {
            present(viewController: viewController)
        }
    }

    func pushNavigation(viewController: UIViewController) -> Bool {
        if let navigationController = controller?.navigationController {
            navigationController.pushViewController(viewController, animated: true)
            return true
        }
        return false
    }

    func present(viewController: UIViewController) {
        controller?.present(viewController, animated: true)
    }

    func setRoot(viewController: UIViewController) {
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }

    func presentModal(viewController: UIViewController, style: UIModalPresentationStyle) {
        viewController.modalPresentationStyle = style
        present(viewController: viewController)

    }

    func close() {
        if !popNavigation() {
            dismiss()
        }
    }

    func goToRootNavigation() -> Bool {
        if let navigationController = controller?.navigationController {
            navigationController.popToRootViewController(animated: true)
            return true
        }
        return false
    }

    func popNavigation() -> Bool {
        if let navigationController = controller?.navigationController {
            navigationController.popToRootViewController(animated: true)
            return true
        }
        return false
    }

    func dismiss() {
        controller?.dismiss(animated: true)
    }

}


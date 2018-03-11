//
// Created by Anastasia Zolotykh on 11.03.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

class IndicatorTableRouter {

    var presenter: IndicatorTablePresenter?

    func presentCell(tableView: UITableView, indexPath: IndexPath) -> IndicatorTableViewCell? {
        presenter?.setInputIndex(indexPath: indexPath)
        presenter?.setParentTableView(tableView: tableView)

        return presenter?.presentCellView()

    }

}

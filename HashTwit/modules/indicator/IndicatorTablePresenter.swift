//
// Created by Anastasia Zolotykh on 11.03.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

class IndicatorTablePresenter: IndicatorTablePresenterInterface {

    var router: IndicatorTableRouter?
    var view: IndicatorTableViewInterface?

    private var indexPath: IndexPath?
    private var tableView: UITableView?

    func presentCellView() -> IndicatorTableViewCell? {
        let cell = tableView?.dequeueReusableCell(withIdentifier: IndicatorTableViewCell.CELL_ID, for: indexPath ?? IndexPath()) as! IndicatorTableViewCell
        cell.activityIndicator.startAnimating()
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        return cell
    }


}

extension IndicatorTablePresenter: IndicatorTableModuleInput {

    func setInputIndex(indexPath: IndexPath) {
        self.indexPath = indexPath
    }

    func setParentTableView(tableView: UITableView) {
        self.tableView = tableView
    }

}

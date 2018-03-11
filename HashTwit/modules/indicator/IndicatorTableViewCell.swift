//
// Created by Anastasia Zolotykh on 11.03.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import UIKit

class IndicatorTableViewCell: UITableViewCell, IndicatorTableViewInterface {

    var presenter: IndicatorTablePresenterInterface?

    static let CELL_ID = "IndicatorTableViewCell"

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

}

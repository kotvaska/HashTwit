//
// Created by Anastasia Zolotykh on 11.03.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell, TweetTableViewInterface {

    var presenter: TweetTablePresenterInterface?

    static let CELL_ID = "TweetTableViewCell"

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

}

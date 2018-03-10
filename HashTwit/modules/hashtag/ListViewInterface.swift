//
// Created by Anastasia Zolotykh on 10.03.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

protocol ListViewInterface: BaseView {

    func updateDisplayData(_ data: ListData)

    func showSearchBar()

}

//
// Created by Anastasia Zolotykh on 10.03.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import RxSwift
import RxCocoa

protocol ListPresenterInterface {

    func updateView()

    func onSearchQueryChanged(_ observable: Observable<String>)

    func refreshList()

}

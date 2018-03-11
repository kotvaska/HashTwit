//
// Created by Anastasia Zolotykh on 11.03.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import UIKit

protocol ListViewControllerDataSource: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell

}

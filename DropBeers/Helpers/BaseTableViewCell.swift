//
//  BaseTableViewCell.swift
//  DropBeers
//
//  Created by Egemen Ayhan on 10.09.2020.
//

import UIKit

class BaseTableViewCell: UITableViewCell, NibLoadable {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

}

//
//  Reusable.swift
//  DropBeers
//
//  Created by Apple Seed on 10.09.2020.
//

import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable where Self: UITableViewCell {
    static var reuseIdentifier: String {
         return String(describing: self)
    }
}

extension UITableViewCell: Reusable {}

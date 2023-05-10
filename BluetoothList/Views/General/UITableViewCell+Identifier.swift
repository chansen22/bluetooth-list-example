//
//  UITableViewCell+Identifier.swift
//  BluetoothList
//
//  Created by Christopher Beaversen on 1/20/23.
//

import Foundation
import UIKit

protocol CellIdentifiable {
    static var identifier: String { get }
}

extension UITableViewCell: CellIdentifiable {
    static var identifier: String {
        return String(describing: Self.self)
    }
}

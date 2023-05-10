//
//  UITableView+Reusable.swift
//  BluetoothList
//
//  Created by Christopher Beaversen on 1/20/23.
//

import Foundation
import UIKit

extension UITableView {
    func dequeueReusableCell<T: CellIdentifiable>(indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
        return cell
    }
}

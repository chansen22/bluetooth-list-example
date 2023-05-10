//
//  Coordinator.swift
//  BluetoothList
//
//  Created by Christopher Beaversen on 1/20/23.
//

import Foundation
import UIKit

protocol Coordinator {
    var children: [Coordinator] { get }
    var navigationController: UINavigationController { get }

    func start()
}

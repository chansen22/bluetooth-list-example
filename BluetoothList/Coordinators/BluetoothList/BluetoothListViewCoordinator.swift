//
//  BluetoothListViewCoordinator.swift
//  BluetoothList
//
//  Created by Christopher Beaversen on 1/20/23.
//

import Foundation
import UIKit

protocol BluetoothListDependencies {
    var bluetoothFetcherService: BluetoothFetcherInterface { get }
}

final class BluetoothListViewCoordinator: Coordinator {

    private(set) var children: [Coordinator] = []
    private(set) var navigationController: UINavigationController
    private let dependencies: BluetoothListDependencies

    private weak var bluetoothListViewController: BluetoothListViewController?

    init(navigationController: UINavigationController, dependencies: BluetoothListDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let viewModel = BluetoothListViewModel(dependency: dependencies)
        let viewController = BluetoothListViewController.instantiate(with: viewModel)
        viewModel.delegate = viewController
        navigationController.pushViewController(viewController, animated: true)
        bluetoothListViewController = viewController
    }
}

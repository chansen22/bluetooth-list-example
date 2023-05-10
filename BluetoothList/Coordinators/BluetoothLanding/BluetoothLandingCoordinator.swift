//
//  BluetoothLandingCoordinator.swift
//  BluetoothList
//
//  Created by Christopher Beaversen on 1/20/23.
//

import Foundation
import UIKit

protocol BluetoothLandingDependencies {
    var bluetoothFetcherService: BluetoothFetcherInterface { get }
}

final class BluetoothLandingCoordinator: Coordinator {

    var navigationController: UINavigationController
    var children: [Coordinator] = []
    private let dependencies: BluetoothLandingDependencies

    private weak var bluetoothLandingViewController: BluetoothLandingViewController?

    init(navigationController: UINavigationController, dependencies: BluetoothLandingDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let viewModel = BluetoothLandingViewModel(delegate: self, dependency: dependencies)
        let viewController = BluetoothLandingViewController.instantiate(with: viewModel)
        navigationController.pushViewController(viewController, animated: true)
        bluetoothLandingViewController = viewController
    }
}

extension BluetoothLandingCoordinator: BluetoothLandingViewModelDelegate {
    func showBluetoothList() {
        let listCoordinator = BluetoothListViewCoordinator(
            navigationController: navigationController,
            dependencies: dependencies as! BluetoothListDependencies
        )
        listCoordinator.start()
        children.removeAll { $0 is BluetoothListViewCoordinator }
        children.append(listCoordinator)
    }
}

//
//  AppCoordinator.swift
//  BluetoothList
//
//  Created by Christopher Beaversen on 1/20/23.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {

    var children: [Coordinator] = []
    var navigationController: UINavigationController
    private var dependencies: AppDependencyInjection

    init(navigationController: UINavigationController, dependencies: AppDependencyInjection) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let coordinator = BluetoothLandingCoordinator(
            navigationController: navigationController,
            dependencies: dependencies
        )

        coordinator.start()
        children.append(coordinator)
    }
}

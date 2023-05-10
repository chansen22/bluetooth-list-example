//
//  BluetoothLandingViewModel.swift
//  BluetoothList
//
//  Created by Christopher Beaversen on 1/20/23.
//

import Foundation

protocol BluetoothLandingViewModelDelegate: AnyObject {
    func showBluetoothList()
}

final class BluetoothLandingViewModel: ViewModel {

    private weak var delegate: BluetoothLandingViewModelDelegate?
    private var dependency: BluetoothLandingDependencies

    init(delegate: BluetoothLandingViewModelDelegate, dependency: BluetoothLandingDependencies) {
        self.delegate = delegate
        self.dependency = dependency

        // Start listening for bluetooth devices
        dependency.bluetoothFetcherService.startListening()
    }

    func showList() {
        delegate?.showBluetoothList()
    }
}

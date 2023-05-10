//
//  BluetoothListViewModel.swift
//  BluetoothList
//
//  Created by Christopher Beaversen on 1/20/23.
//

import Foundation

protocol BluetoothListViewModelDelegate: AnyObject {
    func deviceListUpdated()
}

final class BluetoothListViewModel: ViewModel {

    private var dependency: BluetoothListDependencies
    private(set) var deviceList: [BluetoothDevice]

    weak var delegate: BluetoothListViewModelDelegate?

    init(deviceList: [BluetoothDevice] = [], dependency: BluetoothListDependencies) {
        self.deviceList = deviceList
        self.dependency = dependency
        dependency.bluetoothFetcherService.registerForUpdates(self) // Start listening for updates to the list
    }

    func getDeviceProperties(device: BluetoothDevice) {
        dependency.bluetoothFetcherService.getProperties(for: device)
    }
}

extension BluetoothListViewModel: BluetoothFetcherDelegate {
    func updatedDeviceList(_ devices: [BluetoothDevice]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.deviceList = devices
            self.delegate?.deviceListUpdated()
        }
    }
}

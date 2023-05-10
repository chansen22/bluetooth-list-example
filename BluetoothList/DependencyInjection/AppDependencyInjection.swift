//
//  AppDependencyInjection.swift
//  BluetoothList
//
//  Created by Christopher Beaversen on 1/20/23.
//

import Foundation

/// Holds dependencies the app needs for it's lifecycle
final class AppDependencyInjection {

    lazy var bluetoothFetcherService: BluetoothFetcherInterface = {
        return BluetoothFetcher()
    }()

}

extension AppDependencyInjection: BluetoothLandingDependencies, BluetoothListDependencies { }

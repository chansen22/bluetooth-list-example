//
//  BluetoothDevice.swift
//  BluetoothList
//
//  Created by Christopher Beaversen on 1/20/23.
//

import Foundation
import CoreBluetooth

final class BluetoothDevice: Equatable, Hashable {

    let identifier: String
    let name: String?
    let services: [BluetoothService]

    static func ==(lhs: BluetoothDevice, rhs: BluetoothDevice) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    init(peripheral: CBPeripheral) {
        self.identifier = peripheral.identifier.uuidString
        self.name = peripheral.name
        self.services = peripheral.services?.map { BluetoothService(service: $0) } ?? []
    }
}

final class BluetoothService {
    let identifier: String

    init(service: CBService) {
        self.identifier = service.uuid.description
    }
}

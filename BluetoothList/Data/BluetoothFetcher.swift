//
//  BluetoothFetcher.swift
//  BluetoothList
//
//  Created by Christopher Beaversen on 1/20/23.
//

import Foundation
import CoreBluetooth

protocol BluetoothFetcherInterface {
    var isListening: Bool { get }
    var deviceList: [BluetoothDevice] { get }
    func registerForUpdates(_ delegate: BluetoothFetcherDelegate)
    func startListening()
    func getProperties(for device: BluetoothDevice)
}

protocol BluetoothFetcherDelegate: AnyObject {
    func updatedDeviceList(_ devices: [BluetoothDevice])
}

final class BluetoothFetcher: NSObject, BluetoothFetcherInterface {

    var deviceList: [BluetoothDevice] { _deviceList.values.sorted { $0.identifier.uuidString < $1.identifier.uuidString }.map { BluetoothDevice(peripheral: $0) } }

    private final class WeakObserver {
        weak var value: BluetoothFetcherDelegate?

        init(value: BluetoothFetcherDelegate) {
            self.value = value
        }
    }

    private(set) var isListening = false
    private var _deviceList: [String: CBPeripheral] = [:]
    private var listeners: [WeakObserver] = []
    private var centralManager: CBCentralManager!
    private let bluetoothQueue = DispatchQueue(label: "BluetoothDeviceQueue")

    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: bluetoothQueue)
    }

    func registerForUpdates(_ delegate: BluetoothFetcherDelegate) {
        let observer = WeakObserver(value: delegate)
        listeners.append(observer)
        // Send initial set of devices when registering
        observer.value?.updatedDeviceList(deviceList)
    }

    func startListening() {
        isListening = true
        guard centralManager.state == .poweredOn else { return }
        centralManager.scanForPeripherals(withServices: nil)
    }

    func getProperties(for device: BluetoothDevice) {
        guard let peripheral = _deviceList[device.identifier] else { return }
        peripheral.delegate = self
        centralManager.connect(peripheral)
    }

    private func updateListenersDeviceListChanged() {
        let deviceList = deviceList
        for listener in listeners {
            guard let value = listener.value else {
                listeners.removeAll(where: { $0 === listener })
                continue
            }
            value.updatedDeviceList(deviceList)
        }
    }
}

extension BluetoothFetcher: CBPeripheralDelegate, CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        guard central.state == .poweredOn, isListening else { return }
        centralManager.scanForPeripherals(withServices: nil)
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.discoverServices(nil)
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        _deviceList[peripheral.identifier.uuidString] = peripheral
        updateListenersDeviceListChanged()
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        _deviceList[peripheral.identifier.uuidString] = peripheral
        updateListenersDeviceListChanged()
    }
}

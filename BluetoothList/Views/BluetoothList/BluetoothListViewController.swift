//
//  BluetoothListViewController.swift
//  BluetoothList
//
//  Created by Christopher Beaversen on 1/20/23.
//

import Foundation
import UIKit

final class BluetoothListViewController: UIViewController, ViewModelView, StoryboardInstantiable {
    var viewModel: BluetoothListViewModel!

    @IBOutlet private weak var tableView: UITableView!
    private var selectedDevice: BluetoothDevice?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        title = NSLocalizedString("Bluetooth Devices", comment: "The title for the list of bluetooth devices nearby")
    }
}

extension BluetoothListViewController: BluetoothListViewModelDelegate {
    func deviceListUpdated() {
        tableView.reloadData()
    }
}

extension BluetoothListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.deviceList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BluetoothListTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        let device = viewModel.deviceList[indexPath.row]
        var services: [String] = []
        if selectedDevice == device {
            services = device.services.map { $0.identifier }
        }
        let isLoading = (selectedDevice == device) && services.isEmpty
        cell.configure(name: device.name, isLoading: isLoading, servicesAvailable: services)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let previouslySelectedDevice = selectedDevice,
           let row = viewModel.deviceList.firstIndex(of: previouslySelectedDevice),
           let previousLoadingCell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? BluetoothListTableViewCell {
            previousLoadingCell.isLoading = false
        }

        let cell = tableView.cellForRow(at: indexPath) as! BluetoothListTableViewCell
        cell.isLoading = true
        let device = viewModel.deviceList[indexPath.row]
        selectedDevice = device
        viewModel.getDeviceProperties(device: device)
    }
}

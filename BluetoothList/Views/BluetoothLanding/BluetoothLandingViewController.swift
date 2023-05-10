//
//  BluetoothLandingViewController.swift
//  BluetoothList
//
//  Created by Christopher Beaversen on 1/20/23.
//

import Foundation
import UIKit

final class BluetoothLandingViewController: UIViewController, ViewModelView, StoryboardInstantiable {

    @IBOutlet private weak var showDeviceListButton: UIButton!

    var viewModel: BluetoothLandingViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        showDeviceListButton.setTitle(NSLocalizedString("Show Bluetooth Devices", comment: "Title for button on the landing page that will show a list of devices the app can see"), for: .normal)
    }

    @IBAction private func tappedSeeListButton(_ button: UIButton) {
        viewModel.showList()
    }
}

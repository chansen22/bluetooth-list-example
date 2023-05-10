//
//  BluetoothListTableViewCell.swift
//  BluetoothList
//
//  Created by Christopher Beaversen on 1/20/23.
//

import Foundation
import UIKit

final class BluetoothListTableViewCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var servicesStackView: UIStackView!

    @IBOutlet private weak var stackViewTopConstraint: NSLayoutConstraint!

    var isLoading = false {
        didSet {
            if isLoading {
                loadingActivityIndicator.startAnimating()
            } else {
                loadingActivityIndicator.stopAnimating()
            }
        }
    }

    func configure(name: String?, isLoading: Bool, servicesAvailable: [String]) {
        self.isLoading = isLoading
        nameLabel.text = name ?? NSLocalizedString("Unknown device name", comment: "Fallback when a bluetooth device doesn't have a device name")

        if servicesAvailable.isEmpty {
            hideServices()
        } else {
            servicesStackView.isHidden = false
            stackViewTopConstraint.constant = 8
            for service in servicesAvailable {
                let label = UILabel()
                label.text = service
                label.numberOfLines = 0
                servicesStackView.addArrangedSubview(label)
            }
        }
    }

    private func hideServices() {
        stackViewTopConstraint.constant = 0
        servicesStackView.subviews.forEach { servicesStackView.removeArrangedSubview($0); $0.removeFromSuperview() }
        servicesStackView.isHidden = true
    }
}

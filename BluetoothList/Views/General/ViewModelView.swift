//
//  ViewModelView.swift
//  BluetoothList
//
//  Created by Christopher Beaversen on 1/20/23.
//

import Foundation
import UIKit

protocol ViewModelView {
    associatedtype VM: ViewModel

    var viewModel: VM! { get set }
}

extension ViewModelView where Self: UIViewController, Self: StoryboardInstantiable {
    static func instantiate(with viewModel: VM) -> Self {
        var viewController = Self.instantiateViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}

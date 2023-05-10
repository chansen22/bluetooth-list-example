//
//  StoryboardInstantiable.swift
//  BluetoothList
//
//  Created by Christopher Beaversen on 1/20/23.
//

import Foundation
import UIKit

protocol StoryboardInstantiable: NSObjectProtocol {
    associatedtype ViewController
    static var fileName: String { get }
    static func instantiateViewController(_ bundle: Bundle?) -> ViewController
}

extension StoryboardInstantiable where Self: UIViewController {
    static var fileName: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }

    static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
        let fileName = self.fileName
        let storyboard = UIStoryboard(name: fileName, bundle: bundle)
        return storyboard.instantiateInitialViewController() as! Self
    }
}

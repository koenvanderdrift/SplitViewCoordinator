//
//  Coordinator.swift
//  SplitViewCoordinator
//
//  Created by Koen van der Drift on 8/18/18.
//  Copyright © 2018 Koen van der Drift. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    func start()
}

protocol Coordinated: class {
    var coordinationDelegate: CoordinationDelegate? { get set }
}

protocol CoordinationDelegate: class {
    func coordinate(from source: Coordinated, to destination: UIViewController, identifier id: String?)
}

extension CoordinationDelegate {
    public func coordinate(data source: AnyObject, from controller: Coordinated) {}
}

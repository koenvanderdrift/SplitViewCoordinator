//
//  SplitViewCoordinator.swift
//  SplitViewCoordinator
//
//  Created by Koen van der Drift on 8/18/18.
//  Copyright © 2018 Koen van der Drift. All rights reserved.
//

import UIKit

class SplitViewCoordinator: NSObject, Coordinator {
    var splitViewController: UISplitViewController?
    
    private lazy var masterViewController: MasterViewController =  {
        let masterNC = splitViewController?.viewControllers.first as! UINavigationController
        let masterVC = masterNC.topViewController as! MasterViewController
        
        return masterVC
    }()
    
    init(splitViewController: UISplitViewController) {
        self.splitViewController = splitViewController
    }
    
    func start() {
        splitViewController?.delegate = self
        splitViewController?.preferredDisplayMode = .allVisible

        masterViewController.delegate = self
        
        let detailNC = splitViewController?.viewControllers.last as! UINavigationController
        let detailVC = detailNC.topViewController as! DetailViewController
        detailVC.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
    }
}

extension SplitViewCoordinator: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let detailNC = secondaryViewController as? UINavigationController else { return false }
        guard let detailVC = detailNC.topViewController as? DetailViewController else { return false }
        if detailVC.detailItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }
}

extension SplitViewCoordinator: MasterViewControllerDelegate {
    func handleSegue(segue: UIStoryboardSegue) {
        if segue.identifier == "showDetail" {
            guard let detailNC = segue.destination as? UINavigationController,
                let detailVC = detailNC.topViewController as? DetailViewController else { fatalError() }

            let object = masterViewController.selectedObject()
            detailVC.detailItem = object
            detailVC.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            detailVC.navigationItem.leftItemsSupplementBackButton = true
        }
    }
}

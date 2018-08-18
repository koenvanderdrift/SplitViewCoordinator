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
        let controllers = splitViewController?.viewControllers
        let masterNC = controllers?.first as! UINavigationController
        let masterVC = masterNC.topViewController as! MasterViewController
        
        return masterVC
    }()
    
    private lazy var detailViewController: DetailViewController = {
        let controllers = splitViewController?.viewControllers
        let detailNC = controllers?.last as! UINavigationController
        let detailVC = detailNC.topViewController as! DetailViewController

        return detailVC
    }()
    
    init(splitViewController: UISplitViewController) {
        self.splitViewController = splitViewController
    }
    
    func start() {
        splitViewController?.delegate = self
        masterViewController.delegate = self
        
        detailViewController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
    }
 }

extension SplitViewCoordinator: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        if detailViewController.detailItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }
}

extension SplitViewCoordinator: MasterViewControllerDelegate {
    func showDetail() {
        let object = masterViewController.selectedObject()
            detailViewController.detailItem = object
    }
}

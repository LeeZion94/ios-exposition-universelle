//
//  EntryDetailCoordinator.swift
//  Expo1900
//
//  Created by Hyungmin Lee on 2023/07/05.
//

import UIKit

class EntryDetailCoordinator: Coordinators {
    var childCoordinators: [Coordinators] = []
    let entryItem: ExpositionItem
    private let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController, entryItem: ExpositionItem) {
        self.navigationController = navigationController
        self.entryItem  = entryItem
    }
    
    func start() {
        let entryDetailViewController = EntryDetailViewController()
        
        entryDetailViewController.setEntryDetailInformation(entryItem.name,
                                                            entryItem.imageName,
                                                            entryItem.description)
        navigationController.pushViewController(entryDetailViewController, animated: true)
    }
}


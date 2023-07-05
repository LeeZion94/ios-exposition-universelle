//
//  AppCoordinator.swift
//  Expo1900
//
//  Created by Hyungmin Lee on 2023/07/05.
//

import UIKit

class AppCoordinator: Coordinators {
    var childCoordinators: [Coordinators] = []
    private let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainCoordinator = MainCoordinator(navigationController)
        
        childCoordinators.append(mainCoordinator)
        mainCoordinator.delegate = self
        mainCoordinator.start()
    }
}

// MARK: - MainCoordinatorDelegate
extension AppCoordinator: MainCoordinatorDelegate {
    func didTappedKoreaEntryButton() {
        let koreaEntryCoordinator = KoreaEntryCoordinator(navigationController)
        
        childCoordinators.append(koreaEntryCoordinator)
        koreaEntryCoordinator.delegate = self
        koreaEntryCoordinator.start()
    }
}

// MARK: - KoreaEntryCoordinatorDelegate
extension AppCoordinator: KoreaEntryCoordinatorDelegate {
    func didSelectedKoreaEntry(entryItem: ExpositionItem) {
        let entryDetailCoordinator = EntryDetailCoordinator(navigationController, entryItem: entryItem)
        
        childCoordinators.append(entryDetailCoordinator)
        entryDetailCoordinator.start()
    }
}

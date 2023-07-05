//
//  KoreaEntryCoordinator.swift
//  Expo1900
//
//  Created by Hyungmin Lee on 2023/07/05.
//

import UIKit

protocol KoreaEntryCoordinatorDelegate {
    func didSelectedKoreaEntry(entryItem: ExpositionItem)
}

class KoreaEntryCoordinator: Coordinators {
    var delegate: KoreaEntryCoordinatorDelegate?
    var childCoordinators: [Coordinators] = []
    private let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let data: [ExpositionItem] = Decoder.decode(fileName: "items") else { return }
        let koreaEntryViewController = KoreaEntryViewController(koreaEntryItems: data)
        
        koreaEntryViewController.delegate = self
        navigationController.pushViewController(koreaEntryViewController, animated: true)
    }
}

// MARK: - KoreadEntryViewControllerDelegate
extension KoreaEntryCoordinator: KoreadEntryViewControllerDelegate {
    func didSelectedKoreaEntry(entryItem: ExpositionItem) {
        delegate?.didSelectedKoreaEntry(entryItem: entryItem)
    }
}


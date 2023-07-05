//
//  MainCoordinator.swift
//  Expo1900
//
//  Created by Hyungmin Lee on 2023/07/05.
//

import UIKit

protocol MainCoordinatorDelegate {
    func didTappedKoreaEntryButton()
}

class MainCoordinator: Coordinators {
    var delegate: MainCoordinatorDelegate?
    
    var childCoordinators: [Coordinators] = []
    private let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let information: ParisExpositionInformation = Decoder.decode(fileName: "exposition_universelle_1900") else { return }
        
        let mainViewController = MainViewController(expositionInformation: information)
        
        mainViewController.delegate = self
        navigationController.pushViewController(mainViewController, animated: true)
    }
}

// MARK: - MainViewControllerDelegate
extension MainCoordinator: MainViewControllerDelegate {
    func didTappedKoreaEntryButton() {
        delegate?.didTappedKoreaEntryButton()
    }
}

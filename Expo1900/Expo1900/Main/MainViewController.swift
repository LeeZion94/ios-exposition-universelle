//
//  Expo1900 - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

protocol MainViewControllerDelegate {
    func didTappedKoreaEntryButton()
}

final class MainViewController: UIViewController, MainViewDelegate {
    var delegate: MainViewControllerDelegate?
    var expositionInformation: ParisExpositionInformation
    private let backButtonTitle = "메인"
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    init(expositionInformation: ParisExpositionInformation) {
        self.expositionInformation = expositionInformation
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var mainView: MainView = {
        let view = MainView()
        view.delegate = self
        return view
    }()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor(.systemBackground)
        loadMainViewInformation()
        setNavigationTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        AppSettings.shared.shouldRotate = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        AppSettings.shared.shouldRotate = true
    }

    private func loadMainViewInformation() {
        mainView.load(information: expositionInformation)
    }
    
    private func setBackgroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }
    
    private func setNavigationTitle() {
        navigationItem.backButtonTitle = backButtonTitle
    }
}

// MARK: - MainView Delegate
extension MainViewController {
    func didTappedKoreaEntryButton() {
        delegate?.didTappedKoreaEntryButton()
    }
}

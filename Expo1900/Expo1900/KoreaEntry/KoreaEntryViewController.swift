//
//  KoreaEntryViewController.swift
//  Expo1900
//
//  Created by Zion, Serena on 2023/06/28.
//

import UIKit

protocol KoreadEntryViewControllerDelegate {
    func didSelectedKoreaEntry(entryItem: ExpositionItem)
}

final class KoreaEntryViewController: UIViewController {
    var delegate: KoreadEntryViewControllerDelegate?
    private let koreaEntryTitle = "한국의 출품작"
    private var koreaEntryItems: [ExpositionItem]
    private lazy var dataSource = KoreaEntryDataSource(koreaEntryList: koreaEntryItems)
    
    init(koreaEntryItems: [ExpositionItem]) {
        self.koreaEntryItems = koreaEntryItems
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.register(KoreaEntryTableViewCell.self, forCellReuseIdentifier: KoreaEntryTableViewCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor(.systemBackground)
        configureUI()
        setUpTableViewConstraints()
        setNavigationTitle()
    }
    
    private func configureUI() {
        view.addSubview(tableView)
    }
    
    private func setUpTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setNavigationTitle() {
        navigationItem.title = koreaEntryTitle
    }
    
    private func setBackgroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}

// MARK: - TableView Delegate
extension KoreaEntryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let entryInformation = koreaEntryItems[safe: indexPath.row] else { return }
        
        delegate?.didSelectedKoreaEntry(entryItem: entryInformation)
        navigationItem.backButtonTitle = koreaEntryTitle
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

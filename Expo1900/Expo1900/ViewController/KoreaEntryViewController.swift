//
//  KoreaEntryViewController.swift
//  Expo1900
//
//  Created by Zion, Serena on 2023/06/28.
//

import UIKit

protocol KoreaEntryViewControllerDelegate: AnyObject {
    func didSelectedKoreaEntryTableView(_ expositionItem: ExpositionItem)
}

final class KoreaEntryViewController: UIViewController {
    weak var delegate: KoreaEntryViewControllerDelegate?
    private var koreaEntryItems: [ExpositionItem]
    private var dataSource: UITableViewDiffableDataSource<Int, UUID>!
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.register(KoreaEntryTableViewCell.self, forCellReuseIdentifier: KoreaEntryTableViewCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(koreaEntryItems: [ExpositionItem]) {
        self.koreaEntryItems = koreaEntryItems
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDiffableDataSource()
        setBackgroundColor(.systemBackground)
        configureUI()
        setUpTableViewConstraints()
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
    
    private func setUpDiffableDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, UUID>(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: KoreaEntryTableViewCell.reuseIdentifier, for: indexPath) as? KoreaEntryTableViewCell else { return UITableViewCell() }
            
            cell.configure(with: self.koreaEntryItems[indexPath.row])
            return cell
        })
        
        setUpDiffableDataSourceSnapShot()
        tableView.dataSource = dataSource
    }
    
    private func setUpDiffableDataSourceSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, UUID>()
        
        snapshot.appendSections([0])
        koreaEntryItems.forEach{ _ in snapshot.appendItems([UUID()]) }
        dataSource.apply(snapshot)
    }
    
    private func setBackgroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}

// MARK: - TableView Delegate
extension KoreaEntryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let entryInformation = koreaEntryItems[safe: indexPath.row] else { return }
        
        delegate?.didSelectedKoreaEntryTableView(entryInformation)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

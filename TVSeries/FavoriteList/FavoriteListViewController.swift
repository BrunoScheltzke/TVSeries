//
//  FavoriteListViewController.swift
//  TVSeries
//
//  Created by Bruno Scheltzke on 23/12/21.
//

import UIKit
import DZNEmptyDataSet

class FavoriteListViewController: UIViewController {
    // MARK: - View
    let tableView = UITableView()
    
    // MARK: - Properties
    var items = [TVSeries]()
    var viewModel: FavoriteListViewModelProtocol

    // MARK: - Life Cycle
    init(viewModel: FavoriteListViewModelProtocol = FavoriteListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Favorites"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
        reload()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backButtonTitle = ""
    }
    
    // MARK: - Setup Views
    func setupNavBar() {
        navigationController?.navigationBar.tintColor = .black
    }
    
    func setupTableView() {
        tableView.constraintFully(to: view)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
        tableView.registerViewCode(type: UITableViewCell.self)
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(reload), for: .valueChanged)
    }
    
    @objc func reload() {
        self.items = viewModel.getFavorites()
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }
}

// MARK: - Table View delegate & datasource
extension FavoriteListViewController: UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.selectionStyle = .none
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        let viewModel = TVSeriesDetailViewModel(tvServies: item)
        let viewController = TVSeriesDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "Nothing here for now")
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        return NSAttributedString(string: "Click to refresh")
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        reload()
    }
}

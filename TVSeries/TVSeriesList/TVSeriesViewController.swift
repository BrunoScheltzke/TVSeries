//
//  TVSeriesViewController.swift
//  TVSeries
//
//  Created by Bruno Scheltzke on 21/12/21.
//

import UIKit

class TVSeriesViewController: UIViewController {
    
    // MARK: - Views
    private let searchController = UISearchController()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let padding: CGFloat =  50
        let collectionViewSize = view.frame.size.width - padding
        
        layout.itemSize = CGSize(width: collectionViewSize/2, height: collectionViewSize)
        layout.footerReferenceSize = CGSize(width: view.frame.width, height: 100)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        return collection
    }()
    
    private var isFiltering: Bool {
        let isSearchBarEmpty = searchController.searchBar.text?.isEmpty ?? true
        return searchController.isActive && !isSearchBarEmpty
    }
    
    private var filteredTvSeries = [TVSeries]()
    private var viewModel: TVSeriesViewModelProtocol

    // MARK: - Life Cycle
    init(viewModel: TVSeriesViewModelProtocol = TVSeriesViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "TVSeries"
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        viewModel.getTVSeries()
        setupNavBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backButtonTitle = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = .white
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    // MARK: - View Setup
    private func setupNavBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    private func setupCollectionView() {
        collectionView.constraintFully(to: view)
        collectionView.register(type: TVSeriesCollectionViewCell.self)
        collectionView.register(type: IndicatorCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Search delegate
extension TVSeriesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let search = searchBar.text, !search.isEmpty else { return }
        viewModel.searchTVSeries(search: search)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        collectionView.reloadData()
    }
}

// MARK: - Collection view delegate & datasource
extension TVSeriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFiltering ? filteredTvSeries.count : viewModel.tvSeriesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TVSeriesCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let item = isFiltering ? filteredTvSeries[indexPath.row] : viewModel.tvSeriesList[indexPath.row]
        cell.tvSeries = item
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = isFiltering ? filteredTvSeries[indexPath.row] : viewModel.tvSeriesList[indexPath.row]
        let viewModel = TVSeriesDetailViewModel(tvServies: item)
        let viewController = TVSeriesDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // Adds activity indicator at bottom of collection view to present a loading animation while fetching extra tv series.
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let footer: IndicatorCell = collectionView.dequeueReusableSupplementaryView(forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, for: indexPath)
            isFiltering ? footer.indicator.stopAnimating() : footer.indicator.startAnimating()
            return footer
        default:
           assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if !isFiltering {
            viewModel.getTVSeries()
        }
    }
}

extension TVSeriesViewController: TVSeriesViewModelDelegate {
    func failed(message: String) {
        present(message: message)
    }
    
    func didUpdateTVSeriesListWithItems(atRows rows: [Int]) {
        collectionView.insertItems(at: rows.map { IndexPath(row: $0, section: 0) })
    }
    
    func didGet(_ filteredTVSeries: [TVSeries]) {
        self.filteredTvSeries = filteredTVSeries
        collectionView.reloadData()
        if !filteredTVSeries.isEmpty {
            collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }
}

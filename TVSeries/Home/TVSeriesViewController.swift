//
//  TVSeriesViewController.swift
//  TVSeries
//
//  Created by Bruno Scheltzke on 21/12/21.
//

import UIKit

class TVSeriesViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width: CGFloat = 60
        let height: CGFloat = 60

        layout.itemSize = CGSize(width: width, height: height)
        layout.footerReferenceSize = CGSize(width: view.frame.width, height: 100)
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    var viewModel: TVSeriesViewModelProtocol

    init(viewModel: TVSeriesViewModelProtocol = TVSeriesViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
    }
    
    func setupCollectionView() {
        collectionView.constraintFully(to: view)
        collectionView.register(type: TVSeriesCollectionViewCell.self)
        collectionView.register(type: IndicatorCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension TVSeriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tvSeriesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TVSeriesCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let item = viewModel.tvSeriesList[indexPath.row]
        cell.tvSeries = item
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.tvSeriesList[indexPath.row]
    }
    
    // Adds activity indicator at bottom of collection view to present a loading animation while fetching extra tv series.
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let footer: IndicatorCell = collectionView.dequeueReusableSupplementaryView(forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, for: indexPath)
            return footer
        default:
           assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        viewModel.getTVSeries()
    }
}

extension TVSeriesViewController: TVSeriesViewModelDelegate {
    func failed(message: String) {
        present(message: message)
    }
    
    func didUpdateTVSeriesListWithItems(atRows rows: [Int]) {
        collectionView.insertItems(at: rows.map { IndexPath(row: $0, section: 0) })
    }
}

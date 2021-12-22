//
//  TVSeriesViewController.swift
//  TVSeries
//
//  Created by Bruno Scheltzke on 21/12/21.
//

import UIKit

class TVSeriesViewController: UIViewController {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var tvSeries = [TVSeries]()
    
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
        
        let btn = UIButton()
        btn.setTitle("Reload", for: .normal)
        btn.addTarget(self, action: #selector(reload), for: .touchUpInside)
        btn.constraintFully(to: view)
    }
    
    @objc func reload() {
        viewModel.getTVSeries()
    }
    
    func setupCollectionView() {
        collectionView.constraintFully(to: view)
        collectionView.register(type: TVSeriesCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension TVSeriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvSeries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TVSeriesCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let item = tvSeries[indexPath.row]
        cell.tvSeries = item
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = tvSeries[indexPath.row]
    }
}

extension TVSeriesViewController: TVSeriesViewModelDelegate {
    func failed(message: String) {
        present(message: message)
    }
    
    func didGet(_ tvSeries: [TVSeries]) {
        self.tvSeries = tvSeries
        collectionView.reloadData()
    }
}

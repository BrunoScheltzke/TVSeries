//
//  TVSeriesDetailViewController.swift
//  TVSeries
//
//  Created by Bruno Scheltzke on 22/12/21.
//

import UIKit

struct Season {
    let name: String
    let episodes: [Episode]
}

class TVSeriesDetailViewController: UIViewController {
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: IntrinsicTableView!
    
    private var viewModel: TVSeriesDetailViewModelProtocol
    private let imageManager: ImageManagerProtocol
    
    var seasons = [Season]()
    
    // The variant sizes the header view can be
    let headerViewDefaultHeight: CGFloat = 300
    let headerViewMinimunHeight: CGFloat = 100
    lazy var headerViewMaxHeight: CGFloat = view.frame.height
    var isShowingHeaderFullScreen: Bool = false

    init(viewModel: TVSeriesDetailViewModelProtocol, imageManager: ImageManagerProtocol = ImageManager.shared) {
        self.viewModel = viewModel
        self.imageManager = imageManager
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerViewCode(type: UITableViewCell.self)
        navigationItem.backButtonTitle = " "
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        scrollView.contentInset = UIEdgeInsets(top: headerViewDefaultHeight, left: 0, bottom: 0, right: 0)
        scrollView.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(expandColapseHeaderImage))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        if let image = viewModel.tvSeries.image {
            imageManager.fetchImage(imagePath: image.original) { [weak self] result in
                guard let self = self else { return }
                if case let .success(img) = result {
                    self.imageView.image = img
                }
            }
        }
        nameLabel.text = viewModel.tvSeries.name
        summaryLabel.text = viewModel.tvSeries.summary?.htmlStripped
        genresLabel.text = viewModel.tvSeries.genres.joined(separator: ", ")
        scheduleLabel.text = "Time: \(viewModel.tvSeries.schedule.time). Days: \(viewModel.tvSeries.schedule.days.joined(separator: ", "))"
        viewModel.getSeasons()
    }
    
    @objc func expandColapseHeaderImage() {
        imageViewHeightConstraint.constant = isShowingHeaderFullScreen ? headerViewDefaultHeight : view.frame.height
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.isShowingHeaderFullScreen.toggle()
        }
    }
}

extension TVSeriesDetailViewController: TVSeriesDetailViewModelDelegate {
    func failed(message: String) {
        present(message: message)
    }
    
    func didGet(_ seasons: [Season]) {
        self.seasons = seasons
        tableView.reloadData()
    }
}

extension TVSeriesDetailViewController: UIScrollViewDelegate {
    // MARK: Scroll header animation
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = headerViewDefaultHeight - (scrollView.contentOffset.y + headerViewDefaultHeight)
        imageViewHeightConstraint.constant = min(max(y, headerViewMinimunHeight), headerViewMaxHeight)
    }
}

extension TVSeriesDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        let item = seasons[indexPath.section].episodes[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasons[section].episodes.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return seasons.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return seasons[section].name
    }
}

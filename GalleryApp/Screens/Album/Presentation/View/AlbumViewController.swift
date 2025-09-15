//
//  AlbumViewController.swift
//  GalleryApp
//
//  Created by Mohamed Kotb on 15/09/2025.
//

import UIKit
import Combine

// MARK: - AlbumViewController
final class AlbumViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Vriables
    private let albumId: Int
    private let albumTitle: String
    private let viewModel = AlbumViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    init(albumId: Int, albumTitle: String) {
        self.albumId = albumId
        self.albumTitle = albumTitle
        super.init(nibName: "AlbumViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = albumTitle
        setupUI()
        bindViewModel()
        viewModel.fetchPhotos(albumId: albumId)
    }

    // MARK: - Setup UI
    private func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerNib(PhotoCell.self)
        collectionView.collectionViewLayout = createCompositionalLayout()
        searchBar.delegate = self
        searchBar.placeholder = "Search in images.."
        navigationController?.navigationBar.tintColor = .black
    }
    
    // MARK: - Bindings
    private func bindViewModel() {
        viewModel.$filteredPhotos
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Layout
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33),
                                                  heightDimension: .fractionalWidth(0.33))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalWidth(0.33))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item, item])
            
            return NSCollectionLayoutSection(group: group)
        }
    }
}


// MARK: - UICollectionViewDataSource & Delegate
extension AlbumViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,  UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filteredPhotos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(PhotoCell.self, for: indexPath)
        cell.configure(with: viewModel.filteredPhotos[indexPath.row])
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension AlbumViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterPhotos(query: searchText)
    }
}


//
//  ProfileViewController.swift
//  GalleryApp
//
//  Created by Mohamed Kotb on 15/09/2025.
//

import UIKit
import Combine

// MARK: - ProfileViewController
final class ProfileViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userAddress: UILabel!
    @IBOutlet weak var albumTabelView: UITableView!
    
    // MARK: - Vriables
    private let viewModel = ProfileViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init with nib
    init() {
        super.init(nibName: "ProfileViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.loadUser()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        albumTabelView.delegate = self
        albumTabelView.dataSource = self
        albumTabelView.registerNib(AlbumCell.self)
    }
    
    // MARK: - Bindings
    private func bindViewModel() {
        viewModel.$user
            .sink { [weak self] user in
                guard let user = user else { return }
                self?.userName.text = user.name
                self?.userAddress.text = "\(user.address.street), \(user.address.suite), \(user.address.city), \(user.address.zipcode)"
            }
            .store(in: &cancellables)
        
        viewModel.$albums
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.albumTabelView.reloadData()
                }
            }
            .store(in: &cancellables)
    }
}


// MARK: - UITableViewDelegate & DataSource
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(AlbumCell.self, for: indexPath)
        cell.albumName?.text = viewModel.albums[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = viewModel.albums[indexPath.row]
        let albumVC = AlbumViewController(albumId: album.id, albumTitle: album.title)
        navigationController?.pushViewController(albumVC, animated: true)
    }
}

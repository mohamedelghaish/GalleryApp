//
//  AlbumViewModel.swift
//  GalleryApp
//
//  Created by Mohamed Kotb on 15/09/2025.
//

import Foundation
import Combine
import Foundation

// MARK: - AlbumViewModel
final class AlbumViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    @Published var filteredPhotos: [Photo] = []
    
    private let fetchPhotosUseCase: FetchPhotosUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.fetchPhotosUseCase = FetchPhotosUseCaseImpl() 
    }
    
    // MARK: - Network
    func fetchPhotos(albumId: Int) {
        fetchPhotosUseCase.execute(albumId: albumId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Failed to load photos: \(error)")
                }
            }, receiveValue: { [weak self] photos in
                self?.photos = photos
                self?.filteredPhotos = photos
            })
            .store(in: &cancellables)
    }
    
    // MARK: - Filtering
    func filterPhotos(query: String) {
        filteredPhotos = query.isEmpty
        ? photos
        : photos.filter { $0.title.lowercased().contains(query.lowercased()) }
    }
}

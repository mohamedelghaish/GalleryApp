//
//  PhotosUseCase .swift
//  GalleryApp
//
//  Created by Mohamed Kotb on 15/09/2025.
//

import Foundation
import Combine

protocol FetchPhotosUseCase {
    func execute(albumId: Int) -> AnyPublisher<[Photo], Error>
}

final class FetchPhotosUseCaseImpl: FetchPhotosUseCase {
    private let repository: PhotoRepository
    
    init() {
        self.repository = PhotoRepositoryImpl() 
    }
    
    func execute(albumId: Int) -> AnyPublisher<[Photo], Error> {
        repository.fetchPhotos(albumId: albumId)
    }
}

//
//  PhotoRepository.swift
//  GalleryApp
//
//  Created by Mohamed Kotb on 15/09/2025.
//

import Foundation
import Combine
import Moya

// MARK: - Repository Protocol
protocol PhotoRepository {
    func fetchPhotos(albumId: Int) -> AnyPublisher<[Photo], Error>
}

// MARK: - Repository Implementation
final class PhotoRepositoryImpl: PhotoRepository {
    private let provider: MoyaProvider<APIService>
    
    init() {
        self.provider = MoyaProvider<APIService>() 
    }
    
    func fetchPhotos(albumId: Int) -> AnyPublisher<[Photo], Error> {
        provider.fetchData(.getPhotos(albumId: albumId), responseType: [PhotoDTO].self)
            .map { $0.map { $0.toDomain() } }
            .eraseToAnyPublisher()
    }
}

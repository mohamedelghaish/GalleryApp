//
//  UserRepository.swift
//  GalleryApp
//
//  Created by Mohamed Kotb on 15/09/2025.
//

import Foundation
import Combine
import Moya
// MARK: - Repository Implementation
protocol UserRepository {
    func fetchUser() -> AnyPublisher<User, Error>
    func fetchAlbums(userId: Int) -> AnyPublisher<[Album], Error>
}

final class UserRepositoryImpl: UserRepository {
    private let provider: MoyaProvider<APIService>
    
    init(provider: MoyaProvider<APIService> = MoyaProvider<APIService>()) {
        self.provider = provider
    }
    
    func fetchUser() -> AnyPublisher<User, Error> {
        provider.fetchData(.getUsers, responseType: [UserDTO].self)
            .compactMap { $0.randomElement()?.toDomain() }
            .eraseToAnyPublisher()
    }
    
    func fetchAlbums(userId: Int) -> AnyPublisher<[Album], Error> {
        provider.fetchData(.getAlbums(userId: userId), responseType: [AlbumDTO].self)
            .map { $0.map { $0.toDomain() } }
            .eraseToAnyPublisher()
    }
}

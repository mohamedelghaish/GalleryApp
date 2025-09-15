//
//  ProfileUseCase.swift
//  GalleryApp
//
//  Created by Mohamed Kotb on 15/09/2025.
//

import Foundation
import Combine
// MARK: - Use Cases
protocol FetchUserUseCase {
    func execute() -> AnyPublisher<User, Error>
}

protocol FetchAlbumsUseCase {
    func execute(userId: Int) -> AnyPublisher<[Album], Error>
}

final class FetchUserUseCaseImpl: FetchUserUseCase {
    
    private let repository: UserRepository
    
    init() {
        self.repository = UserRepositoryImpl()
    }
    
    func execute() -> AnyPublisher<User, Error> {
        repository.fetchUser()
    }
}

final class FetchAlbumsUseCaseImpl: FetchAlbumsUseCase {
    
    private let repository: UserRepository
    
    init() {
        self.repository = UserRepositoryImpl()
    }
    
    func execute(userId: Int) -> AnyPublisher<[Album], Error> {
        repository.fetchAlbums(userId: userId)
    }
}

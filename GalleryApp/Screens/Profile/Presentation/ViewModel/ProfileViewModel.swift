//
//  ProfileViewModel.swift
//  GalleryApp
//
//  Created by Mohamed Kotb on 15/09/2025.
//

import Foundation
import Combine

final class ProfileViewModel: ObservableObject {
    @Published var user: User?
    @Published var albums: [Album] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    private let fetchUserUseCase: FetchUserUseCase
    private let fetchAlbumsUseCase: FetchAlbumsUseCase
    
    init() {
        self.fetchUserUseCase = FetchUserUseCaseImpl()
        self.fetchAlbumsUseCase = FetchAlbumsUseCaseImpl() 
    }
    
    func loadUser() {
        fetchUserUseCase.execute()
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("❌ Failed to load user: \(error)")
                }
            }, receiveValue: { [weak self] user in
                self?.user = user
                self?.loadAlbums(for: user.id)
            })
            .store(in: &cancellables)
    }
    
    func loadAlbums(for userId: Int) {
        fetchAlbumsUseCase.execute(userId: userId)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("❌ Failed to load albums: \(error)")
                }
            }, receiveValue: { [weak self] albums in
                self?.albums = albums
            })
            .store(in: &cancellables)
    }
}

//
//  Photo.swift
//  GalleryApp
//
//  Created by Mohamed Kotb on 15/09/2025.
//

import Foundation

// MARK: - DTOs
struct PhotoDTO: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

// MARK: - Mappers
extension PhotoDTO {
    func toDomain() -> Photo {
        Photo(albumId: albumId,
              id: id,
              title: title,
              url: url,
              thumbnailUrl: thumbnailUrl)
    }
}

//
//  ProfileModel.swift
//  GalleryApp
//
//  Created by Mohamed Kotb on 15/09/2025.
//

import Foundation
// MARK: - DTOs
struct UserDTO: Codable {
    let id: Int
    let name: String
    let address: AddressDTO
}

struct AddressDTO: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
}

struct AlbumDTO: Codable {
    let id: Int
    let title: String
    let userId: Int
}

// MARK: - Mappers
extension UserDTO {
    func toDomain() -> User {
        User(id: id, name: name,
             address: Address(street: address.street,
                              suite: address.suite,
                              city: address.city,
                              zipcode: address.zipcode))
    }
}

extension AlbumDTO {
    func toDomain() -> Album {
        Album(id: id, title: title, userId: userId)
    }
}

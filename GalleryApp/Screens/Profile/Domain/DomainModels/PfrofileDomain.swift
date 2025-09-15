//
//  PfrofileDomain.swift
//  GalleryApp
//
//  Created by Mohamed Kotb on 15/09/2025.
//

import Foundation
// MARK: - Domain Models
struct User {
    let id: Int
    let name: String
    let address: Address
}

struct Address {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
}

struct Album {
    let id: Int
    let title: String
    let userId: Int
}

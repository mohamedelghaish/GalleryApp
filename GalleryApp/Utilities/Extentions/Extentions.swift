//
//  Extentions.swift
//  GalleryApp
//
//  Created by Mohamed Kotb on 15/09/2025.
//

import Foundation
import UIKit

// MARK: - UITableView Extension
extension UITableView {
    func dequeue<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Could not dequeue cell with type \(T.self)")
        }
        cell.selectionStyle = .none
        
        return cell
    }
    func registerNib<T: UITableViewCell>(_: T.Type) {
        let name = String(describing: T.self)
        register(UINib(nibName: name, bundle: Bundle(for: T.self)), forCellReuseIdentifier: name)
    }
}

// MARK: - UICollectionView Extension
extension UICollectionView {
    func registerNib<T: UICollectionViewCell>(_: T.Type) {
        let name = String(describing: T.self)
        register(UINib(nibName: name, bundle: Bundle(for: T.self)), forCellWithReuseIdentifier: name)
    }
    
    func dequeue<T: UICollectionViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self),
                                             for: indexPath) as? T else {
            fatalError("Could not dequeue cell with type \(T.self)")
        }
        
        return cell
    }
}

// MARK: - UIView Extension
extension UIView {
    func findViewController() -> UIViewController? {
        var nextResponder: UIResponder? = self
        while let responder = nextResponder {
            if let vc = responder as? UIViewController {
                return vc
            }
            nextResponder = responder.next
        }
        return nil
    }
}

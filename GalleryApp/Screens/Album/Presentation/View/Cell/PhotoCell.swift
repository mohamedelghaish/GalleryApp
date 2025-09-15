//
//  PhotoCell.swift
//  GalleryApp
//
//  Created by Mohamed Kotb on 15/09/2025.
//

import UIKit
import Kingfisher

// MARK: - PhotoCell
class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    private var imageUrl: URL?
    // MARK: - Lifecycle
    override func awakeFromNib() {
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 0
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
                imageView.isUserInteractionEnabled = true
                imageView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Helpers
    func convertPlaceholderUrl(_ url: String) -> String {
        if url.contains("via.placeholder.com"),
           let colorCode = url.components(separatedBy: "/").last {
            return "https://dummyimage.com/600/\(colorCode)/white"
        }
        return url
    }

    // MARK: - Configuration
    func configure(with photo: Photo) {
        let updatedUrlString = convertPlaceholderUrl(photo.url)
        print(updatedUrlString)
        if let url = URL(string: updatedUrlString) {
            self.imageUrl = url
            imageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"),
                                  options: [
                                    .forceRefresh,
                                    .cacheOriginalImage
                                  ]
            )
        }
    }

    // MARK: - Actions
    @objc private func imageTapped() {
        guard let imageUrl = imageUrl else { return }
        if let parentVC = self.findViewController() {
            let imageViewerVC = ImageViewerViewController(imageUrl: imageUrl)
            parentVC.present(imageViewerVC, animated: true)
        }
    }
}

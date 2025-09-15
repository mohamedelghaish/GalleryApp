//
//  AlbumCell.swift
//  GalleryApp
//
//  Created by Mohamed Kotb on 15/09/2025.
//

import UIKit

// MARK: - AlbumCell
class AlbumCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var albumName: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

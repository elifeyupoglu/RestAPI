//
//  AlbumCollectionViewCell.swift
//  RestAPI
//
//  Created by Elif on 8.01.2020.
//  Copyright © 2020 Elif. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Elements
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Functions
    func prepareForDrawing(photosData: PhotosData) {
        imageView.image = UIImage(contentsOfFile: photosData.url)
        titleLabel.text = photosData.title
    }
}

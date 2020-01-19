//
//  AlbumsTableViewCell.swift
//  RestAPI
//
//  Created by Elif on 18.01.2020.
//  Copyright © 2020 Elif. All rights reserved.
//

import UIKit

class AlbumsTableViewCell: UITableViewCell {

    // MARK: - UI Elements
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Functions
    func prepareForDrawing(albumsData: AlbumsData) {
        titleLabel.text = albumsData.title
    }
}

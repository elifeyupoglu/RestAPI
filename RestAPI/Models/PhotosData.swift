//
//  PhotosData.swift
//  RestAPI
//
//  Created by Elif on 18.01.2020.
//  Copyright © 2020 Elif. All rights reserved.
//

import UIKit

struct PhotosData: Decodable {
    
    // MARK: - Properties
    let id: Int
    let albumId: Int
    let title: String
    let url: String
    let thumbnailUrl: String
    
}

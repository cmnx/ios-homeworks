//
//  protocols.swift
//  Navigation
//
//  Created by Constantin on 20.05.2022.
//

import Foundation
import UIKit

protocol PhotoCollectionDelegate: AnyObject {
    func expandPhoto(image: UIImage)
}

protocol PhotoGalleryDelegate: AnyObject {
    func openPhotoGallery()
}

protocol PostDetailsDelegate: AnyObject {
    func incrementLikes() -> Int
}

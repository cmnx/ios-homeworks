//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Constantin on 17.05.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(img: UIImageView) {
        
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        
        contentView.addSubview(img)
        
        let width: CGFloat = (UIScreen.main.bounds.width - 8 * 4) / 3
        
        NSLayoutConstraint.activate([
            img.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            img.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            img.topAnchor.constraint(equalTo: contentView.topAnchor),
            img.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            img.heightAnchor.constraint(equalTo: img.widthAnchor),
            img.widthAnchor.constraint(equalToConstant: width)
        ])
    }
}

//
//  PhotosHorizontalCollectionViewCell.swift
//  Navigation
//
//  Created by Constantin on 18.05.2022.
//

import UIKit

class PhotosHorizontalCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(img: UIImageView) {
        
        img.layer.cornerRadius = 6
        img.clipsToBounds = true
        
        contentView.addSubview(img)
        
        NSLayoutConstraint.activate([
            img.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            img.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            img.topAnchor.constraint(equalTo: contentView.topAnchor),
            img.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            img.heightAnchor.constraint(equalTo: img.widthAnchor)
            //img.widthAnchor.constraint(equalToConstant:
                                        //(UIScreen.main.bounds.width - 12 * 2 - 8 * 3) / 4)
        ])
    }
}

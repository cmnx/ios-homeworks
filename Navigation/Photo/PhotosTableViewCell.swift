//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Constantin on 17.05.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    weak var photoGalleryDelegate: PhotoGalleryDelegate?
    weak var photoCollectionDelegate: PhotoCollectionDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - layout
    
    private func loadLayout() {
        
        [backgndView,
         photoCollectionLabel,
         openPhotosCollectionButton,
         photoCollectionView
        ].forEach { contentView.addSubview($0) }
        
        let inset: CGFloat = 12
        
        NSLayoutConstraint.activate([
            backgndView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgndView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgndView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgndView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        //---
            photoCollectionLabel.leadingAnchor.constraint(equalTo: backgndView.leadingAnchor, constant: inset),
            photoCollectionLabel.topAnchor.constraint(equalTo: backgndView.topAnchor, constant: inset),
        //---
            openPhotosCollectionButton.trailingAnchor.constraint(equalTo: photoCollectionView.trailingAnchor),
            openPhotosCollectionButton.centerYAnchor.constraint(equalTo: photoCollectionLabel.centerYAnchor),
        //---
            photoCollectionView.leadingAnchor.constraint(equalTo: backgndView.leadingAnchor, constant: inset),
            photoCollectionView.trailingAnchor.constraint(equalTo: backgndView.trailingAnchor, constant: -inset),
            photoCollectionView.topAnchor.constraint(equalTo: photoCollectionLabel.bottomAnchor, constant: inset),
            photoCollectionView.bottomAnchor.constraint(equalTo: backgndView.bottomAnchor, constant: -inset),
            photoCollectionView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width-inset*2-8*3)/4)
        ])
    }
    
// MARK: - views
    
    private let backgndView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        collection.dataSource = self
        collection.delegate = self
        collection.register(PhotosHorizontalCollectionViewCell.self, forCellWithReuseIdentifier: PhotosHorizontalCollectionViewCell.identifier)
        return collection
    }()

    private let photoCollectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "Photos"
        return label
    }()

    private lazy var openPhotosCollectionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "arrow.right")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(openPhotoGallery), for: .touchUpInside)
        return button
    }()
    
    @objc private func openPhotoGallery() {
        photoGalleryDelegate?.openPhotoGallery()
    }
}

//MARK: - collection data source

extension PhotosTableViewCell: UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageViewArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosHorizontalCollectionViewCell.identifier, for: indexPath) as! PhotosHorizontalCollectionViewCell
        cell.config(img: imageViewArray[indexPath.item])
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
}

//MARK: - collection delegate

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    
    private var inset: CGFloat { return 8 }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 3 * inset) / 4
        return CGSize(width: width, height: width)
    }

// MARK: - insets for collection
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        inset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        photoCollectionDelegate?.expandPhoto(image: imageViewArray[indexPath.item].image ?? UIImage(systemName: "xmark")!)
    }
}

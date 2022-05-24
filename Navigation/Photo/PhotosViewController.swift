//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Constantin on 17.05.2022.
//

import UIKit

class PhotosViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadLayout()
        self.title = "Photo Gallery"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
            
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.backgroundColor = .white
    }
    
    var blackoutViewPortrait = [NSLayoutConstraint]()
    var blackoutViewLandscape = [NSLayoutConstraint]()

// MARK: - views
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .black
        collection.dataSource = self
        collection.delegate = self
        collection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return collection
    }()
    
    private var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var blackoutView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black.withAlphaComponent(0.8)
        view.isHidden = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(collapseImage)))
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let confImageButton = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: "xmark", withConfiguration: confImageButton)?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(collapseImage), for: .touchUpInside)
        return button
    }()

// MARK: - layout
    
    private func loadLayout() {
        
        view.addSubview(collectionView)
        view.addSubview(blackoutView)
        blackoutView.addSubview(closeButton)
        blackoutView.addSubview(imageView)
        
        blackoutViewPortrait = [
            blackoutView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            blackoutView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            closeButton.topAnchor.constraint(equalTo: blackoutView.topAnchor, constant: 30),
            closeButton.trailingAnchor.constraint(equalTo: blackoutView.trailingAnchor, constant: -10),
            imageView.centerXAnchor.constraint(equalTo: blackoutView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: blackoutView.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.heightAnchor.constraint(equalTo: blackoutView.widthAnchor)
        ]
        blackoutViewLandscape = [
            blackoutView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            blackoutView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            closeButton.topAnchor.constraint(equalTo: blackoutView.topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: blackoutView.trailingAnchor, constant: -100),
            imageView.centerXAnchor.constraint(equalTo: blackoutView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: blackoutView.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.heightAnchor.constraint(equalTo: blackoutView.widthAnchor)
        ]
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - collection data source

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageViewArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.config(img: imageViewArray[indexPath.item])
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
}

//MARK: - collection delegate

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    private var inset: CGFloat { return 8 }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.bounds.width - inset * 4) / 3
        return CGSize(width: width, height: width)
    }

// MARK: - insets for collection
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        inset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        inset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageView.image = imageViewArray[indexPath.item].image
        expandPhoto(photo: imageView)
    }
}

// MARK: - functions - gestures

extension PhotosViewController {
   
    func expandPhoto(photo: UIImageView) {
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.1,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.2,
                       options: .curveEaseInOut) {
            
            self.navigationController?.isNavigationBarHidden = true
            self.tabBarController?.tabBar.isHidden = true
            self.blackoutView.isHidden = false
            
            photo.layer.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
            
            var size: CGFloat = 0
            
            if UIDevice.current.orientation.isPortrait {
                
                photo.layer.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
                
                size = UIScreen.main.bounds.width
                photo.layer.bounds = CGRect(x: 0, y: 0, width: size, height: size)
                
                NSLayoutConstraint.deactivate(self.blackoutViewLandscape)
                NSLayoutConstraint.activate(self.blackoutViewPortrait)
                
            } else {
                
                photo.layer.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
                
                size = UIScreen.main.bounds.height
                photo.layer.bounds = CGRect(x: 0, y: 0, width: size, height: size)
                
                NSLayoutConstraint.deactivate(self.blackoutViewPortrait)
                NSLayoutConstraint.activate(self.blackoutViewLandscape)
                
            }
            
            self.view.layoutIfNeeded()
            
        } completion: { _ in
            UIView.animate(withDuration: 0.3,
                           animations: {
                self.closeButton.backgroundColor = .red.withAlphaComponent(1)
            })
        }
    }

    @objc private func collapseImage() {
            
        UIView.animate(withDuration: 0.5,
                       delay: 0.1,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.2,
                       options: .curveEaseInOut) {
                
        self.blackoutView.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        self.view.layoutIfNeeded()
        
        }
    }
        
}

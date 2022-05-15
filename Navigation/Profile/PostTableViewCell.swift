//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Constantin on 15.05.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(_ post: ProfileViewController.PostStruct) {
        postAuthor.text = post.author
        postImage.image = post.image
        postDescription.text = post.description
        postLikes.text = "Likes: \(post.likes)"
        postViews.text = "Views: \(post.views)"
    }

// MARK: - layout
    
    private func loadLayout() {
        
        [backgndView,
         postAuthor,
         postImage,
         postDescription,
         postLikes,
         postViews
        ].forEach { contentView.addSubview($0) }
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            backgndView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            backgndView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            backgndView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgndView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        //---
            postAuthor.leadingAnchor.constraint(equalTo: backgndView.leadingAnchor, constant: inset),
            postAuthor.trailingAnchor.constraint(equalTo: backgndView.trailingAnchor, constant: -inset),
            postAuthor.topAnchor.constraint(equalTo: backgndView.topAnchor, constant: inset),
            postAuthor.bottomAnchor.constraint(equalTo: postImage.topAnchor, constant: -inset),
        //---
            //postImage.leftAnchor.constraint(equalTo: backgndView.leftAnchor),
            postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImage.heightAnchor.constraint(equalTo: contentView.widthAnchor),
        // ---
            postDescription.leadingAnchor.constraint(equalTo: backgndView.leadingAnchor, constant: inset),
            postDescription.trailingAnchor.constraint(equalTo: backgndView.trailingAnchor, constant: -inset),
            postDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: inset),
            postDescription.bottomAnchor.constraint(equalTo: postLikes.topAnchor, constant: -inset),
        //---
            postLikes.leadingAnchor.constraint(equalTo: backgndView.leadingAnchor, constant: inset),
            postLikes.topAnchor.constraint(equalTo: postViews.topAnchor),
            postLikes.bottomAnchor.constraint(equalTo: postViews.bottomAnchor),
        //---
            postViews.trailingAnchor.constraint(equalTo: backgndView.trailingAnchor, constant: -inset),
            postViews.bottomAnchor.constraint(equalTo: backgndView.bottomAnchor, constant: -inset)
        ])
    }
    
// MARK: - views
    
    private let backgndView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private let postAuthor: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        label.text = "Author name here"
        return label
    }()
    
    private let postImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .black
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let postDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.text = "Description here"
        return label
    }()
    
    private let postLikes: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.text = "0"
        return label
    }()
    
    private let postViews: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.text = "0"
        return label
    }()
}

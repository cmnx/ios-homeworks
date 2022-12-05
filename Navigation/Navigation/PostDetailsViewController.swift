//
//  PostDetailsViewController.swift
//  Navigation
//
//  Created by Constantin on 22.05.2022.
//

import UIKit

class PostDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadLayout()
    }
    
    weak var postDetailsDelegate: PostDetailsDelegate?
    
    @objc private func postLike(_ sender: UITapGestureRecognizer) {
        let incrementedLikes: Int = postDetailsDelegate?.incrementLikes() ?? 0
        postLikes.text = "Likes: \(incrementedLikes)"
        view.layoutIfNeeded()
    }
    
    func config(_ post: PostStruct) {
        postAuthor.text = post.author
        postImage.image = post.image
        postDescription.text = post.description
        postLikes.text = "Likes: \(post.likes)"
        postViews.text = "Views: \(post.views)"
    }

// MARK: - layout
    
    private func loadLayout() {
        
        let inset: CGFloat = 16
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: inset),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -inset),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -inset * 2)
        ])
        
        [postAuthor,
         postImage,
         postDescription,
         postLikes,
         postViews
        ].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            postAuthor.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            postAuthor.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            postAuthor.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            postAuthor.bottomAnchor.constraint(equalTo: postImage.topAnchor, constant: -inset),
        //---
            postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImage.heightAnchor.constraint(equalTo: contentView.widthAnchor),
        // ---
            postDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            postDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            postDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: inset),
            postDescription.bottomAnchor.constraint(equalTo: postLikes.topAnchor, constant: -inset),
        //---
            postLikes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            postLikes.topAnchor.constraint(equalTo: postViews.topAnchor),
            postLikes.bottomAnchor.constraint(equalTo: postViews.bottomAnchor),
        //---
            postViews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            postViews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
// MARK: - views
        
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private let contentView: UIView = {
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
    
    private lazy var postImage: UIImageView = {
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
    
    lazy var postLikes: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.text = "0"
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(postLike(_:))))
        label.isUserInteractionEnabled = true
        return label
    }()
    
    var postViews: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.text = "0"
        return label
    }()
}

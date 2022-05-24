//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Constantin on 04.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private var post: [PostStruct] = PostStruct.assemblingPosts()
    private var tableIndex: IndexPath = IndexPath()
    var blackoutViewPortrait = [NSLayoutConstraint]()
    var blackoutViewLandscape = [NSLayoutConstraint]()
    
// MARK: - layout
    
    private func loadLayout() {
        
        view.addSubview(tableView)
        
        view.addSubview(blackoutView)
        blackoutView.addSubview(closeButton)
        blackoutView.addSubview(imageTableView)
        
        blackoutViewPortrait = [
            blackoutView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            blackoutView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            closeButton.topAnchor.constraint(equalTo: blackoutView.topAnchor, constant: 30),
            closeButton.trailingAnchor.constraint(equalTo: blackoutView.trailingAnchor, constant: -10),
            imageTableView.centerXAnchor.constraint(equalTo: blackoutView.centerXAnchor),
            imageTableView.centerYAnchor.constraint(equalTo: blackoutView.centerYAnchor),
            imageTableView.widthAnchor.constraint(equalTo: imageTableView.heightAnchor),
            imageTableView.heightAnchor.constraint(equalTo: blackoutView.widthAnchor)
        ]
        blackoutViewLandscape = [
            blackoutView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            blackoutView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            closeButton.topAnchor.constraint(equalTo: blackoutView.topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: blackoutView.trailingAnchor, constant: -100),
            imageTableView.centerXAnchor.constraint(equalTo: blackoutView.centerXAnchor),
            imageTableView.centerYAnchor.constraint(equalTo: blackoutView.centerYAnchor),
            imageTableView.widthAnchor.constraint(equalTo: imageTableView.heightAnchor),
            imageTableView.heightAnchor.constraint(equalTo: blackoutView.widthAnchor)
        ]
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

// MARK: - views
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        tableView.separatorInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        return tableView
    }()
    
    private var imageTableView: UIImageView = {
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
}

// MARK: - table view delegate

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return ProfileHeaderView()
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return ProfileHeaderView().viewHeight
        } else {
            return .zero
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        
        guard indexPath.section != 0 else { return }
        
        tableIndex = indexPath
        
        post[indexPath.row].views += 1
        cell.postViews.text = "Views: \(post[indexPath.row].views)"
        
        let postDetailsVC = PostDetailsViewController()
        postDetailsVC.config(post[indexPath.row])
        postDetailsVC.postDetailsDelegate = self
        present(postDetailsVC, animated: true)
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard indexPath.section != 0 else { return nil }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            (action, sourceView, completionHandler) in
            
            self.tableView.beginUpdates()
            self.post.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.endUpdates()
            completionHandler(true)
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        swipeConfiguration.performsFirstActionWithFullSwipe = true
        
        return swipeConfiguration
    }
}

// MARK: - table view data source

extension ProfileViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        } else {
            return post.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as! PhotosTableViewCell
            
            cell.photoGalleryDelegate = self
            cell.photoCollectionDelegate = self
            
            return cell
        
        } else {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
            
            cell.config(post[indexPath.row])
            
            let selectionView = UIView()
            selectionView.backgroundColor = .systemBlue.withAlphaComponent(0.5)
            cell.selectedBackgroundView = selectionView
            
            return cell
        }
    }
}

// MARK: - delegates

extension ProfileViewController: PhotoGalleryDelegate {
   
    func openPhotoGallery() {
        self.navigationController?.pushViewController(PhotosViewController(), animated: true)
    }
}

extension ProfileViewController: PostDetailsDelegate {

    func incrementLikes() -> Int {
        post[tableIndex.row].likes += 1
        tableView.reloadRows(at: [tableIndex], with: .fade)
        return post[tableIndex.row].likes
    }
}

extension ProfileViewController: PhotoCollectionDelegate {
   
    func expandPhoto(image: UIImage) {
        
        imageTableView.image = image
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.1,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.2,
                       options: .curveEaseInOut) {
            
            self.tabBarController?.tabBar.isHidden = true
            self.blackoutView.isHidden = false
            
            self.imageTableView.layer.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
            
            var size: CGFloat = 0
            
            if UIDevice.current.orientation.isPortrait {
                
                self.imageTableView.layer.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
                
                size = UIScreen.main.bounds.width
                self.imageTableView.layer.bounds = CGRect(x: 0, y: 0, width: size, height: size)
                
                NSLayoutConstraint.deactivate(self.blackoutViewLandscape)
                NSLayoutConstraint.activate(self.blackoutViewPortrait)
                
            } else {
                
                self.imageTableView.layer.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
                
                size = UIScreen.main.bounds.height
                self.imageTableView.layer.bounds = CGRect(x: 0, y: 0, width: size, height: size)
                
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
        self.tabBarController?.tabBar.isHidden = false
        self.view.layoutIfNeeded()
        
        }
    }
        
}


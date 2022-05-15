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
   
// MARK: - layout
    
    private func loadLayout() {
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])

    }
    
// MARK: - post struct and test content
    
    private let post: [PostStruct] = PostStruct.assemblingPosts()
    
    struct PostStruct {
        let author: String          //никнейм автора публикации
        let description: String     //текст публикации
        let image: UIImage          //имя картинки из каталога
        var likes: Int              //количество лайков
        var views: Int              //количество просмотров
        
        static func assemblingPosts() -> [PostStruct] {
            var posts = [PostStruct]()
            
            posts.append(PostStruct(author: "Author1", desc: "Dujiangyan Irrigation System was listed as a World Heritage Site by UNESCO in 2000. You can get a panoramic view of the whole system when you go to Erwang Temple that overlooks the whole Dujiangyan Irrigation System.", imgFileName: "Dujiyangyang"))
            posts.append(PostStruct(author: "Author2", desc: "This massive 57-story mall, casino, convention center, and hotel is the country’s most iconic landmark. You can basically do just about anything while visiting this one attraction as it holds one of the largest rooftop infinity pools you will ever see, the country’s largest nightclub, a jogging track, the most luxurious collection of boutiques, a skating rink, a museum, and 2 500 hotel rooms.", imgFileName: "MarinaBaySands"))
            posts.append(PostStruct(author: "Author3", desc: "National Gallery owns more than 9 000 works of art making it the owner of the largest public collection of modern art. Spread across two beautiful national monuments: City Hall and the country’s former Supreme Court, you can spend over half a day wandering around in the museum’s multiple galleries, and not finish it.", imgFileName: "NationalGallery"))
            posts.append(PostStruct(author: "Author4", desc: "One of the unique things of People’s Park is flower shows. The park is also kid-friendly as it has a children’s playground that is facilitated with many fun activities the kids could do. Your day would definitely be unforgettable at People’s Park!", imgFileName: "PeoplesPark"))
            posts.append(PostStruct(author: "Author5", desc: "This island resort is home to major tourist attractions. One of the most visited places by locals and tourists alike for all the fun activities it offers its visitors such as a beach-side relaxing experience, zip-lining at the resort’s Mega Adventure Park, shopping at the massive Luxury Fashion Galleria, or golfing in any of the two award-winning courses in the Sentosa Golf Club.", imgFileName: "SentosaBeach"))
            posts.append(PostStruct(author: "Author6", desc: "This Zoo is a botanic oasis. We can’t really tell thanks to the lively nature of this expansive and interactive park. While there, you can get close to orangutans, see -and try to dodge- Malaysian flying foxes, and visit the replica African village. Regardless of what you do try to do, you will most definitely enjoy your time being so close to nature.", imgFileName: "WhiteTiger"))
            
            return posts
        }
        
        init(author: String, desc: String, imgFileName: String) {
            self.author = author
            self.description = desc
            likes = .random(in: 0...500)
            views = .random(in: 500...1000)
            if let img = UIImage(named: imgFileName) {
                image = img
            } else {
                image = UIImage()
                print("incorrect image file name")
                return
            }
        }
    }
    
// MARK: - views
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.separatorInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        return tableView
    }()
}

// MARK: - table view delegate

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        ProfileHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        ProfileHeaderView().viewHeight
    }
}

// MARK: - table view data source

extension ProfileViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        cell.config(post[indexPath.row])
        
        return cell
    }
}

// MARK: - identifier

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
}

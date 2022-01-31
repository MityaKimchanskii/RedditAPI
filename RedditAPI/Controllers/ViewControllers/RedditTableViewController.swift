//
//  RedditTableViewController.swift
//  RedditAPI
//
//  Created by Mitya Kim on 1/31/22.
//

import UIKit

class RedditTableViewController: UITableViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchSB: UISearchBar!
    
    // MARK: - Properties
    var posts: [Post] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchSB.delegate = self
    }
    
    // MARK: - Helper Methods

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }

        let post = posts[indexPath.row]
        cell.post = post

        return cell
    }
}

extension RedditTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchSB.text, !searchTerm.isEmpty else { return }
        
        PostController.fetchPostWith(searchTerm: searchTerm) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self.posts = posts
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
}

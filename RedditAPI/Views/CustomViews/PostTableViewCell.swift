//
//  PostTableViewCell.swift
//  RedditAPI
//
//  Created by Mitya Kim on 1/31/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    // MARK: -
    @IBOutlet weak var postIV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var upsLabel: UILabel!
    
    // MARK: -
    var post: Post? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - 
    func updateView() {
        guard let post = post else { return }
        titleLabel.text = post.title
        upsLabel.text = "Upvotes\(post.ups)"
        
        PostController.fetchThumbnailFor(post: post) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let thumbnail):
                    self.postIV.image = thumbnail
                case .failure(let error):
                    self.postIV.image = UIImage(systemName: "photo.on.rectangle")
                    print(error)
                    print(error.localizedDescription)
                }
            }
        }
    }
}

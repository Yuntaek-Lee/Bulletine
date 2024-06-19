import UIKit

class PostListViewController: UITableViewController {
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Report"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PostCell")
        
        let composeButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composePost))
        navigationItem.rightBarButtonItem = composeButton
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        let post = posts[indexPath.row]
        cell.textLabel?.numberOfLines = 0 // Multiple lines for title and content
        cell.textLabel?.text = """
        [\(post.priority)] \(post.title)
        Date: \(post.date)
        Author: \(post.author)
        \(post.content)
        """
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let postDetailVC = PostDetailViewController()
        postDetailVC.post = post
        navigationController?.pushViewController(postDetailVC, animated: true)
    }
    
    @objc private func composePost() {
        let composeVC = PostComposeViewController()
        composeVC.onSave = { [weak self] newPost in
            self?.posts.append(newPost)
            self?.tableView.reloadData()
        }
        navigationController?.pushViewController(composeVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Show confirmation alert
            let alert = UIAlertController(title: "Delete Report", message: "Are you sure you want to delete this report? Please recheck if issue has been resolved", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                // Delete the post
                self.posts.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }))
            present(alert, animated: true, completion: nil)
        }
    }
}

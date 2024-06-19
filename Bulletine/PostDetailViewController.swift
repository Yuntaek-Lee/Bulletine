//
//  PostDetailViewController.swift
//  Bulletine
//
//  Created by snlcom on 6/6/24.
//

import UIKit

class PostDetailViewController: UIViewController {
    var post: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        guard let post = post else { return }
        title = post.title

        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.text = """
        [\(post.priority)] \(post.title)
        Date: \(post.date)
        Author: \(post.author)
        
        \(post.content)
        """
        
        view.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
    }
}



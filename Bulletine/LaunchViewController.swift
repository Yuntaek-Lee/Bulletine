//
//  LaunchViewController.swift
//  Bulletine
//
//  Created by snlcom on 6/13/24.
//

import UIKit

class LaunchViewController: UIViewController {
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "backgroundImage") // 여기에 배경 이미지 파일 이름을 추가하세요
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let bulletineButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bulletineIcon"), for: .normal) // 여기에 아이콘 파일 이름을 추가하세요
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(bulletineButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundImageView)
        view.addSubview(bulletineButton)
        
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            bulletineButton.centerXAnchor.constraint(equalTo: view.leadingAnchor, constant: 96),
            bulletineButton.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 286),
            bulletineButton.widthAnchor.constraint(equalToConstant: 160), // 아이콘 크기 설정
            bulletineButton.heightAnchor.constraint(equalToConstant: 160) // 아이콘 크기 설정
        ])
    }
    
    @objc private func bulletineButtonTapped() {
        let postListVC = PostListViewController()
        let navigationController = UINavigationController(rootViewController: postListVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
}


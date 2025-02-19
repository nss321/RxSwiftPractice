//
//  DetaileViewController.swift
//  RxSwiftPractice
//
//  Created by BAE on 2/19/25.
//

import UIKit

import SnapKit

final class DetaileViewController: ViewController {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 48)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(person: Person) {
        self.nameLabel.text = person.name
        
        self.emailLabel.text = person.email
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func configView() {
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().multipliedBy(0.9)
            $0.horizontalEdges.lessThanOrEqualToSuperview().inset(40)
        }
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(nameLabel.snp.horizontalEdges)
        }
    }
    
}

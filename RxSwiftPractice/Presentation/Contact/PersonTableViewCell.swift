//
//  UserTableViewCell.swift
//  iOSAcademy-RxSwift
//
//  Created by Jack on 1/30/25.
//

import UIKit

import Kingfisher
import RxSwift
import RxCocoa
import SnapKit

protocol PersonTableViewCellDelegate {
    func pushDetailView()
}

final class PersonTableViewCell: UITableViewCell {
    
    static let identifier = "PersonTableViewCell"
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemMint
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    let detailButton: UIButton = {
        let button = UIButton()
        button.configuration = UIButton.Configuration.gray()
        button.configuration?.title = "더보기"
        button.isUserInteractionEnabled = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    private var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        profileImageView.image = nil
        usernameLabel.text = nil
    }
      
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    
    private func configure() {
        contentView.addSubview(usernameLabel)
        contentView.addSubview(profileImageView)
        contentView.addSubview(detailButton)
        
        profileImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(20)
            $0.size.equalTo(60)
        }
        
        usernameLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
            $0.trailing.equalTo(detailButton.snp.leading).offset(-8)
        }
        
        detailButton.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(32)
            $0.width.equalTo(72)
        }
    }
    
    // TODO: push를 Delegate로 넘기기
    func config(row: Person, vc: UIViewController) {
        profileImageView.kf.setImage(with: URL(string: row.profileImage))
        usernameLabel.text = row.name
        detailButton.rx.tap
            .bind(with: vc) { owner, _ in
                print(#function, "\(row.name) tapped", owner)
                let newVC = DetaileViewController(person: row)
                owner.navigationController?.pushViewController(newVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
}


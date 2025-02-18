//
//  SimpleValidationViewController.swift
//  RxSwiftPractice
//
//  Created by BAE on 2/18/25.
//

import UIKit

import RxSwift
import SnapKit

private let minLength = 5

final class SimpleValidationViewController: ViewController {
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.textColor = .label
        return label
    }()
    private let usernameTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "..."
        view.textColor = .label
        view.borderStyle = .line
        view.keyboardType = .default
        return view
    }()
    private let usernameValidation: UILabel = {
        let label = UILabel()
        label.text = "Validation"
        label.textColor = .systemRed
        return label
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textColor = .label
        return label
    }()
    private let passwordTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "..."
        view.textColor = .label
        view.borderStyle = .line
        view.keyboardType = .default
        return view
    }()
    private let passwordValidation: UILabel = {
        let label = UILabel()
        label.text = "Validation"
        label.textColor = .systemRed
        return label
    }()
    private let submitButton: UIButton = {
        let button = UIButton()
        button.configuration = UIButton.Configuration.filled()
        button.configuration?.title = "Submit"
        button.configuration?.baseBackgroundColor = .tintColor
        return button
    }()
    
    override func bind() {
        usernameValidation.text = "최소 \(minLength)글자 이상 입력해주세요."
        passwordValidation.text = "최소 \(minLength)글자 이상 입력해주세요."
        
        let usernameValid = usernameTextField.rx.text.orEmpty
            .map { $0.count >= minLength } // self 캡쳐 때문에 전역으로 뺀걸가나,,
            .share(replay: 1)
        
        let passwordValid = passwordTextField.rx.text.orEmpty
            .map { $0.count >= minLength }
            .share(replay: 1)
        
        let valid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        usernameValid
            .bind(to: passwordTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        usernameValid
            .bind(to: usernameValidation.rx.isHidden)
            .disposed(by: disposeBag)
        passwordValid
            .bind(to: passwordValidation.rx.isHidden)
            .disposed(by: disposeBag)
        valid
            .bind(to: submitButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        submitButton.rx.tap
            .bind { _ in
                AlertManager.showAlert(title: "Submit", message: "Your account is submitted.", completion: nil)
            }
            .disposed(by: disposeBag)
    }
    
    override func configView() {
        [
            usernameLabel,
            usernameTextField,
            usernameValidation,
            passwordLabel,
            passwordTextField,
            passwordValidation,
            submitButton,
        ].forEach { view.addSubview($0) }
        
        usernameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().multipliedBy(0.7)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(usernameLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalTo(usernameLabel.snp.horizontalEdges)
        }
        usernameValidation.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(12)
            $0.horizontalEdges.equalTo(usernameLabel.snp.horizontalEdges)
        }
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(usernameValidation.snp.bottom).offset(12)
            $0.horizontalEdges.equalTo(usernameLabel.snp.horizontalEdges)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalTo(usernameLabel.snp.horizontalEdges)
        }
        passwordValidation.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(12)
            $0.horizontalEdges.equalTo(usernameLabel.snp.horizontalEdges)
        }
        submitButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(40)
            $0.horizontalEdges.equalTo(usernameLabel.snp.horizontalEdges)
        }
    }
}

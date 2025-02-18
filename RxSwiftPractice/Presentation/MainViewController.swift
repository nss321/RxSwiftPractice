//
//  MainViewController.swift
//  RxSwiftPractice
//
//  Created by BAE on 2/18/25.
//

import UIKit

import RxSwift
import SnapKit

final class MainViewController: ViewController {
    
    private let simpleTableViewButton: UIButton = {
        let button = UIButton()
        button.configuration = UIButton.Configuration.filled()
        button.configuration?.title = "SimpleTableView"
        button.configuration?.baseBackgroundColor = .tintColor
        return button
    }()
    
    private let numbersViewButton: UIButton = {
        let button = UIButton()
        button.configuration = UIButton.Configuration.filled()
        button.configuration?.title = "NumbersView"
        button.configuration?.baseBackgroundColor = .tintColor
        return button
    }()
    
    private let simpleValidationViewButton: UIButton = {
        let button = UIButton()
        button.configuration = UIButton.Configuration.filled()
        button.configuration?.title = "SimpleValidationView"
        button.configuration?.baseBackgroundColor = .tintColor
        return button
    }()
    
    private let birthDayViewButton: UIButton = {
        let button = UIButton()
        button.configuration = UIButton.Configuration.filled()
        button.configuration?.title = "BirthDayView"
        button.configuration?.baseBackgroundColor = .tintColor
        return button
    }()
    
    override func bind() {
        simpleTableViewButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                print(#function, "next")
                owner.navigationController?.pushViewController(SimpleTableViewController(), animated: true)
            }, onError: { owner, error in
                print(#function, error)
            }, onCompleted: { owner in
                print(#function, "onCompleted")
            }, onDisposed: { owner in
                print(#function, "onDisposed")
            })
            .disposed(by: disposeBag)
        numbersViewButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(NumbersViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        simpleValidationViewButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(SimpleValidationViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        birthDayViewButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(BirthDayViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    override func configView() {
        [
            simpleTableViewButton,
            numbersViewButton,
            simpleValidationViewButton,
            birthDayViewButton
        ].forEach { view.addSubview($0) }
        
        simpleTableViewButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.8)
        }
        numbersViewButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.9)
        }
        simpleValidationViewButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(1)
        }
        birthDayViewButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(1.1)
        }
    }
}

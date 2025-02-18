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
        button.rx.base.configuration = UIButton.Configuration.filled()
        button.rx.base.configuration?.title = "SimpleTableView"
        button.rx.base.configuration?.baseBackgroundColor = .tintColor
        return button
    }()
    
    private let numbersViewButton: UIButton = {
        let button = UIButton()
        button.rx.base.configuration = UIButton.Configuration.filled()
        button.rx.base.configuration?.title = "NumbersView"
        button.rx.base.configuration?.baseBackgroundColor = .tintColor
        return button
    }()
    
    private let simpleValidationViewButton: UIButton = {
        let button = UIButton()
        button.rx.base.configuration = UIButton.Configuration.filled()
        button.rx.base.configuration?.title = "SimpleValidationView"
        button.rx.base.configuration?.baseBackgroundColor = .tintColor
        return button
    }()
    
    private let birthDayViewButton: UIButton = {
        let button = UIButton()
        button.rx.base.configuration = UIButton.Configuration.filled()
        button.rx.base.configuration?.title = "BirthDayView"
        button.rx.base.configuration?.baseBackgroundColor = .tintColor
        return button
    }()
    
    
    
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

//
//  NumbersViewController.swift
//  RxSwiftPractice
//
//  Created by BAE on 2/18/25.
//

import UIKit

import RxSwift
import SnapKit

final class NumbersViewController: ViewController {
    
    private let firstOperand: UITextField = {
        let view = UITextField()
        view.placeholder = "..."
        view.textColor = .label
        view.borderStyle = .line
        view.keyboardType = .numberPad
        view.textAlignment = .right
        return view
    }()
    private let secondOperand: UITextField = {
        let view = UITextField()
        view.placeholder = "..."
        view.textColor = .label
        view.borderStyle = .line
        view.keyboardType = .numberPad
        view.returnKeyType = .done
        view.textAlignment = .right
        return view
    }()
    private let thirdOperand: UITextField = {
        let view = UITextField()
        view.placeholder = "..."
        view.textColor = .label
        view.borderStyle = .line
        view.keyboardType = .numberPad
        view.returnKeyType = .done
        view.textAlignment = .right
        return view
    }()
    
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .label
        return view
    }()
    
    private let plusLabel: UILabel = {
        let label = UILabel()
        label.text = "+"
        label.textColor = .label
        return label
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "result here"
        label.textColor = .label
        return label
    }()
    
    override func bind() {
        Observable.combineLatest(
            firstOperand.rx.text.orEmpty,
            secondOperand.rx.text.orEmpty,
            thirdOperand.rx.text.orEmpty
        ) { first, second, third -> Int in
            return (Int(first) ?? 0) + (Int(second) ?? 0) + (Int(third) ?? 0)
        }
        .map { $0.description }
        .bind(to: resultLabel.rx.text)
        .disposed(by: disposeBag)
    }
    
    override func configView() {
        [
            firstOperand,
            secondOperand,
            thirdOperand,
            separator,
            plusLabel,
            resultLabel
            
        ].forEach { view.addSubview($0) }
        
        firstOperand.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.8)
            $0.width.equalTo(100)
        }
        secondOperand.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(firstOperand.snp.bottom).offset(16)
            $0.width.equalTo(100)
        }
        thirdOperand.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(secondOperand.snp.bottom).offset(16)
            $0.width.equalTo(100)
        }
        separator.snp.makeConstraints {
            $0.top.equalTo(thirdOperand.snp.bottom).offset(16)
            $0.leading.equalTo(plusLabel.snp.leading)
            $0.trailing.equalTo(thirdOperand.snp.trailing)
            $0.height.equalTo(1)
        }
        plusLabel.snp.makeConstraints {
            $0.centerY.equalTo(thirdOperand.snp.centerY)
            $0.trailing.equalTo(thirdOperand.snp.leading).offset(-16)
        }
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom).offset(16)
            $0.trailing.equalTo(separator.snp.trailing)
        }
        
    }
    
}

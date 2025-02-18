//
//  BirthDayViewController.swift
//  RxSwiftPractice
//
//  Created by BAE on 2/18/25.
//

import UIKit

import RxSwift
import SnapKit

final class BirthDayViewController: ViewController {
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        return picker
    }()
    
    private let selectedDateLabel: UILabel = {
        let label = UILabel()
        label.text = "날짜를 선택해주세요."
        label.textColor = .label
        return label
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "y년 M월 d일"
        return formatter
    }()
    
    override func bind() {
        datePicker.rx.date
            .map { [weak self] date in
                self?.dateFormatter.string(from: date) ?? ""
            }
            .bind(to: selectedDateLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    override func configView() {
        [datePicker, selectedDateLabel].forEach { view.addSubview($0) }
        
        datePicker.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        selectedDateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(datePicker.snp.bottom).offset(16)
        }
    }
}

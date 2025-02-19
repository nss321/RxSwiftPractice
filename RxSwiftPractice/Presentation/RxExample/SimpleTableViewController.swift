//
//  SimpleTableViewController.swift
//  RxSwiftPractice
//
//  Created by BAE on 2/18/25.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

final class SimpleTableViewController: ViewController {
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(SimpleTableViewCell.self, forCellReuseIdentifier: SimpleTableViewCell.id)
        return view
    }()
    
    override func bind() {
        let items = Observable.just(
            (0..<20).map { String($0) }
        )
        
        //        items
        //            .bind(to: tableView.rx.items(cellIdentifier: <#T##String#>, cellType: <#T##UITableViewCell.Type#>))  { <#Int#>, <#String#>, <#UITableViewCell#> in
        //                <#code#>
        //            }
        items
            .bind(to: tableView.rx.items(cellIdentifier: SimpleTableViewCell.id, cellType: SimpleTableViewCell.self)) { (row, element, cell) in
                cell.config(row: "\(element) @ row \(row)")
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(String.self)
            .subscribe(with: self) { owner, value in
                print(#function, "\(value) tapped")
                AlertManager.showAlert(title: "Cell Tapped", message: "\(value) tapped", completion: nil)
            } onError: { owner, error in
                print(#function, error)
            } onCompleted: { owner in
                print(#function, "onCompleted")
            } onDisposed: { owner in
                print(#function, "onDisposed")
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe { indexPath in
                print(#function, "tapped detail @ \(indexPath.section), \(indexPath.row)")
                AlertManager.showAlert(title: "Accessoty Tapped", message: " \(indexPath.section), \(indexPath.row) tapped", completion: nil)
            }
            .disposed(by: disposeBag)
    }
    
    override func configView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

final class SimpleTableViewCell: UITableViewCell {
    
    static let id = "SimpleTableViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        accessoryType = .detailButton
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.addSubview(label)
        
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func config(row: String) {
        label.text = row
    }
}

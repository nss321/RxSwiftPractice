//
//  ContactViewController.swift
//  RxSwiftPractice
//
//  Created by BAE on 2/19/25.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

final class ContactViewController: ViewController {
    
    private let tableView = UITableView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    private let searchBar = UISearchBar()

    private let viewModel = ContactViewModel()
    
    override func bind() {
        let input = ContactViewModel.Input(
            selectTableViewItem: tableView.rx.itemSelected,
            selectCollectionViewItem: collectionView.rx.itemSelected,
            searchKeyword: searchBar.rx.text
        )
        
        _ = viewModel.transform(input: input)
        
        viewModel.tableViewItems
            .bind(to: tableView.rx.items(cellIdentifier: PersonTableViewCell.identifier, cellType: PersonTableViewCell.self))  { row, element, cell in
                cell.config(row: element, vc: self)
            }
            .disposed(by: disposeBag)
        
        viewModel.collectionViewItems
            .bind(to: collectionView.rx.items(cellIdentifier: UserCollectionViewCell.identifier, cellType: UserCollectionViewCell.self))  { row, element, cell in
                cell.config(row: element)
            }
            .disposed(by: disposeBag)
        
    }
    
    override func configView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        
        navigationItem.titleView = searchBar
         
        collectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: UserCollectionViewCell.identifier)
        collectionView.backgroundColor = .lightGray
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.identifier)
        tableView.backgroundColor = .systemGreen
        tableView.rowHeight = 100
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension ContactViewController {
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }
}
 

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
     
    private lazy var tableViewItems = BehaviorSubject(value: sampleUsers)
    private let collectionViewItems = PublishSubject<[Person]>()
    private var collectionViewData: [Person] = []
    
    override func bind() {
        tableViewItems
            .bind(to: tableView.rx.items(cellIdentifier: PersonTableViewCell.identifier, cellType: PersonTableViewCell.self))  { row, element, cell in
                cell.config(row: element, vc: self)
            }
            .disposed(by: disposeBag)
        
        collectionViewItems
            .bind(to: collectionView.rx.items(cellIdentifier: UserCollectionViewCell.identifier, cellType: UserCollectionViewCell.self))  { row, element, cell in
                cell.config(row: element)
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .itemSelected
            .bind(with: self) { owner, indexPath in
                do {
                    try
                    owner.collectionViewData.append(owner.tableViewItems.value()[indexPath.item])
                } catch {
                    AlertManager.showNotiAlert(title: "유저를 찾을 수 없음", message: "선택한 유저를 찾을 수 없습니다.")
                }
                owner.collectionViewItems.onNext(owner.collectionViewData)
            }
            .disposed(by: disposeBag)
        
        collectionView.rx
            .itemSelected
            .bind(with: self) { owner, indexPath in
                let item = indexPath.item
                AlertManager.showAlert(title: "선택된 유저 삭제", message: "\(owner.collectionViewData[item].name)를(을) 삭제하시겠습니까?") { _ in
                    owner.collectionViewData.remove(at: item)
                    owner.collectionViewItems.onNext(owner.collectionViewData)
                }
            }
            .disposed(by: disposeBag)
        
        searchBar.rx.text
            .orEmpty
            .debounce(RxTimeInterval.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .distinctUntilChanged()
            .bind(with: self) { owner, keyword in
                print(#function, keyword)
                
                owner.tableViewItems.onNext(
                    keyword.isEmpty ? sampleUsers : sampleUsers.filter {
                        $0.name.lowercased().contains(keyword.lowercased())
                    }   
                )
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
    
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }

}
 

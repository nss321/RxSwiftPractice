//
//  ContactViewModel.swift
//  RxSwiftPractice
//
//  Created by BAE on 2/19/25.
//

import Foundation
import RxSwift
import RxCocoa

final class ContactViewModel: ViewModel {
    
    private let disposeBag = DisposeBag()
    lazy var tableViewItems = BehaviorSubject(value: sampleUsers)
    let collectionViewItems = PublishSubject<[Person]>()
    var collectionViewData: [Person] = []
    
    struct Input {
        let selectTableViewItem: ControlEvent<IndexPath>
        let selectCollectionViewItem: ControlEvent<IndexPath>
        let searchKeyword: ControlProperty<String?>
    }
    
    struct Output {
        
    }
    
    init() {
        
    }
    
    func transform(input: Input) -> Output {
        input.selectTableViewItem
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
        
        input.selectCollectionViewItem
            .bind(with: self) { owner, indexPath in
                let item = indexPath.item
                AlertManager.showAlert(title: "선택된 유저 삭제", message: "\(owner.collectionViewData[item].name)를(을) 삭제하시겠습니까?") { _ in
                    owner.collectionViewData.remove(at: item)
                    owner.collectionViewItems.onNext(owner.collectionViewData)
                }
            }
            .disposed(by: disposeBag)
        
        input.searchKeyword.orEmpty
            .debounce(RxTimeInterval.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .distinctUntilChanged()
            .bind(with: self) { owner, keyword in
                owner.tableViewItems.onNext(
                    keyword.isEmpty ? sampleUsers : sampleUsers.filter {
                        $0.name.lowercased().contains(keyword.lowercased())
                    }
                )
            }
            .disposed(by: disposeBag)
        
        return Output(
            
        )
    }
    
}

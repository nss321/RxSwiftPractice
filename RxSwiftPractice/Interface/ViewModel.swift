//
//  ViewModel.swift
//  RxSwiftPractice
//
//  Created by BAE on 2/19/25.
//

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

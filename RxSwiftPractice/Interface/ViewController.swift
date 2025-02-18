//
//  ViewController.swift
//  RxSwiftPractice
//
//  Created by BAE on 2/18/25.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        configView()
        view.backgroundColor = .systemBackground
    }
    
    func configView() { }
    
    func bind() { }
}

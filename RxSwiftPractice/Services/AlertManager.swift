//
//  DefaultWirefram.swift
//  RxSwiftPractice
//
//  Created by BAE on 2/18/25.
//

import UIKit

final class AlertManager {
    static let shared = AlertManager()
    
    private static func root() -> UIViewController {
        UIApplication.shared.keyWindow!.rootViewController!
    }
    
    static func showAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: completion)
        alert.addAction(ok)
        root().present(alert, animated: true)
        
    }
}

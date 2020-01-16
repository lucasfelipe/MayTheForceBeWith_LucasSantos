//
//  ViewControllerExtension.swift
//  MayTheForceBeWith_LucasSantos
//
//  Created by Lucas  Felipe on 14/01/2020.
//  Copyright © 2020 Lucas  Felipe. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

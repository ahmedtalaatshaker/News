//
//  BaseViewController.swift
//  News
//
//  Created by Ahmed Talaat on 04/11/2022.
//

import Foundation
import UIKit

class BaseViewController :UIViewController{
    func alert(message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}

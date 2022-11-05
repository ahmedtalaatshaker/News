//
//  ViewController.swift
//  News
//
//  Created by Ahmed Talaat on 04/11/2022.
//

import UIKit

class ViewController: UIViewController {

    let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if viewModel.userSavedSelection != nil {
            navigateToHome()
        }else{
            navigateToOnBoarding()
        }
    }
    
    private func navigateToHome(){
        performSegue(withIdentifier: "home", sender: self)
    }

    private func navigateToOnBoarding(){
        performSegue(withIdentifier: "onBoarding", sender: self)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "home" {
            if segue.destination is HomeScreenViewController {
                let vc = segue.destination as? HomeScreenViewController
                vc?.userSelection = viewModel.userSavedSelection!
            }
        }
    }
}


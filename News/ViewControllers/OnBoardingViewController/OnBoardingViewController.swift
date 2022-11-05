//
//  OnBoardingViewController.swift
//  News
//
//  Created by Ahmed Talaat on 04/11/2022.
//

import UIKit

class OnBoardingViewController: UIViewController {

    @IBOutlet weak var countriesStackView: UIStackView!
    @IBOutlet weak var categoriesStackView: UIStackView!
    @IBOutlet weak var continueButton: UIButton!
        
    var selectedCountry = ""
    var selectedCategories: [String] = []
    let viewModel = OnBoardingViewModel ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setContinueButtonUI()
        setCountries()
        setCategories()
    }
    
    private func setContinueButtonUI() {
        continueButton.layer.borderWidth = 1
        continueButton.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        continueButton.layer.cornerRadius = 10
    }

    private func setCountries(){
        viewModel.counties.forEach { country in
            let selecteView =  SelectionView()
            selecteView.setData(text: country, isSelected: false, selectionType: .single)
            selecteView.delegate = self
            countriesStackView.addArrangedSubview(selecteView)
        }
    }
    
    private func setCategories() {
        viewModel.categories.forEach { category in
            let selecteView =  SelectionView()
            selecteView.setData(text: category, isSelected: false, selectionType: .multi)
            selecteView.delegate = self
            categoriesStackView.addArrangedSubview(selecteView)
        }
    }
    
    func enableContinueButton() {
        continueButton.isEnabled = selectedCountry != "" && !selectedCategories.isEmpty
    }
    
    @IBAction func `continue`(_ sender: Any) {
        viewModel.saveUserSelection(country: selectedCountry, categories: selectedCategories)
        navigateToHome()
    }
    
    private func navigateToHome(){
        performSegue(withIdentifier: "home", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "home" {
            if segue.destination is HomeScreenViewController {
                let vc = segue.destination as? HomeScreenViewController
                vc?.userSelection = UserSelections(selectedCountry, selectedCategories.joined(separator: ","))
            }
        }
    }
}


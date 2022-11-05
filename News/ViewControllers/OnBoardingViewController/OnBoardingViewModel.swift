//
//  OnBoardingViewModel.swift
//  News
//
//  Created by Ahmed Talaat on 04/11/2022.
//

import Foundation
class OnBoardingViewModel {
    let counties = ["us","ae","ar","at","au","be","bg","br","ca","ch","cn","co","cu","cz","de","eg","fr"]
    
    let categories = ["business","entertainment","general","health","science","sports","technology"]

    func saveUserSelection(country: String, categories: [String]) {
        let userSelection = UserSelections(country, categories.joined(separator: ","))
        SaveData.saveData.saveUserSelections(userSelection)
    }
}

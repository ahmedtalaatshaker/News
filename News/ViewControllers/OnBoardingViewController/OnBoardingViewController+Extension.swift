//
//  OnBoardingViewController+Extension.swift
//  News
//
//  Created by Ahmed Talaat on 04/11/2022.
//

import Foundation
extension OnBoardingViewController: SelectionViewProtocol {
    func select(_ selectionView: SelectionView) {
        switch selectionView.selectionType {
        case .single:
            countriesStackView.subviews.forEach { view in
                guard let view = view as? SelectionView,
                          view != selectionView else { return }
                view.setSelected(select: false, selectionType: .single)
            }
            
            selectedCountry = selectionView.isSelected ? "" : selectionView.title.text ?? ""
        case .multi:
            if selectionView.isSelected {
                selectedCategories.removeAll(where: {$0 == selectionView.title.text ?? ""})
            }else{
                selectedCategories.append(selectionView.title.text ?? "")
            }
        }

        selectionView.setSelected(select: !selectionView.isSelected, selectionType: selectionView.selectionType)
        enableContinueButton()
    }
}

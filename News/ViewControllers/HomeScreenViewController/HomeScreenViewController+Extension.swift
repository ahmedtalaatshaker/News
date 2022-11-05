//
//  HomeScreenViewController+Extension.swift
//  News
//
//  Created by Ahmed Talaat on 04/11/2022.
//

import UIKit

extension HomeScreenViewController: NewsViewProtocol{
    func viewDetails(_ newsView: NewsView) {
        navigateToDetailsScreenWith(newsView.article)
    }
}

extension HomeScreenViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return false
        }
        searchForNews(query: text)
        searchTextView.resignFirstResponder()
        return true
    }
    
    private func searchForNews(query: String) {
        viewModel.searchForNews(query: query) { [weak self] newsDTO in
            guard let self = self else { return }
            self.setNewsView(articles: newsDTO.articles)
        } errorMsg: { [weak self] msg in
            guard let self = self else { return }
            self.alert(message: msg, viewController: self)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        var newString = text + string
        if string == "" {
            newString.removeLast()
        }
        if newString == "" {
            setNewsView(articles: articles ?? [])
        }
        return true
    }
}

//
//  HomeScreenViewController.swift
//  News
//
//  Created by Ahmed Talaat on 04/11/2022.
//

import UIKit

class HomeScreenViewController: BaseViewController {

    @IBOutlet weak var searchTextView: UITextField!
    @IBOutlet weak var newsStack: UIStackView!
    var userSelection = UserSelections()
    var viewModel = HomeScreenViewModel()
    var articles: [Article]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextView.delegate = self
        getNews()
    }
    
    private func getNews() {
        viewModel.getNewsData(userSelection: userSelection) { [weak self] newsDTO in
            guard let self = self else { return }
            self.setNews(articles: newsDTO.articles)
        } errorMsg: { [weak self] error in
            guard let self = self else { return }
            self.alert(message: error, viewController: self)
        }
    }
    
    private func setNews(articles: [Article]) {
        self.articles = articles
        self.setNewsView(articles: articles)
    }
    
    private func clearStack() {
        newsStack.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }
    }
    
    func setNewsView(articles: [Article]) {
        clearStack()
        articles.forEach { article in
            let newsView = NewsView()
            newsView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
            newsView.heightAnchor.constraint(equalToConstant: 100).isActive = true

            newsView.setData(news: article)
            newsView.delegate = self
            newsStack.addArrangedSubview(newsView)
        }
    }
    
    func navigateToDetailsScreenWith(_ article: Article) {
        let detailsVC = UIStoryboard(name: "NewsDetailsViewController", bundle: nil).instantiateViewController(identifier: "NewsDetailsViewController") as! NewsDetailsViewController
        detailsVC.article = article
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchTextView.resignFirstResponder()
    }
}


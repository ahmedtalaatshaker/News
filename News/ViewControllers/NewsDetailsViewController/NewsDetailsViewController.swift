//
//  NewsDetailsViewController.swift
//  News
//
//  Created by Ahmed Talaat on 04/11/2022.
//

import UIKit
import Kingfisher

class NewsDetailsViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var newsDescription: UILabel!

    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNewsData()
    }
    
    private func setNewsData() {
        image.kf.setImage(with: URL(string: article?.urlToImage ?? ""),placeholder: UIImage(named: "newspaper"))
        newsTitle.text = article?.title
        author.text = article?.author
        source.text = article?.source.name
        newsDescription.text = article?.content
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func openSafari(_ sender: Any) {
        if let url = URL(string: article?.url ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    
    
}

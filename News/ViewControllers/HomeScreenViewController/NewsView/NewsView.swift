//
//  NewsView.swift
//  News
//
//  Created by Ahmed Talaat on 04/11/2022.
//

import UIKit
import Kingfisher

protocol NewsViewProtocol {
    func viewDetails(_ newsView: NewsView)
}

class NewsView: UIView {

    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var delegate: NewsViewProtocol?
    var article: Article!
    
    func setData(news: Article){
        article = news
        newsDescription.text = news.title
        image.kf.setImage(with: URL(string: news.urlToImage ?? ""),placeholder: UIImage(named: "newspaper"))
    }
    
    @IBAction func selectNews(_ sender: Any) {
        delegate?.viewDetails(self)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    func commonInit() {
        
        guard let view = Bundle(for: type(of: self)).loadNibNamed("NewsView", owner: self, options: nil)?.first as? UIView else {
            return
        }
        
        frame = view.bounds
        
        self.addSubview(view)
        setupUI()
    }
    
    func setupUI() {
        self.layer.borderWidth = 1
        self.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.cornerRadius = 15
        
    }

}

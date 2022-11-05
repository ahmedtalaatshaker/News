//
//  NewsObject.swift
//  News
//
//  Created by Ahmed Talaat on 05/11/2022.
//

import RealmSwift

class NewsDTO_DB: Object {
    static var newsDTO_DB = NewsDTO_DB()
    
    @objc dynamic var status = ""
    @objc dynamic var totalResults = 0
    var articles = List<ArticleDTO_DB>()
}

class ArticleDTO_DB: Object {
    @objc dynamic var author: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var articleDescription: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var urlToImage: String = ""
    @objc dynamic var publishedAt: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var source: SourceDTO_DB? = nil
}

class SourceDTO_DB: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
}

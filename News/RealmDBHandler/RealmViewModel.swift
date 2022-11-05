//
//  RealmViewModel.swift
//  News
//
//  Created by Ahmed Talaat on 05/11/2022.
//

import RealmSwift
protocol RealmViewModelProtocol {
    func addToDB(_ news: NewsDTO) -> Bool
    func getAllNews() -> NewsDTO?
    func removeAllNews() -> Bool
}

class RealmViewModel: RealmViewModelProtocol{
    static var shared = RealmViewModel()

    func addToDB(_ news: NewsDTO) -> Bool {
        RealmDB.shared.addToDB(NewsDTO_NewsDTO_DB_Transformer.shared.transforNewsDTO(news))
    }
    
    func getAllNews() -> NewsDTO? {
        return NewsDTO_NewsDTO_DB_Transformer.shared.transforNewsDTO_DB(RealmDB.shared.getAllNews())
    }
    
    func removeAllNews() -> Bool{
        RealmDB.shared.removeAllNews()
    }
}

class NewsDTO_NewsDTO_DB_Transformer {
    static var shared = NewsDTO_NewsDTO_DB_Transformer()
    
    func transforNewsDTO(_ news: NewsDTO) -> NewsDTO_DB {
        let newsDTO_DB = NewsDTO_DB()
        newsDTO_DB.status = news.status
        newsDTO_DB.totalResults = news.totalResults
        
        let articles = List<ArticleDTO_DB>()
        news.articles.forEach { article in
            let articleDTO_DB = ArticleDTO_DB()
            articleDTO_DB.title = article.title
            articleDTO_DB.author = article.author ?? ""
            articleDTO_DB.articleDescription = article.articleDescription ?? ""
            articleDTO_DB.url = article.url
            articleDTO_DB.urlToImage = article.urlToImage ?? ""
            articleDTO_DB.publishedAt = article.publishedAt
            articleDTO_DB.content = article.content ?? ""
            let source = SourceDTO_DB()
            source.name = article.source.name
            source.id = article.source.id ?? ""
            articles.append(articleDTO_DB)
        }
        newsDTO_DB.articles = articles

        
        return newsDTO_DB
    }
    
    func transforNewsDTO_DB(_ news: NewsDTO_DB?) -> NewsDTO? {
        guard let news = news else { return nil}
        var articles = [Article]()
        news.articles.forEach { article in
            let articleDTO = Article(source: Source(id: article.source?.id, name: article.source?.name ?? ""),
                                     author: article.author ,
                                     title: article.title,
                                     articleDescription: article.articleDescription ,
                                     url: article.url,
                                     urlToImage: article.urlToImage ,
                                     publishedAt: article.publishedAt,
                                     content: article.content )

            articles.append(articleDTO)
        }
        let newsDTO = NewsDTO(status: news.status, totalResults: news.totalResults, articles: articles)
        return newsDTO
    }

}

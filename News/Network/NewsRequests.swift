//
//  NewsRequests.swift
//  News
//
//  Created by Ahmed Talaat on 04/11/2022.
//

import Foundation

enum ApiRequestsUrls: String {
    case baseUrl = "https://newsapi.org/v2/"
    case topHeadlines = "top-headlines"
    case everything = "everything"
    case apiKey = "67c75a6c107a41f09881a115dab5db68"
}

class NewsRequests :PObject{
    @objc static let shared = NewsRequests()

    func getNews(country:String,
                 category:String,
                  success:@escaping(NewsDTO) -> Void,
                  failure:@escaping([String:Any]) -> Void){
        
        let url = "\(ApiRequestsUrls.baseUrl.rawValue)\(ApiRequestsUrls.topHeadlines.rawValue)?country=\(country)&category=\(category.replacingOccurrences(of: ",", with: "&"))&apiKey=\(ApiRequestsUrls.apiKey.rawValue)"

        Network.shared.serverRequests(url: url,method: .get) { (respo) in
            success(respo)
        } failure: { (error) in
            failure(error)
        }

    }
    
    func searchForNews(query:String,
                  success:@escaping(NewsDTO) -> Void,
                  failure:@escaping([String:Any]) -> Void){

        let url = "\(ApiRequestsUrls.baseUrl.rawValue)\(ApiRequestsUrls.everything.rawValue)?q=\(query)&from=2022-10-30&sortBy=publishedAt&apiKey=\(ApiRequestsUrls.apiKey.rawValue)"

        Network.shared.serverRequests(url: url,method: .get) { (respo) in
            success(respo)
        } failure: { (error) in
            failure(error)
        }

    }

}

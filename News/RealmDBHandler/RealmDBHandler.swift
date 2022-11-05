//
//  RealmDBHandler.swift
//  News
//
//  Created by Ahmed Talaat on 05/11/2022.
//

import RealmSwift
protocol RealmProtocol {
    func addToDB(_ news: NewsDTO_DB) -> Bool
    func getAllNews() -> NewsDTO_DB?
    func removeAllNews() -> Bool
}

class RealmDB: RealmProtocol {
    static var shared = RealmDB()
    let realm = try! Realm()

    func getAllNews() -> NewsDTO_DB?{
        let data = realm.objects(NewsDTO_DB.self)
        var news = [NewsDTO_DB]()
        
        for row in data{
            news.append(row)
        }
        return news.first
    }
    
    func addToDB(_ news: NewsDTO_DB) -> Bool{
        guard let realm = try? Realm() else { return false }
        return try! realm.write({ () -> Bool in
            realm.add(news)
            return true
        })
    }
    
    func removeAllNews() -> Bool{
        let data = realm.objects(NewsDTO_DB.self)
        for row in data {
            return try! realm.write({ () -> Bool in
                realm.delete(row)
                return true
            })
        }
        return false
    }
}

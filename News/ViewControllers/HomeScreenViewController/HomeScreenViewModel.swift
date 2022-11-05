//
//  HomeScreenViewModel.swift
//  News
//
//  Created by Ahmed Talaat on 04/11/2022.
//

import Foundation

class HomeScreenViewModel {
    private let _30Mins: Int64 = 1_800_000
    private lazy var _1Min: Int64 = _30Mins / 30
    
    func getNewsData(userSelection: UserSelections,
                     newsData: @escaping (NewsDTO) -> Void,
                     errorMsg: @escaping (String) -> Void) {
        
        let lastRequestDate = getLastRequestDate()
        let date = Date().millisecondsSince1970

        if lastRequestDate != 0 {
            if date > lastRequestDate + _30Mins {
                saveLastRequestDate(dateMS: date)

                getNewsFromServer(userSelection: userSelection) { newsDTO in
                    newsData(newsDTO)
                } errorMsg: { error in
                    errorMsg(error)
                }
            }else{
                let NewsDataFromDB = getNewsFromDB()
                if NewsDataFromDB != nil {
                    newsData(NewsDataFromDB!)
                }else{
                    getNewsFromServer(userSelection: userSelection) { newsDTO in
                        newsData(newsDTO)
                    } errorMsg: { error in
                        errorMsg(error)
                    }
                }
            }
        }else{
            saveLastRequestDate(dateMS: date)

            getNewsFromServer(userSelection: userSelection) { newsDTO in
                newsData(newsDTO)
            } errorMsg: { error in
                errorMsg(error)
            }
        }

    }
    
    private func getNewsFromServer(userSelection: UserSelections,
                 newsData: @escaping (NewsDTO) -> Void,
                 errorMsg: @escaping (String) -> Void) {
        NewsRequests.shared.getNews(country: userSelection.country, category: userSelection.categories) { newsDTO in
            self.saveNewsToDB(newsDTO: newsDTO)
            newsData(newsDTO)
        } failure: { error in
            errorMsg(error["message"] as! String)
        }
    }
    
    func searchForNews(query: String,
                       newsData: @escaping (NewsDTO) -> Void,
                       errorMsg: @escaping (String) -> Void) {
        NewsRequests.shared.searchForNews(query: query) { newsDTO in
            newsData(newsDTO)
        } failure: { error in
            errorMsg(error["message"] as! String)
        }
    }
    
    private func saveLastRequestDate(dateMS: Int64) {
        SaveData.saveData.saveLastRequestDate(dateMS: dateMS)
    }
    
    private func getLastRequestDate() -> Int64{
        SaveData.saveData.getLastRequestDate()
    }
    
    private func getNewsFromDB() -> NewsDTO? {
        return RealmViewModel.shared.getAllNews() ?? nil
    }
    
    private private func saveNewsToDB(newsDTO: NewsDTO) -> Bool {
        RealmViewModel.shared.removeAllNews()
        return RealmViewModel.shared.addToDB(newsDTO)
    }
    
}

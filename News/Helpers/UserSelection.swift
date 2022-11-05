//
//  UserSelection.swift
//  News
//
//  Created by Ahmed Talaat on 04/11/2022.
//

import Foundation

class UserSelections: NSObject, NSCoding{
    
    static let userSelections = UserSelections()
    var country: String
    var categories: String
    let userSelectionKey = "userSelectionKey"
        
    init(_ country: String = "", _ categories: String = ""){
        self.country = country
        self.categories = categories
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(country, forKey: "country")
        coder.encode(categories, forKey: "categories")
    }
    
    required init?(coder: NSCoder) {
        country = coder.decodeObject(forKey: "country") as! String
        categories = coder.decodeObject(forKey: "categories") as! String
    }
}

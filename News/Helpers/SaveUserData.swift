//
//  SaveUserData.swift
//  News
//
//  Created by Ahmed Talaat on 04/11/2022.
//

import Foundation

class SaveData{
    static var saveData = SaveData()
    
    func saveUserSelections(_ userSelections: UserSelections){
        let archivedObject = NSKeyedArchiver.archivedData(withRootObject: userSelections as UserSelections)
        UserDefaults.standard.set(archivedObject, forKey: userSelections.userSelectionKey)
        UserDefaults.standard.synchronize()
    }
    
    func getUserSelections() -> UserSelections?{
        let data = UserDefaults.standard.object(forKey: UserSelections.userSelections.userSelectionKey)
        return NSKeyedUnarchiver.unarchiveObject(with: data as? Data ?? Data()) as? UserSelections
    }
    
    func saveLastRequestDate(dateMS: Int64) {
        UserDefaults.standard.set(dateMS, forKey: "dateTime")
        UserDefaults.standard.synchronize()
    }
    
    func getLastRequestDate() -> Int64{
        return Int64(UserDefaults.standard.integer(forKey: "dateTime"))
    }
}

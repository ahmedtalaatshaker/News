//
//  Network.swift
//  News
//
//  Created by Ahmed Talaat on 04/11/2022.
//

import Foundation

import Foundation
import Alamofire


class Network: PObject {
    
    @objc static let shared = Network()
    
    func serverRequests<T: Decodable>(url :String,
                        method :Alamofire.HTTPMethod = .get,
                        success:@escaping (T) -> Void,
                        failure:@escaping ([String:Any]) -> Void ) {
        print(url)
        let RequestURL = URL(string: url.replacingOccurrences(of: " ", with: "%20"))

        var request = URLRequest(url: RequestURL!)
        request.httpMethod = method.rawValue
        
        Alamofire.AF.request(request).responseData{ response in

            
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do {
                    guard let newsDTO = try? JSONDecoder().decode(T.self, from: response.data!) else {
                        failure(["message":"Failed to parse json"])
                        return
                    }
                    success(newsDTO)
                }
            }else{
                do {
                    let readableJson = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments)
                    if let respoDict = readableJson as? [String:Any] {
                        failure(respoDict)
                    }
                }catch {
                    failure(["message":"Please Check your internet connection!"])
                }
            }
        }
    }
    
    
}

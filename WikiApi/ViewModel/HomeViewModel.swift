//
//  HomeViewModel.swift
//  WikiApi
//
//  Created by Amanpreet Singh on 31/05/23.
//

import Foundation

class HomeViewModel: NSObject
{
    //MARK: Hit Wiki Api
    func hitApi(searchedText: String, completion:@escaping (Query?) -> ()) {
        guard let url = URL(string: "https://en.wikipedia.org/w/api.php?format=json&action=query&generator=search&gsrnamespace=0&gsrsearch=\(searchedText)&gsrlimit=10&prop=pageimages%7Cextracts&pilimit=max&exintro&explaintext&exsentences=1&exlimit=max") else {
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            DispatchQueue.main.async {
                let httpResponse = response as? HTTPURLResponse
                let welcome = try? JSONDecoder().decode(Welcome.self, from: data!)
                completion(welcome?.query)
               
            }
            if error != nil{
                completion(nil)
            }
        }.resume()
    }
}

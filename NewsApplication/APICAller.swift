//
//  APICAller.swift
//  NewsApplication
//
//  Created by Daniils Aleksasins
//

import Foundation

/*
 Class which is used to get data from the news API to application
 */
final class APICaller {
    static let shared = APICaller()

    //Class initalizer
    private init(){
        
    }
    
    /*
        Functions that is making an API call and decodes the result according to the models parametrs
     */
    func fetchData(completionHandler: @escaping ([Article]) -> Void) {
        
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=gaming&from=2021-06-16&sortBy=popularity&language=en&apiKey=d2f4a7ff6cf842e18432affec255bc40") else { return };
        
         URLSession.shared.dataTask(with: url) { (data, response, error) in
                
            guard let data = data else { return }
            
            do {
                let postsData = try JSONDecoder().decode(APIRespones.self, from: data)
                    
                completionHandler(postsData.articles)
            }
            catch {
                let error = error
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}

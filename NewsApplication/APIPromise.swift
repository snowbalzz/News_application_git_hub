//
//  APIPromise.swift
//  NewsApplication
//
//  Created by Daniils Aleksasins on 19/06/2021.
//

import Foundation

//Models

//Articles
struct APIRespones: Codable{
    let articles: [Article]
}
//Content of the articles form the API response json
struct Article: Codable {
    let title: String
    let description: String
    let url: String
    let urlToImage: String
}

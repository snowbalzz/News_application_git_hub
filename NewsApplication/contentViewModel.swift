//
//  contentViewModel.swift
//  NewsApplication
//
//  Created by Daniils Aleksasins on 19/06/2021.
//

import Foundation

class cellContentModel {
    let newsTitle: String
    let newsDescription: String
    let image: URL?
    
    init(
        title: String,
        subtitle: String,
        imageURL: URL?
    ) {
        self.newsTitle = title
        self.newsDescription = subtitle
        self.image = imageURL
    }
}

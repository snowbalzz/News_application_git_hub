//
//  NewsTableViewCell.swift
//  NewsApplication
//
//  Created by Daniils Aleksasins on 16/06/2021.
//

import UIKit

class tabelCell: UITableViewCell {
    
    static let identifier = "NewsTableViewCell"
    
    private let title: UILabel = {
        let lable = UILabel()
        lable.numberOfLines = 0
        lable.textColor = .systemYellow
        lable.font = .systemFont(ofSize: 22, weight: .semibold)
        return lable
    }()
    
    private let newsDescription: UILabel = {
        let lable = UILabel()
        lable.numberOfLines = 0
        lable.textColor = .systemPurple
        lable.font = UIFont(name: "HelveticaNeue", size: CGFloat(12))
        return lable
    }()
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let continueLable: UILabel = {
        let lable = UILabel()
        lable.numberOfLines = 0
        lable.text = "Press to read more!"
        lable.font = .systemFont(ofSize: 10
                                 , weight: .light)
        return lable
    }()
    
    //Add the content into the view
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(image)
        contentView.addSubview(newsDescription)
        contentView.addSubview(title)
        contentView.addSubview(continueLable)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //Creates a layout of the content
    override func layoutSubviews() {
        super.layoutSubviews()
        
        image.frame = CGRect(
            x: 0,
            y: 5,
            width: 150,
            height: contentView.frame.size.height - 10
        )
        
        title.frame = CGRect(
            x: contentView.frame.size.width - 220,
            y: 0,
            width: contentView.frame.size.width - 170,
            height: 70
        )
        newsDescription.frame = CGRect(
            x: contentView.frame.size.width - 220,
            y: 60,
            width: contentView.frame.size.width - 170,
            height: contentView.frame.size.height/2
        )
        
        continueLable.frame = CGRect(
            x: contentView.frame.size.width - 220,
            y: 120,
            width: contentView.frame.size.width - 170,
            height: contentView.frame.size.height/2
        )
    }
    
    
    //Configures the content of the table view cells using a model with all of the data inside of it.

    func configure(with viewModel: cellContentModel ){
        title.text = viewModel.newsTitle
        newsDescription.text = viewModel.newsDescription
        
        if let url = viewModel.image{
            //Little API cal
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    self?.image.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}

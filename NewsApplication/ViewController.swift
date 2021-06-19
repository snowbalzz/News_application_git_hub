//
//  ViewController.swift
//  NewsApplication
//
//  Created by Daniils Aleksasins
//

import UIKit

//Services for the app to open links in the safari browser
import SafariServices

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /*
        Creates a table view for the news to be stored
     */
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(tabelCell.self, forCellReuseIdentifier: tabelCell.identifier)
        
        return table
    }()
    
    //Array of cells
    private var contentModel = [cellContentModel]()
    //Array of articles urls for the safari view to utilize
    private var articles = [Article]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Creates a layout of the app on the simulator or a physical Iphone
        title = "Gaming news"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemPink
                
        APICaller.shared.fetchData { (articles) in
            self.articles = articles
            self.contentModel = articles.compactMap({
                cellContentModel(title: $0.title,
                                subtitle: $0.description,
                                imageURL: URL(string: $0.urlToImage))
            })
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentModel.count
    }
    
    //Creates the cell according to the preset
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tabelCell.identifier, for: indexPath
        ) as? tabelCell else {
            fatalError()
        }
        
        cell.configure(with: contentModel[indexPath.row])
        
        return cell
    }
    
    /*
     Function that is used to check if the table element is selected
     If it has been selected, open imbeded url in a browser using extension
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let article = articles[indexPath.row]
        
        guard let url = URL(string: article.url ) else {return}
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    /*
     Function that sets the height of the cell in table view
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}


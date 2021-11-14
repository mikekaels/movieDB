//
//  GenresVC.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 13/11/21.
//

import UIKit

class GenresVC: UIViewController {
    var presentor: GenresViewToPresenterProtocol?
    
    var genreList: [Genre] = [Genre]()
    
    let genreTableView: UITableView = {
        let t = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .grouped)
        t.register(UITableViewCell.self, forCellReuseIdentifier: "GenreCell")
        t.tableHeaderView = .none
        return t
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie Genre"
        view.backgroundColor = .systemBackground
        
        view.addSubview(genreTableView)
        
        genreTableView.delegate = self
        genreTableView.dataSource = self
        presentor?.fetchGenres()
    }  
}

extension GenresVC: GenresPresenterToViewProtocol {
    func didFetchGenres(genres: [Genre]) {
        self.genreList = genres
        DispatchQueue.main.async {
            self.genreTableView.reloadData()
        }
    }
}

extension GenresVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genreList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "GenreCell")
        
        let data = genreList[indexPath.row]
        
        cell.textLabel?.text = data.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentor?.goToDiscoveries(genreId: genreList[indexPath.row].id, from: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight: CGFloat = CGFloat()
        cellHeight = 60
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    
}

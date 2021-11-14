//
//  DiscoveriesVC.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 13/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

class DiscoveriesVC: UIViewController {
    var presentor: DiscoveriesViewToPresenterProtocol?
    public var delegate: DiscoveriesDelegate!
    
    var moviesCollectionView: UICollectionView?
    
    var movieList: [Movie] = [Movie]()
    
    var genreId: Int?
    var currentPage: Int = 1
    var totalPage: Int = 0
    
    var spinerView: UIView = {
       let view = UIView()
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.isHidden = true
        return spinner
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Discoveries"
        collectionViewSetup()
        fetchMovies()
        
        view.addSubview(spinerView)
        spinerView.topAnchor.constraint(equalTo: moviesCollectionView!.bottomAnchor, constant: -UIScreen.main.bounds.height/5).isActive = true
        spinerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        spinerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/5).isActive = true
        
        spinerView.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: spinerView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: spinerView.centerYAnchor).isActive = true
        
        moviesCollectionView?.dataSource = self
        moviesCollectionView?.delegate = self
    }

    private func fetchMovies() {
        presentor?.fetchDiscoveries(genreId: self.genreId!, page: self.currentPage)
    }
    
    func collectionViewSetup() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 100, right: 20)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2.4,
                                 height: UIScreen.main.bounds.width / 1.5)
        layout.minimumLineSpacing = 15
        
        moviesCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: layout)
        self.view.addSubview(moviesCollectionView!)
        
        moviesCollectionView?.register(MovieCollectionCell.self, forCellWithReuseIdentifier: "MovieCollectionCell")
        moviesCollectionView?.register(LoadingCollectionCell.self, forCellWithReuseIdentifier: "LoadingCollectionCell")
        
        moviesCollectionView?.backgroundColor = UIColor.clear
        
        moviesCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        moviesCollectionView?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        moviesCollectionView?.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        moviesCollectionView?.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        moviesCollectionView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }
    
    func getRandomMoreLikeThis() -> [(String, Int)]  {
        var moreLikeTheseUrl: [(String, Int)] = [(String, Int)]()
        while moreLikeTheseUrl.count < 7 {
            let randomIndex = Int.random(in: 0...movieList.count - 1)
            
            if let index = moreLikeTheseUrl.firstIndex(where: {$0.1 == self.movieList[randomIndex].movieId}) {
                moreLikeTheseUrl.remove(at: index)
            }
            
            moreLikeTheseUrl.append((self.movieList[randomIndex].movieImageUrl , self.movieList[randomIndex].movieId))
        }
        return moreLikeTheseUrl
    }
}

extension DiscoveriesVC: DiscoveriesPresenterToViewProtocol {
    func didFetchDiscoveries(movies: [Movie], page: Int, totalPages: Int) {
        self.movieList.append(contentsOf: movies)
        self.currentPage = page
        self.totalPage = totalPages
        DispatchQueue.main.async {
            self.moviesCollectionView?.reloadData()
        }
    }
}

extension DiscoveriesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionCell", for: indexPath) as! MovieCollectionCell
        cell.title.text = self.movieList[indexPath.row].movieTitle
        cell.image.loadImageUsingUrlString(urlString: "http://image.tmdb.org/t/p/w500\(self.movieList[indexPath.row].movieImageUrl)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movieList[indexPath.row]
        presentor?.goToMovieDetails(movieId: movie.movieId, moreLikeThese: getRandomMoreLikeThis(), movies: self.movieList, from: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if currentPage < totalPage && indexPath.row == movieList.count - 1 {
            self.spinner.isHidden = false
            self.currentPage += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.fetchMovies()
                self.spinner.isHidden = true
            }
        }
    }
}

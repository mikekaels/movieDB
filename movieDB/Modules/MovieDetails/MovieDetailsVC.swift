//
//  MovieDetailsVC.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 13/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

class MovieDetailsVC: UIViewController {
    var presentor: MovieDetailsViewToPresenterProtocol?
    public var delegate: MovieDetailsDelegate!
    
    var movieId: Int = 0
    var movieDetail: MovieDetails?
    var collectionView:UICollectionView?
    
    var moreLikeTheseUrl: [(String, Int)] = [(String, Int)]()
    var movieList: [Movie] = [Movie]()
    
    var segmentedItems = ["Watch", "More Like This", "Reviews"]
    
    let poster: CustomImageView = {
        let image = CustomImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = UIView.ContentMode.scaleAspectFill
        return image
    }()
    
    let scrollView: EasyScrollView = {
        let view = EasyScrollView()
//        view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 500)
        view.contentSize = CGSize(width: view.frame.width, height: UIScreen.main.bounds.height)
        view.backgroundColor = .systemBackground
        view.contentInsetAdjustmentBehavior = .automatic
        view.isScrollEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let movieTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let movieRating: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let movieRated: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis  = NSLayoutConstraint.Axis.horizontal
        sv.alignment = UIStackView.Alignment.leading
        sv.distribution = UIStackView.Distribution.fillProportionally
        sv.translatesAutoresizingMaskIntoConstraints = false;
        return sv
    }()
    
    let playButton: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .label
        bt.layer.cornerRadius = 5
        bt.layer.masksToBounds = true
        bt.setTitleColor(.systemBackground, for: .normal)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        bt.translatesAutoresizingMaskIntoConstraints = false;
        return bt
    }()
    
    let downloadButton: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .systemGray5
        bt.layer.cornerRadius = 5
        bt.layer.masksToBounds = true
        bt.setTitleColor(.label, for: .normal)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        bt.translatesAutoresizingMaskIntoConstraints = false;
        return bt
    }()
    
    let movieOverview: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var movieGenres: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let segmentedControl: UISegmentedControl = {
        let s = UISegmentedControl(items: ["Watch", "More Like This", "Reviews"])
        s.selectedSegmentIndex = 0
//        s.translatesAutoresizingMaskIntoConstraints = false
        s.backgroundColor = .clear
        return s
    }()
    
    
    let moreLikeThis: UILabel = {
        let label = UILabel()
        label.text = "More Like This"
        label.textColor = .label
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let colView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let segmentedView: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarAppearance()
        title = "Movie Detail"
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        fetchMovieDetails()
        fetchMovieVideo()
        viewSetup()
        collectionViewSetup()
        view.backgroundColor = .systemBackground
        playButton.setTitle("Play", for: .normal)
        downloadButton.setTitle("Download", for: .normal)
        movieGenres.text = "Genre: Action, Thriler, Adventure, Science Fiction"
        
    
        
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
    }
    
    func fetchMovieDetails() {
        presentor?.fetchMovieDetails(movieId: self.movieId)
    }
    
    func fetchMovieVideo() {
        presentor?.fetchMovieVideo(movieId: self.movieId)
    }
    
    func viewSetup() {
        view.addSubview(poster)
        poster.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        poster.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        poster.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -300).isActive = true
        
        view.addSubview(scrollView)
        scrollView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        scrollView.topAnchor.constraint(equalTo: poster.bottomAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        scrollView.addSubview(movieTitle)
        movieTitle.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        movieTitle.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        movieTitle.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        
        scrollView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 0).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        stackView.addSubview(movieRating)
        movieRating.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        
        stackView.addSubview(movieRated)
        movieRated.leftAnchor.constraint(equalTo: movieRating.rightAnchor, constant: 10).isActive = true
        
        scrollView.addSubview(playButton)
        playButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 0).isActive = true
        playButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        playButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        scrollView.addSubview(downloadButton)
        downloadButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 10).isActive = true
        downloadButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        downloadButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        downloadButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        scrollView.addSubview(movieOverview)
        movieOverview.topAnchor.constraint(equalTo: downloadButton.bottomAnchor, constant: 20).isActive = true
        movieOverview.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        movieOverview.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        
        scrollView.addSubview(movieGenres)
        movieGenres.topAnchor.constraint(equalTo: movieOverview.bottomAnchor, constant: 10).isActive = true
        movieGenres.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        movieGenres.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        
        scrollView.addSubview(moreLikeThis)
        moreLikeThis.topAnchor.constraint(equalTo: movieGenres.bottomAnchor, constant: 20).isActive = true
        moreLikeThis.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        moreLikeThis.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        
        scrollView.addSubview(colView)
        colView.topAnchor.constraint(equalTo: moreLikeThis.bottomAnchor, constant: 0).isActive = true
        colView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        colView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        colView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        
        scrollView.addSubview(segmentedView)
        segmentedView.topAnchor.constraint(equalTo: colView.bottomAnchor, constant: 0).isActive = true
        segmentedView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        segmentedView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        scrollView.stack.configure { v in
            
        }
        
        segmentedView.addSubview(segmentedControl)
        segmentedControl.topAnchor.constraint(equalTo: segmentedView.topAnchor, constant: 0).isActive = true
        segmentedControl.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func collectionViewSetup() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3.4,
                                 height: UIScreen.main.bounds.width / 2.4)
        layout.minimumLineSpacing = 12
        
        collectionView = UICollectionView(frame: colView.frame, collectionViewLayout: layout)
        collectionView?.isScrollEnabled = false
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.register(moreLikeTheseCell.self, forCellWithReuseIdentifier: "cell")
        collectionView?.backgroundColor = UIColor.systemBackground
        colView.addSubview(collectionView!)
        collectionView?.topAnchor.constraint(equalTo: colView.topAnchor, constant: 0).isActive = true
        collectionView?.leftAnchor.constraint(equalTo: colView.leftAnchor, constant: 0).isActive = true
        collectionView?.rightAnchor.constraint(equalTo: colView.rightAnchor, constant: 0).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: colView.bottomAnchor, constant: 0).isActive = true
    }

}

extension MovieDetailsVC: MovieDetailsPresenterToViewProtocol {
    func didFetchMovieVideo(movieVideo: [MovieVideo]) {
        print("MOVIE VIDEO: ",movieVideo)
    }
    
    func didFetchMovieDetails(movieDetails: MovieDetails) {
        DispatchQueue.main.async {
            self.movieDetail = movieDetails
            self.movieTitle.text = movieDetails.movieTitle
            self.movieOverview.text = movieDetails.movieOverview
            self.movieRated.text = movieDetails.adult ? "Adult" : ""
            self.poster.loadImageUsingUrlString(urlString: "http://image.tmdb.org/t/p/w500\(movieDetails.movieImageUrl)")
            self.movieRating.text = String(movieDetails.voteAverage)
            self.movieGenres.text = "Genre: \(movieDetails.genres.map{$0.name }.map{String($0)}.joined(separator: ", "))"
            self.collectionView?.reloadData()
        }
    }
    
    
}

extension MovieDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! moreLikeTheseCell
        
        cell.image.loadImageUsingUrlString(urlString: "http://image.tmdb.org/t/p/w500\(self.moreLikeTheseUrl[indexPath.row].0)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(self.moreLikeTheseUrl[indexPath.row].1)
//        vc.moreLikeTheseUrl = getRandomMoreLikeThis()
//        vc.movies = self.movieList
//
//        vc.movieId = self.moreLikeTheseUrl[indexPath.row].1
//        navigationController?.pushViewController(vc, animated: true)
        
        
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

//
//  MovieDetailsVC.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 13/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit
import AVFoundation
import youtube_ios_player_helper

class MovieDetailsVC: UIViewController {
    var presentor: MovieDetailsViewToPresenterProtocol?
    public var delegate: MovieDetailsDelegate!
    
    var movieId: Int = 0
    var movieDetail: MovieDetails?
    var collectionView: UICollectionView?
    
    var moreLikeTheseUrl: [(String, Int)] = [(String, Int)]()
    var movieList: [Movie] = [Movie]()
    var videoList: [MovieVideo] = [MovieVideo]()
    
    var reviewList: [Review] = [Review]()
    var reviewPage: Int = 1
    var reviewTotalPage: Int = 0
    var selectedIndex: IndexPath?
    
    var isPaginating = false
    
    let one = UIButton().createSegmentedControlButton(setTitle: "More Like This")
    let two = UIButton().createSegmentedControlButton(setTitle: "Trailer")
    let three = UIButton().createSegmentedControlButton(setTitle: "Reviews")

    let scrollView: UIScrollView = UIScrollView()
        .configure { v in
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    
    let contentView: UIView = UIView()
        .configure { v in
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    
    let poster: CustomImageView = {
        let image = CustomImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let gradientView: GradientView = GradientView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 370))
        .configure { s in
            s.translatesAutoresizingMaskIntoConstraints = false
        }
    
    let othersView: UIView = UIView()
        .configure { v in
            v.backgroundColor = .white
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    
    let movieTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.sizeToFit()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 27, weight: .bold)
        label.textColor = .white
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
        bt.backgroundColor = .systemBackground
        bt.layer.cornerRadius = 5
        bt.layer.masksToBounds = true
        bt.setTitleColor(.label, for: .normal)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        bt.heightAnchor.constraint(equalToConstant: 40).isActive = true
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
        label.textColor = .systemBackground
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var movieGenres: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray6
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    let segmentedView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let colView: UIView = {
        let view = UIView()
        view.tag = 99
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let videosViewContainer: UIView = UIView()
        .configure { v in
            v.alpha = 0.0
            v.tag = 88
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    let videosTable: UITableView = UITableView()
        .configure { t in
            t.register(VideoTableViewCell.self, forCellReuseIdentifier: "VideoCell")
            t.tableHeaderView = .none
//            t.isScrollEnabled = false
            t.allowsSelection = false
            t.translatesAutoresizingMaskIntoConstraints = false
        }
    
    let reviewsContainer: UIView = UIView()
        .configure { v in
            v.alpha = 0.0
            v.tag = 77
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    let reviewsTable: UITableView = UITableView()
        .configure { t in
            t.register(ReviewTableViewCell.self, forCellReuseIdentifier: "ReviewCell")
            t.tableHeaderView = .none
            t.allowsSelection = true
            t.translatesAutoresizingMaskIntoConstraints = false
        }
    
    let segmentedControlView: UIView = UIView()
    let segmentedScrollView: UIScrollView = UIScrollView()
    let segmentedControlBackgroundColor = UIColor.init(white: 0.1, alpha: 0.1)
    
    
    let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. "
            label.numberOfLines = 0
            label.sizeToFit()
            label.textColor = UIColor.clear
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarAppearance()
        title = "Movie Detail"
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        configureCustomSegmentedControl()
        segmentedScrollView.translatesAutoresizingMaskIntoConstraints = false
        segmentedControlView.translatesAutoresizingMaskIntoConstraints = false
        
        fetchMovieDetails()
        fetchMovieVideo()
        fetchMovieReviews()
//        viewSetup()
//        collectionViewSetup()
        view.backgroundColor = .systemBackground
        playButton.setTitle("Play", for: .normal)
        downloadButton.setTitle("Download", for: .normal)
        movieGenres.text = "Genre: Action, Thriler, Adventure, Science Fiction"

        // Setup scroll view
        setupScrollView()
        collectionViewSetup()
        setupViews()
        
        // CollectionView
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        // Trailer Videos Table
        videosTable.delegate = self
        videosTable.dataSource = self
        
        // Review Table
        reviewsTable.delegate = self
        reviewsTable.dataSource = self
    }
    
    func fetchMovieReviews() {
        presentor?.fetchMovieReviews(movieId: self.movieId, page: self.reviewPage)
    }
    
    func fetchMovieDetails() {
        presentor?.fetchMovieDetails(movieId: self.movieId)
    }
    
    func fetchMovieVideo() {
        presentor?.fetchMovieVideo(movieId: self.movieId)
    }
    
    func setupViews() {
        contentView.addSubview(poster)
        poster.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        poster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        poster.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true

        contentView.addSubview(gradientView)
        gradientView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        gradientView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        gradientView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 280).isActive = true
        
        gradientView.addSubview(movieTitle)
        movieTitle.centerXAnchor.constraint(equalTo: gradientView.centerXAnchor).isActive = true
        movieTitle.widthAnchor.constraint(equalTo: gradientView.widthAnchor, multiplier: 3/3.5).isActive = true
        movieTitle.topAnchor.constraint(equalTo: gradientView.topAnchor, constant: 100).isActive = true
        
        gradientView.addSubview(movieGenres)
        movieGenres.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 10).isActive = true
        movieGenres.centerXAnchor.constraint(equalTo: gradientView.centerXAnchor).isActive = true
        
        gradientView.addSubview(playButton)
        playButton.topAnchor.constraint(equalTo: movieGenres.bottomAnchor, constant: 10).isActive = true
        playButton.centerXAnchor.constraint(equalTo: gradientView.centerXAnchor).isActive = true
        playButton.widthAnchor.constraint(equalTo: gradientView.widthAnchor, multiplier: 3/4).isActive = true
        
        gradientView.addSubview(movieOverview)
        movieOverview.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 20).isActive = true
        movieOverview.centerXAnchor.constraint(equalTo: gradientView.centerXAnchor).isActive = true
        movieOverview.widthAnchor.constraint(equalTo: gradientView.widthAnchor, multiplier: 3/3.5).isActive = true
        
        contentView.addSubview(othersView)
        
        othersView.topAnchor.constraint(equalTo: movieOverview.bottomAnchor, constant: 20).isActive = true
        othersView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        othersView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        othersView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        othersView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: othersView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: othersView.topAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: othersView.widthAnchor, multiplier: 3/4).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: othersView.bottomAnchor).isActive = true

        othersView.addSubview(segmentedScrollView)
        segmentedScrollView.topAnchor.constraint(equalTo: othersView.topAnchor, constant: 15).isActive = true
        segmentedScrollView.widthAnchor.constraint(equalTo: othersView.widthAnchor).isActive = true
        segmentedScrollView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        othersView.addSubview(colView)
        colView.topAnchor.constraint(equalTo: segmentedScrollView.bottomAnchor, constant: 0).isActive = true
        colView.leftAnchor.constraint(equalTo: othersView.leftAnchor, constant: 10).isActive = true
        colView.rightAnchor.constraint(equalTo: othersView.rightAnchor, constant: -10).isActive = true
        colView.bottomAnchor.constraint(equalTo: othersView.bottomAnchor).isActive = true
}
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
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
        collectionView?.backgroundColor = UIColor.clear
        
        colView.addSubview(collectionView!)
        collectionView?.topAnchor.constraint(equalTo: colView.topAnchor, constant: 0).isActive = true
        collectionView?.leftAnchor.constraint(equalTo: colView.leftAnchor, constant: 0).isActive = true
        collectionView?.rightAnchor.constraint(equalTo: colView.rightAnchor, constant: 0).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: colView.bottomAnchor, constant: colView.frame.height + 100).isActive = true
    }
}

extension MovieDetailsVC: MovieDetailsPresenterToViewProtocol {
    func didFetchMovieReviews(movieReviews: [Review], page: Int, totalPages: Int) {
        reviewList.append(contentsOf: movieReviews)
        reviewPage = page
        reviewTotalPage = totalPages
        
        DispatchQueue.main.async {
            self.reviewsTable.tableFooterView = nil
            self.reviewsTable.reloadData()
        }
        print("REVIEWS: ",movieReviews)
    }
    
    func didFetchMovieVideo(movieVideo: [MovieVideo]) {
        videoList = movieVideo.enumerated().filter { $0.offset < 5 }.map { $0.element }
        
        DispatchQueue.main.async {
            self.videosTable.reloadData()
        }
    }
    
    func didFetchMovieDetails(movieDetails: MovieDetails) {
        DispatchQueue.main.async {
            self.movieDetail = movieDetails
            self.movieTitle.text = movieDetails.movieTitle
            self.movieOverview.text = movieDetails.movieOverview
            self.movieRated.text = movieDetails.adult ? "Adult" : ""
            self.poster.loadImageUsingUrlString(urlString: "http://image.tmdb.org/t/p/w500\(movieDetails.movieImageUrl)")
            self.movieRating.text = String(movieDetails.voteAverage)
            self.movieGenres.text = "\(movieDetails.genres.map{$0.name }.map{String($0)}.joined(separator: ", "))"
            self.collectionView?.reloadData()
        }
    }
}

extension MovieDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
            case videosTable:
                return videoList.count
            case reviewsTable:
                return reviewList.count
            default:
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch tableView {
            case videosTable:
                let cell = videosTable.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoTableViewCell
                let video = videoList[indexPath.row]
                cell.videoView.load(withVideoId: video.key)
                return cell
            case reviewsTable:
                let cell = reviewsTable.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewTableViewCell
                let review = reviewList[indexPath.row]
            cell.profileImage.loadImageUsingUrlString(urlString: "https://secure.gravatar.com/avatar\( review.authorDetails.avatarPath ?? "/992eef352126a53d7e141bf9e8707576.jpg")")
            
            print("Hello","https://secure.gravatar.com/avatar\(review.authorDetails.avatarPath ?? "/992eef352126a53d7e141bf9e8707576.jpg")")
                cell.usernameLabel.text = review.author
                cell.reviewLabel.text = review.content
                return cell
            default:
                return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch tableView {
            case videosTable:
                return 240
            case reviewsTable:
                if selectedIndex == indexPath {
                    return 300
                } else {
                    return 100
                }
            default:
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        
        reviewsTable.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if reviewPage < reviewTotalPage && position > (reviewsTable.contentSize.height - 100 - scrollView.frame.size.height) {
            self.reviewsTable.tableFooterView = createSpinnerFooter()
            fetchMovieReviews()
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

extension MovieDetailsVC {
    @objc func handleSegmentedControlButtons(sender: UIButton) {
        
        let segmentedControlButtons: [UIButton] = [
            one, two, three
        ]
        
        for button in segmentedControlButtons {
            if button == sender {
                UIView.animate(withDuration: 0.2, delay: 0.1, options: .transitionFlipFromLeft) {
                    button.setTitleColor(UIColor.label, for: .normal)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
                }
                
                print(button.titleLabel!.text!)
                
                if sender.titleLabel?.text != "More Like This" {
                    for view in self.othersView.subviews {
                        if view.tag == 99 {view.removeFromSuperview() }
                    }
                    UIView.animate(withDuration: 0.3, delay: 0, options: .beginFromCurrentState) {
                        self.colView.alpha = 0.0
                    }
                } else {
                    othersView.addSubview(colView)
                    colView.topAnchor.constraint(equalTo: segmentedScrollView.bottomAnchor, constant: 0).isActive = true
                    colView.leftAnchor.constraint(equalTo: othersView.leftAnchor, constant: 10).isActive = true
                    colView.rightAnchor.constraint(equalTo: othersView.rightAnchor, constant: -10).isActive = true
                    colView.bottomAnchor.constraint(equalTo: othersView.bottomAnchor).isActive = true
                    
                    UIView.animate(withDuration: 0.3, delay: 0, options: .beginFromCurrentState) {
                        self.colView.alpha = 1.0
                    }
                }
                
                if sender.titleLabel?.text != "Trailer" {
                    for view in self.othersView.subviews {
                        if view.tag == 88 {view.removeFromSuperview() }
                    }
                    UIView.animate(withDuration: 0.3, delay: 0, options: .beginFromCurrentState) {
                        self.videosViewContainer.alpha = 0.0
                    }
                } else {
                    othersView.addSubview(videosViewContainer)
                    videosViewContainer.topAnchor.constraint(equalTo: segmentedScrollView.bottomAnchor, constant: 20).isActive = true
                    videosViewContainer.leftAnchor.constraint(equalTo: othersView.leftAnchor, constant: 10).isActive = true
                    videosViewContainer.rightAnchor.constraint(equalTo: othersView.rightAnchor, constant: -10).isActive = true
                    videosViewContainer.bottomAnchor.constraint(equalTo: othersView.bottomAnchor).isActive = true
                    
                    videosViewContainer.addSubview(videosTable)
                    videosTable.centerXAnchor.constraint(equalTo: videosViewContainer.centerXAnchor).isActive = true
                    videosTable.widthAnchor.constraint(equalTo: videosViewContainer.widthAnchor).isActive = true
                    videosTable.heightAnchor.constraint(equalToConstant: 300).isActive = true
                    videosTable.topAnchor.constraint(equalTo: videosViewContainer.topAnchor).isActive = true
                    UIView.animate(withDuration: 0.3, delay: 0, options: .beginFromCurrentState) {
                        self.videosViewContainer.alpha = 1.0
                    }
                }
                
                if sender.titleLabel?.text != "Reviews" {
                    for view in self.othersView.subviews {
                        if view.tag == 77 {view.removeFromSuperview() }
                    }
                    UIView.animate(withDuration: 0.3, delay: 0, options: .beginFromCurrentState) {
                        self.reviewsContainer.alpha = 0.0
                    }
                } else {
                    othersView.addSubview(reviewsContainer)
                    reviewsContainer.topAnchor.constraint(equalTo: segmentedScrollView.bottomAnchor, constant: 20).isActive = true
                    reviewsContainer.leftAnchor.constraint(equalTo: othersView.leftAnchor, constant: 10).isActive = true
                    reviewsContainer.rightAnchor.constraint(equalTo: othersView.rightAnchor, constant: -10).isActive = true
                    reviewsContainer.bottomAnchor.constraint(equalTo: othersView.bottomAnchor).isActive = true
                    
                    reviewsContainer.addSubview(reviewsTable)
                    reviewsTable.centerXAnchor.constraint(equalTo: reviewsContainer.centerXAnchor).isActive = true
                    reviewsTable.widthAnchor.constraint(equalTo: reviewsContainer.widthAnchor).isActive = true
                    reviewsTable.heightAnchor.constraint(equalToConstant: 300).isActive = true
                    reviewsTable.topAnchor.constraint(equalTo: reviewsContainer.topAnchor).isActive = true
                    UIView.animate(withDuration: 0.3, delay: 0, options: .beginFromCurrentState) {
                        self.reviewsContainer.alpha = 1.0
                    }
                }
            } else {
                UIView.animate(withDuration: 0.2, delay: 0.1, options: .transitionFlipFromLeft) {
                    button.setTitleColor(UIColor.systemGray, for: .normal)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
                    
                }
            }
        }
        
    }
    
    func configureCustomSegmentedControl() {
        let segmentedControlButtons: [UIButton] = [
            one, two, three
        ]
        
        for button in segmentedControlButtons {
            if button.titleLabel!.text! == "More Like This" {
                UIView.animate(withDuration: 0.2, delay: 0.1, options: .transitionFlipFromLeft) {
                    button.setTitleColor(UIColor.label, for: .normal)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
                }
            }
        }
        
        segmentedControlButtons.forEach {$0.addTarget(self, action: #selector(handleSegmentedControlButtons(sender:)), for: .touchUpInside)}
        
        let stackView = UIStackView(arrangedSubviews: segmentedControlButtons)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        
        segmentedScrollView.addSubview(stackView)
        
        segmentedScrollView.contentInset = UIEdgeInsets(top: 0, left: 10.0, bottom: 0, right: 20)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: segmentedScrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: segmentedScrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: segmentedScrollView.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
}


//func viewSetup() {
//        view.addSubview(poster)
//        poster.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
//        poster.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
//        poster.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -300).isActive = true
//
//        view.addSubview(scrollView)
//        scrollView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
//        scrollView.topAnchor.constraint(equalTo: poster.bottomAnchor, constant: 0).isActive = true
//        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
//
//        scrollView.addSubview(movieTitle)
//        movieTitle.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
//        movieTitle.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
//        movieTitle.heightAnchor.constraint(equalToConstant: 35).isActive = true
//
//
//        scrollView.addSubview(stackView)
//        stackView.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 0).isActive = true
//        stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
//        stackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
//
//        stackView.addSubview(movieRating)
//        movieRating.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
//
//        stackView.addSubview(movieRated)
//        movieRated.leftAnchor.constraint(equalTo: movieRating.rightAnchor, constant: 10).isActive = true
//
//        scrollView.addSubview(playButton)
//        playButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 0).isActive = true
//        playButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
//        playButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
//        playButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
//
//        scrollView.addSubview(downloadButton)
//        downloadButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 10).isActive = true
//        downloadButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
//        downloadButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
//        downloadButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
//
//        scrollView.addSubview(movieOverview)
//        movieOverview.topAnchor.constraint(equalTo: downloadButton.bottomAnchor, constant: 20).isActive = true
//        movieOverview.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
//        movieOverview.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
//
//        scrollView.addSubview(movieGenres)
//        movieGenres.topAnchor.constraint(equalTo: movieOverview.bottomAnchor, constant: 10).isActive = true
//        movieGenres.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
//        movieGenres.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
//
//        scrollView.addSubview(moreLikeThis)
//        moreLikeThis.topAnchor.constraint(equalTo: movieGenres.bottomAnchor, constant: 20).isActive = true
//        moreLikeThis.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
//        moreLikeThis.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
//
//        scrollView.addSubview(colView)
//        colView.topAnchor.constraint(equalTo: moreLikeThis.bottomAnchor, constant: 0).isActive = true
//        colView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
//        colView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
//        colView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
//
//        scrollView.addSubview(segmentedView)
//        segmentedView.topAnchor.constraint(equalTo: colView.bottomAnchor, constant: 0).isActive = true
//        segmentedView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
//        segmentedView.heightAnchor.constraint(equalToConstant: 200).isActive = true
//
//        scrollView.stack.configure { v in
//
//        }
//
//        segmentedView.addSubview(segmentedControl)
//        segmentedControl.topAnchor.constraint(equalTo: segmentedView.topAnchor, constant: 0).isActive = true
//        segmentedControl.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
//        segmentedControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
//}

class GradientView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let gradient = CAGradientLayer()
        gradient.frame  = bounds
        gradient.colors = [
            UIColor.black.withAlphaComponent(0.0).cgColor,
            UIColor.black.withAlphaComponent(1.0).cgColor,
            UIColor.black.withAlphaComponent(1.0).cgColor
        ]
        layer.addSublayer(gradient)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIButton{
    func createSegmentedControlButton(setTitle to: String)-> UIButton {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(to, for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        let buttonTitleSize = (to as NSString).size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .semibold)])
        
        button.widthAnchor.constraint(equalToConstant: CGFloat(buttonTitleSize.width + 20)).isActive = true
        button.heightAnchor.constraint(equalToConstant: CGFloat(buttonTitleSize.height)).isActive = true
        
        return button
    }
}

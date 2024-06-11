//
//  ViewController.swift
//  MovieApp-Programmatic
//
//  Created by zeynep on 27.03.2024.
//

import UIKit

extension HomeViewController {
    fileprivate enum Constants {
        static let cellDescriptionViewHeight: CGFloat = 60
        static let cellPosterImageViewAspectRatio: CGFloat = 130 / 345
        static let cellLeftPadding: CGFloat = 15
        static let cellRightPadding: CGFloat = 15
    }
}



class HomeViewController: UIViewController {
    let networkManager: NetworkManager<HomeEndpointItem> = NetworkManager()
    private var results: [Movie]? = []
    private var page: Int = 1
    private let moviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .lightGray
        cv.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        return cv
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getMovies(query: "page=\(page)")
        view.addSubview(moviesCollectionView)
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        
        setupCollectionViewConstraints()
        
    }
    private func getMovies(query: String) {
        networkManager.getMovies(type: HomeResponse.self, endpoint: .homepage(query: query)) {[ weak self ] result in
            switch result {
            case .success(let response):
                self?.results?.append(contentsOf: response.results ?? [])
                self?.page = (response.page ?? 0) + 1
                DispatchQueue.main.async {
                    self?.moviesCollectionView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    private func setupCollectionViewConstraints() {
        moviesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        moviesCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        moviesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        moviesCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        moviesCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
    private func calculateCellHeight() -> CGFloat {
        let cellWidth = moviesCollectionView.frame.size.width - (Constants.cellLeftPadding + Constants.cellRightPadding)
        let posterImageHeight = cellWidth * Constants.cellPosterImageViewAspectRatio
        let cellHeight = Constants.cellDescriptionViewHeight + posterImageHeight
        return cellHeight
    }
    
}
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        if let movie = results?[indexPath.item] {
            cell.configure(movie: movie)
        }
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let results = results else { return }
        if indexPath.item == (results.count - 1) {
            getMovies(query: "page=\(page)")
            page += 1
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.size.width - (Constants.cellLeftPadding + Constants.cellRightPadding), height: calculateCellHeight())
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: .zero, left: Constants.cellLeftPadding, bottom: .zero, right: Constants.cellRightPadding)
    }
}

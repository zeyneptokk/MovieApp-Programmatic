//
//  MovieCell.swift
//  MovieApp-Programmatic
//
//  Created by zeynep on 24.04.2024.
//

import UIKit
import SDWebImage

class MovieCell: UICollectionViewCell {
    let movieImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let movieTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        lbl.font = .bold(14)
        lbl.contentMode = .scaleAspectFit
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Hello"
        return lbl
    }()
    
    let movieReleaseDateLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        lbl.font = .regular(12)
        return lbl
    }()
    
    let movieRatingView = StampView()
    let dateImageView = UIImageView()
    let moviePopularityView = StampView()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(movieReleaseDateLabel)
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieRatingView)
        contentView.addSubview(moviePopularityView)
        
        setupMovieTitleLabelConstraints()
        setupMovieReleaseDateLabelConstraints()
        setupMovieRatingViewContraints()
        setupMoviePopularityViewConstraints()
        setupMoviePosterConstraints()
        
        
        
    }
    
    func setupMovieTitleLabelConstraints() {
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            movieTitleLabel.rightAnchor.constraint(greaterThanOrEqualTo: contentView.rightAnchor, constant: -150),
            movieTitleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 10),
            movieTitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -36)
        ])
        
    }
    
    func setupMovieReleaseDateLabelConstraints() {
        movieReleaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieReleaseDateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            movieReleaseDateLabel.rightAnchor.constraint(greaterThanOrEqualTo: contentView.rightAnchor, constant: -150),
            movieReleaseDateLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 10),
            movieReleaseDateLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -6)
        ])
        
    }
    
    func setupMovieRatingViewContraints() {
        movieRatingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieRatingView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            movieRatingView.rightAnchor.constraint(equalTo: contentView.leftAnchor, constant: 60),
            movieRatingView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 110),
            movieRatingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -66)
        ])
        
        
        }
    func setupMoviePopularityViewConstraints() {
        moviePopularityView.translatesAutoresizingMaskIntoConstraints = false
//        moviePopularityView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        NSLayoutConstraint.activate([
            moviePopularityView.leftAnchor.constraint(equalTo: movieRatingView.rightAnchor, constant: 10),
            moviePopularityView.rightAnchor.constraint(equalTo: movieRatingView.rightAnchor, constant: 75),
            moviePopularityView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 110),
            moviePopularityView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -66)
        
        ])
        
    }
    func setupMoviePosterConstraints() {
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            movieImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: movieTitleLabel.topAnchor, constant: -10)
        
        ])
    }
    
    func configure(movie: Movie) {
        movieTitleLabel.text = movie.title
        movieReleaseDateLabel.text = movie.releaseDate
        dateImageView.image = UIImage(named: "dateIcon")
        prepareRating(rating: movie.voteAverage)
        prepareMoviePoster(with: movie.backdropPath)
        preparePopularityView(popularityText: movie.popularity)
        
    }
    private func prepareMoviePoster(with urlString: String?) {
        let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
        if let imageUrlString = urlString, let url = URL(string: imageBaseUrl + imageUrlString) {
            movieImageView.sd_setImage(with: url)
        }
        
    }
    
    private func prepareRating(rating: Double?) {
        if let rating = rating {
            movieRatingView.configure(title: String(rating),
                                      backgroundColor: .systemGreen,
                                      font: .bold(12),
                                      cornerRadius: 5,
                                      image: UIImage(named: "rateIcon"))
            movieRatingView.isHidden = false
        } else {
            movieRatingView.isHidden = true
        }
    }
    
    private func preparePopularityView(popularityText: Double?) {
        if let popularityText = popularityText {
            moviePopularityView.configure(title: String(popularityText), backgroundColor: .systemOrange, image: nil)
            moviePopularityView.isHidden = false
        } else {
            moviePopularityView.isHidden = true
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

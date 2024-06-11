//
//  StampView.swift
//  MovieApp-Programmatic
//
//  Created by zeynep on 24.04.2024.
//

import UIKit

class StampView: UIView {
    
    
    let imageContainerView: UIView = {
        let imageContainer = UIView()
        imageContainer.backgroundColor = .systemGreen
        imageContainer.layer.cornerRadius = 5
        return imageContainer
    }()
       
    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let label: UILabel = {
       let lbl = UILabel()
        lbl.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 51/255)
        lbl.font = .bold(12)
        lbl.contentMode = .scaleAspectFill
//        lbl.minimumScaleFactor = 0.5
        return lbl
    }()
    
    let stackView: UIStackView = {
        let stackV = UIStackView()
        stackV.axis = .horizontal
//        stackV.spacing = 5
        return stackV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
       
        
        
        setupStackView()

        setupImageContainerConstraint()
        setupImageViewConstraint()
        setupLabelConstraint()
      
    }
    func setupStackView() {
        imageContainerView.addSubview(imageView)
        stackView.addArrangedSubview(imageContainerView)
        stackView.addArrangedSubview(label)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
        
      
    }
    

    func setupImageViewConstraint() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor).isActive = true
    }
    
    func setupImageContainerConstraint() {
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        imageContainerView.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        imageContainerView.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        imageContainerView.rightAnchor.constraint(equalTo: label.leftAnchor).isActive = true
        imageContainerView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
    }
    func setupLabelConstraint() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: imageContainerView.rightAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
//        label.heightAnchor.constraint(equalTo: stackView.heightAnchor, constant: -5).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init has not been implemented")
    }
    
    func configure(title: String,
                   titleColor: UIColor = .white,
                   backgroundColor: UIColor = .orange,
                   font: UIFont? = .bold(12),
                   cornerRadius: CGFloat = 5,
                   image: UIImage? = UIImage(named: "rateIcon")) {
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        label.text = title
        label.textColor = titleColor
        label.font = font
        
        if let image = image {
            imageView.image = image
        } else {
            imageContainerView.isHidden = true
        }
    }
    
    
}

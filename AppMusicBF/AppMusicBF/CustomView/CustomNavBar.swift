//
//  CustomNavBar.swift
//  AppMusicBF
//
//  Created by Felipe Augusto Correia on 29/07/23.
//

import UIKit

class CustomNavBar: UIView {
    
    lazy var categoryTitleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        lb.textColor = UIColor.white
        lb.textAlignment = .center
        return lb
    }()
    
    lazy var cardTitleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        lb.textColor = UIColor.white
        lb.textAlignment = .center
        return lb
    }()
    
    lazy var featureLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .center
        lb.textColor = UIColor.white
        return lb
    }()
    
    lazy var cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var overlayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black.withAlphaComponent(0.7)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(cardImageView)
        addSubview(overlayView)
        addSubview(categoryTitleLabel)
        addSubview(cardTitleLabel)
        addSubview(featureLabel)
    }
    
    private func setupConstraints() {
        cardImageView.pin(to: self)
        overlayView.pin(to: self)
        
        NSLayoutConstraint.activate([
            categoryTitleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5),
            categoryTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            categoryTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            cardTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            cardTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            cardTitleLabel.topAnchor.constraint(equalTo: self.categoryTitleLabel.bottomAnchor, constant: 5),
            
            featureLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            featureLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            featureLabel.topAnchor.constraint(equalTo: self.cardTitleLabel.bottomAnchor, constant: 5),
        ])
    }
    
    public func setupView(data: CardViewModel) {
        cardTitleLabel.text = data.cardTitle
        categoryTitleLabel.text = data.categoryName
        cardImageView.image = UIImage(named: data.cardImage ?? "")
        featureLabel.attributedText = .featureText(data.likeCount ?? "", data.duration ?? "")
    }
}

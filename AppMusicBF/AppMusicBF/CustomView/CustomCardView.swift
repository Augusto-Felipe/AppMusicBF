//
//  CustomCardView.swift
//  AppMusicBF
//
//  Created by Felipe Augusto Correia on 27/07/23.
//

import UIKit

enum ViewMode {
    case full
    case card
}

class CustomCardView: UIView {
    
    // MARK: - PROPRIEDADES
    
    var dataModel: CardViewModel?
    var containerLeadingConstraints: NSLayoutConstraint?
    var containerTopConstraints: NSLayoutConstraint?
    var containerTrailingConstraints: NSLayoutConstraint?
    var containerBottomConstraints: NSLayoutConstraint?
    
    // MARK: - ELEMENTOS
    // View do Card
    lazy var cardContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: -2)
        view.layer.shadowRadius = 20
        return view
    }()
    
    // Imagem sobre o card
    lazy var cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .black
        return imageView
    }()
    
    // View que escurece a imagem do card
    lazy var overlayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        return view
    }()
    
    // Bordas em volta da imagem de perfil
    lazy var profileBorderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 25
        return view
    }()
    
    // Imagem do perfil
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    // Botão adicionar sobre a imagem de perfil
    lazy var addProfileImageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setBackgroundImage(UIImage(named: "plus"), for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    // Categoria da musica
    lazy var cardCategoryTitleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        lb.textColor = UIColor.white
        return lb
    }()
    
    // Data categoria
    lazy var cardCategoryDateLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        lb.textColor = UIColor.white
        return lb
    }()
    
    // Título
    lazy var cardTitleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        lb.textColor = UIColor.white
        lb.textAlignment = .center
        return lb
    }()
    
    // Gostei e Tempo
    lazy var likeAndTimeLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    // Descrição do título
    lazy var descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        lb.textColor = UIColor.white
        lb.textAlignment = .center
        lb.numberOfLines = 0
        return lb
    }()
    
    // Card action view
    lazy var actionsView: CardActionView = {
        let view = CardActionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(vmode: ViewMode) {
        let frame = CGRect.zero
        super.init(frame: frame)
        self.addElements()
        self.setupConstraints()
        self.updateLayout(for: vmode)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(cardContainerView)
        cardContainerView.addSubview(cardImageView)
        cardContainerView.addSubview(overlayView)
        cardContainerView.addSubview(profileBorderView)
        cardContainerView.addSubview(profileImageView)
        cardContainerView.addSubview(addProfileImageButton)
        cardContainerView.addSubview(cardCategoryTitleLabel)
        cardContainerView.addSubview(cardCategoryDateLabel)
        cardContainerView.addSubview(cardTitleLabel)
        cardContainerView.addSubview(likeAndTimeLabel)
        cardContainerView.addSubview(descriptionLabel)
        cardContainerView.addSubview(actionsView)
    }
    
    private func setupConstraints() {
        self.containerLeadingConstraints = cardContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30)
        self.containerLeadingConstraints?.isActive = true
        self.containerTopConstraints = cardContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15)
        self.containerTopConstraints?.isActive = true
        self.containerBottomConstraints = cardContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)
        self.containerBottomConstraints?.isActive = true
        self.containerTrailingConstraints = cardContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
        self.containerTrailingConstraints?.isActive = true
        
        self.overlayView.pin(to: self.cardContainerView)
        self.cardImageView.pin(to: self.cardContainerView)
        
        NSLayoutConstraint.activate([
            self.profileBorderView.topAnchor.constraint(equalTo: cardContainerView.topAnchor, constant: 60),
            self.profileBorderView.centerXAnchor.constraint(equalTo: cardContainerView.centerXAnchor),
            self.profileBorderView.widthAnchor.constraint(equalToConstant: 50),
            self.profileBorderView.heightAnchor.constraint(equalToConstant: 50),
            
            self.addProfileImageButton.trailingAnchor.constraint(equalTo: self.profileBorderView.trailingAnchor, constant: 4),
            self.addProfileImageButton.bottomAnchor.constraint(equalTo: self.profileBorderView.bottomAnchor, constant: 4),
            self.addProfileImageButton.heightAnchor.constraint(equalToConstant: 20),
            self.addProfileImageButton.widthAnchor.constraint(equalToConstant: 20),
            
            self.profileImageView.centerXAnchor.constraint(equalTo: self.profileBorderView.centerXAnchor),
            self.profileImageView.centerYAnchor.constraint(equalTo: self.profileBorderView.centerYAnchor),
            self.profileImageView.heightAnchor.constraint(equalToConstant: 40),
            self.profileImageView.widthAnchor.constraint(equalToConstant: 40),
            
            self.cardCategoryTitleLabel.topAnchor.constraint(equalTo: self.profileBorderView.bottomAnchor, constant: 10),
            self.cardCategoryTitleLabel.centerXAnchor.constraint(equalTo: self.cardContainerView.centerXAnchor),
            
            self.cardCategoryDateLabel.topAnchor.constraint(equalTo: self.cardCategoryTitleLabel.bottomAnchor, constant: 2),
            self.cardCategoryDateLabel.centerXAnchor.constraint(equalTo: self.cardContainerView.centerXAnchor),
            
            self.cardTitleLabel.topAnchor.constraint(equalTo: self.cardCategoryDateLabel.bottomAnchor, constant: 20),
            self.cardTitleLabel.leadingAnchor.constraint(equalTo: self.cardContainerView.leadingAnchor, constant: 20),
            self.cardTitleLabel.trailingAnchor.constraint(equalTo: self.cardContainerView.trailingAnchor, constant: -20),
            
            self.likeAndTimeLabel.topAnchor.constraint(equalTo: self.cardTitleLabel.bottomAnchor, constant: 10),
            self.likeAndTimeLabel.centerXAnchor.constraint(equalTo: self.cardContainerView.centerXAnchor),
            
            self.descriptionLabel.topAnchor.constraint(equalTo: self.likeAndTimeLabel.bottomAnchor, constant: 30),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.cardContainerView.leadingAnchor, constant: 40),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.cardContainerView.trailingAnchor, constant: -40),
            
            self.actionsView.bottomAnchor.constraint(equalTo: self.cardContainerView.bottomAnchor, constant: -20),
            self.actionsView.leadingAnchor.constraint(equalTo: self.cardContainerView.leadingAnchor, constant: 20),
            self.actionsView.trailingAnchor.constraint(equalTo: self.cardContainerView.trailingAnchor, constant: -20),
            self.actionsView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    private func updateLayout(for mode: ViewMode) {
        switch mode {
        case .card:
            self.containerLeadingConstraints?.constant = 30
            self.containerTopConstraints?.constant = 15
            self.containerTrailingConstraints?.constant = -30
            self.containerBottomConstraints?.constant = -15
            self.descriptionLabel.isHidden = true
        case.full:
            self.containerLeadingConstraints?.constant = 0
            self.containerTopConstraints?.constant = 0
            self.containerTrailingConstraints?.constant = 0
            self.containerBottomConstraints?.constant = 0
            self.descriptionLabel.isHidden = false
        }
        self.actionsView.updateLayout(for: mode)
    }
    
    public func setupView(data: CardViewModel) {
        self.cardCategoryTitleLabel.text = data.categoryName
        self.cardCategoryDateLabel.text = data.categoryDate
        self.cardTitleLabel.text = data.cardTitle
        self.likeAndTimeLabel.attributedText = NSAttributedString.featureText(data.likeCount ?? "", data.duration ?? "")
        self.descriptionLabel.text = data.cardDescription
        self.cardImageView.image = UIImage(named: data.cardImage ?? "")
        self.profileImageView.image = UIImage(named: data.categoryImage ?? "")
    }
}

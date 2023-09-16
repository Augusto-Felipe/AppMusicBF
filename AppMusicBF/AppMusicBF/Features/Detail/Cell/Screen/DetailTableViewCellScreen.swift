//
//  DetailTableViewCellScreen.swift
//  AppMusicBF
//
//  Created by Felipe Augusto Correia on 29/07/23.
//

import UIKit

class DetailTableViewCellScreen: UIView {
    
    lazy var thumbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "demo")
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var musicTitleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Título Música"
        lb.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        lb.textColor = UIColor.black
        return lb
    }()
    
    lazy var artistLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Nome Artista"
        lb.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        lb.textColor = UIColor.lightGray
        return lb
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "love")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "more")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .lightGray
        return button
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
        addSubview(thumbImageView)
        addSubview(musicTitleLabel)
        addSubview(artistLabel)
        addSubview(likeButton)
        addSubview(moreButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            thumbImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            thumbImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            thumbImageView.widthAnchor.constraint(equalToConstant: 60),
            thumbImageView.heightAnchor.constraint(equalToConstant: 60),
            
            musicTitleLabel.leadingAnchor.constraint(equalTo: thumbImageView.trailingAnchor, constant: 15),
            musicTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 17),
            
            artistLabel.leadingAnchor.constraint(equalTo: self.thumbImageView.trailingAnchor, constant: 15),
            artistLabel.topAnchor.constraint(equalTo: musicTitleLabel.bottomAnchor, constant: 4),
            
            moreButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            moreButton.widthAnchor.constraint(equalToConstant: 35),
            moreButton.heightAnchor.constraint(equalToConstant: 35),
            moreButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            likeButton.trailingAnchor.constraint(equalTo: moreButton.leadingAnchor, constant: -15),
            likeButton.widthAnchor.constraint(equalToConstant: 35),
            likeButton.heightAnchor.constraint(equalToConstant: 35),
            likeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    public func setupCell(data: CardListModel) {
        musicTitleLabel.text = data.listTitle
        artistLabel.text = data.listSubtitle
        thumbImageView.image = UIImage(named: data.listImage ?? "")
    }
}

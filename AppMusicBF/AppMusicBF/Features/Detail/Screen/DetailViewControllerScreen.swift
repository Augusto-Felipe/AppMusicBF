//
//  DetailViewControllerScreen.swift
//  AppMusicBF
//
//  Created by Felipe Augusto Correia on 28/07/23.
//

import UIKit

protocol DetailViewControllerScreenProtocol: AnyObject {
    func closeButtonTapped()
}

class DetailViewControllerScreen: UIView {
    
    var cardModel: CardViewModel?
    var navBarTopAnchor: NSLayoutConstraint?
    var playerViewBottomAnchor: NSLayoutConstraint?
    
    var delegate: DetailViewControllerScreenProtocol?
    
    public func delegate(delegate: DetailViewControllerScreenProtocol) {
        self.delegate = delegate
    }
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.autoresizingMask = .flexibleHeight
        view.bounces = false
        view.clipsToBounds = true
        return view
    }()
    
    lazy var cardView: CustomCardView = {
        let view = CustomCardView(vmode: .full)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.cardContainerView.layer.cornerRadius = 0.0
        view.setupView(data: self.cardModel ?? CardViewModel())
        return view
    }()
    
    lazy var navBar: CustomNavBar = {
        let view = CustomNavBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.setupView(data: cardModel ?? CardViewModel())
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.tableFooterView = UIView()
        tb.showsVerticalScrollIndicator = false
        tb.isScrollEnabled = false
        tb.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        tb.separatorStyle = .none
        tb.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
        return tb
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.setBackgroundImage(UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var playerView: CustomPlayerView = {
        let pv = CustomPlayerView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    @objc func closeButtonTapped() {
        self.delegate?.closeButtonTapped()
    }
    
    init(dataView: CardViewModel?) {
        super.init(frame: CGRect())
        cardModel = dataView
        DispatchQueue.main.async {
            self.addElements()
            self.setupConstraints()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        self.addSubview(scrollView)
        self.scrollView.addSubview(cardView)
        self.scrollView.addSubview(tableView)
        self.addSubview(navBar)
        self.addSubview(closeButton)
        self.addSubview(playerView)
    }
    
    private func setupConstraints() {
        let window = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).compactMap({$0 as? UIWindowScene}).first?.windows.filter({$0.isKeyWindow}).first
        let topPadding = window?.safeAreaInsets.top
        
        scrollView.pin(to: self)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -(topPadding ?? 0)),
            cardView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 500),
            cardView.widthAnchor.constraint(equalToConstant: self.frame.size.width),
            
            tableView.topAnchor.constraint(equalTo: cardView.bottomAnchor),
            tableView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(80 * (cardModel?.cardList?.count ?? 0)) + 20),
            tableView.widthAnchor.constraint(equalToConstant: self.frame.size.width),
            tableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            closeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            navBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: ((topPadding ?? 0.0) + 80)),
            
            playerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            playerView.heightAnchor.constraint(equalToConstant: 120),
        ])
        
        self.navBarTopAnchor = self.navBar.topAnchor.constraint(equalTo: self.topAnchor, constant: -((topPadding ?? 0.0) + 60))
        self.navBarTopAnchor?.isActive = true
        
        self.playerViewBottomAnchor = self.playerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 120)
        self.playerViewBottomAnchor?.isActive = true
    }
    
    public func configDelegates(tableviewDelegate: UITableViewDelegate, tableviewDataSource: UITableViewDataSource, scrollViewDelegate: UIScrollViewDelegate) {
        tableView.delegate = tableviewDelegate
        tableView.dataSource = tableviewDataSource
        scrollView.delegate = scrollViewDelegate
    }
}

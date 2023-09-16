//
//  HomeScreen.swift
//  AppMusicBF
//
//  Created by Felipe Augusto Correia on 27/07/23.
//

import Foundation
import UIKit

class HomeScreen: UIView {
    
    lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.register(CardViewTableViewCell.self, forCellReuseIdentifier: CardViewTableViewCell.identifier)
        tb.separatorStyle = .none
        tb.tableFooterView = UIView()
        tb.showsVerticalScrollIndicator = false
        tb.backgroundColor = .clear
        return tb
    }()
    
    public func configTableView(delegate: UITableViewDelegate, datasource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = datasource
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        self.tableView.pin(to: self)
    }
}

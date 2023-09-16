//
//  DetailTableViewCell.swift
//  AppMusicBF
//
//  Created by Felipe Augusto Correia on 29/07/23.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    static let identifier: String = String(describing: DetailTableViewCell.self)
    
    private lazy var screen: DetailTableViewCellScreen = {
        let screen = DetailTableViewCellScreen()
        screen.translatesAutoresizingMaskIntoConstraints = false
        return screen
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        addElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        self.contentView.addSubview(screen)
    }
    
    private func setupConstraints() {
        screen.pin(to: self)
    }
    
    public func setupCell(data: CardListModel) {
        self.screen.setupCell(data: data)
    }
}

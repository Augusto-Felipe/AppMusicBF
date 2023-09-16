//
//  CardViewTableViewCell.swift
//  AppMusicBF
//
//  Created by Felipe Augusto Correia on 27/07/23.
//

import UIKit

class CardViewTableViewCell: UITableViewCell {

    static let identifier = String(describing: CardViewTableViewCell.self)
    
    private lazy var cardView: CustomCardView = {
        let view = CustomCardView(vmode: .card)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        addElements()
        setupConstraints()
    }
    
    public func setupCell(data: CardViewModel) {
        self.cardView.setupView(data: data)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addElements() {
        self.contentView.addSubview(self.cardView)
    }
    
    fileprivate func setupConstraints() {
        self.cardView.pin(to: self)
    }
}

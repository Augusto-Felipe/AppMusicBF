//
//  ViewController.swift
//  AppMusicBF
//
//  Created by Felipe Augusto Correia on 25/07/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var screen: HomeScreen = {
        let screen = HomeScreen()
        screen.translatesAutoresizingMaskIntoConstraints = false
        return screen
    }()
    
    override func loadView() {
        screen = HomeScreen()
        self.view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        screen.configTableView(delegate: self, datasource: self)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CardData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CardViewTableViewCell? = tableView.dequeueReusableCell(withIdentifier: CardViewTableViewCell.identifier, for: indexPath) as? CardViewTableViewCell
        cell?.setupCell(data: CardData[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.cardModel = CardData[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

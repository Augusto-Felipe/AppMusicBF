//
//  CustomPlayerView.swift
//  AppMusicBF
//
//  Created by Felipe Augusto Correia on 30/07/23.
//

import UIKit
import MarqueeLabel

class CustomPlayerView: UIView {
    
    var timer: Timer?
    var time: CGFloat = 0.0
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var marqueeLabel: MarqueeLabel = {
        let ml = MarqueeLabel()
        ml.translatesAutoresizingMaskIntoConstraints = false
        ml.font = UIFont(name: "Avenir-Heavy", size: 18)
        ml.textColor = .white.withAlphaComponent(0.8)
        ml.type = .continuous
        ml.animationCurve = .linear
        ml.fadeLength = 10.0
        ml.leadingBuffer = 30.0
        ml.trailingBuffer = 30.0
        return ml
    }()
    
    lazy var pauseImageBtn: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "pause")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white.withAlphaComponent(0.8)
        return imageView
    }()
    
    lazy var trackBar: UIProgressView = {
        let bar = UIProgressView()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.progressTintColor = .yellow.withAlphaComponent(0.8)
        bar.progress = 0
        return bar
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(imageView)
        addSubview(marqueeLabel)
        addSubview(pauseImageBtn)
        addSubview(trackBar)
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(changeTrackBar), userInfo: nil, repeats: true)
    }
    
    @objc func changeTrackBar() {
        self.time += 0.001
        self.trackBar.progress = Float(self.time / 120)
        if self.time >= 120 {
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 90),
            
            marqueeLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 10),
            marqueeLabel.trailingAnchor.constraint(equalTo: self.pauseImageBtn.leadingAnchor, constant: -5),
            marqueeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 32),
            
            pauseImageBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            pauseImageBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            pauseImageBtn.heightAnchor.constraint(equalToConstant: 40),
            pauseImageBtn.widthAnchor.constraint(equalToConstant: 40),
            
            trackBar.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor),
            trackBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            trackBar.topAnchor.constraint(equalTo: self.topAnchor),
        ])
    }
    
    public func setupView(data: CardListModel) {
        self.imageView.image = UIImage(named: data.listImage ?? "")
        self.marqueeLabel.text = data.listTitle
        self.time = 0.0
        self.trackBar.progress = 0.0
        self.timer = nil
        self.timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(changeTrackBar), userInfo: nil, repeats: true)
    }
}

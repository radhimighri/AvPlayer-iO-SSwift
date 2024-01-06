//
//  ViewController.swift
//  AvPlayerProject
//
//  Created by Radhi Mighri on 15/1/2023.
//  Copyright © 2023 Radhi Mighri. All rights reserved.
//

import UIKit
import AVKit

//
//protocol VideoDelegate: AnyObject {
//    func inkryptVideos_player(_ Player: AVPlayer)
//    func inkryptVideos_playView(_ PlayView: UIView)
//}

class ViewController: UIViewController {
    
    
    //MARK: - Properties
    
    @IBOutlet weak var avPlayerUIView: UIView!
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    var playPauseButton: UIButton!
    var fullScreenButton: UIButton!
    var playerViewController: AVPlayerViewController!
//    weak var delegate: VideoDelegate?
//    delegate?.inkryptVideos_player(player)
//    delegate?.inkryptVideos_playView(playerViewController.view)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayer()
        setupUI()
     }
    
    
    //MARK: - Helpers
    
    func setupPlayer() {
        let url = URL(string: "https://cloud-49385.inkryptvideos.com/media/_test_content/11_hls_ts/master.m3u8")!
        player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
    }
    
    func setupUI() {
        playerLayer.frame = avPlayerUIView.bounds
        avPlayerUIView.layer.addSublayer(playerLayer)
        playPauseButton = UIButton(type: .system)
        playPauseButton.setTitle("Play", for: .normal)
        playPauseButton.addTarget(self, action: #selector(playPause), for: .touchUpInside)
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        avPlayerUIView.addSubview(playPauseButton)
        fullScreenButton = UIButton(type: .system)
        fullScreenButton.setTitle("Full Screen", for: .normal)
        fullScreenButton.addTarget(self, action: #selector(goFullScreen), for: .touchUpInside)
        fullScreenButton.translatesAutoresizingMaskIntoConstraints = false
        avPlayerUIView.addSubview(fullScreenButton)
        
        // Add constraints to position the buttons
        NSLayoutConstraint.activate([
            playPauseButton.bottomAnchor.constraint(equalTo: avPlayerUIView.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            playPauseButton.leadingAnchor.constraint(equalTo: avPlayerUIView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            fullScreenButton.bottomAnchor.constraint(equalTo: avPlayerUIView.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            fullScreenButton.trailingAnchor.constraint(equalTo: avPlayerUIView.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
    }
    
    //MARK: - Actions / Selectors
    @objc func playPause() {
        if player.rate == 0 {
            playPauseButton.setTitle("Pause", for: .normal)
            player.play()
        } else {
            playPauseButton.setTitle("Play", for: .normal)
            player.pause()
        }
    }
    
    @objc func goFullScreen() {
        playerViewController = AVPlayerViewController()
        playerViewController.player = player
        present(playerViewController, animated: true, completion: nil)
    }
    
}

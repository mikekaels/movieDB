//
//  VideoTableViewCell.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 14/11/21.
//

import UIKit
import youtube_ios_player_helper

class VideoTableViewCell: UITableViewCell {
    
    let videoView: YTPlayerView = YTPlayerView()
        .configure { v in
            v.load(withVideoId: "bsM1qdGAVbU")
            v.sizeToFit()
            v.layer.cornerRadius = 15
            v.layer.masksToBounds = true
            v.translatesAutoresizingMaskIntoConstraints = false
        }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        setupViews()
    }
    
    func setupViews() {
        addSubview(videoView)
        videoView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        videoView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        videoView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        videoView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }

}

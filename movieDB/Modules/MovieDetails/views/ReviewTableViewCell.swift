//
//  ReviewTableViewCell.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 14/11/21.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    var bgView: UIView = UIView()
        .configure { v in
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    
    var profileImage: CustomImageView = CustomImageView()
        .configure(completion: { v in
            v.layer.cornerRadius = 13
            v.layer.masksToBounds = true
            v.widthAnchor.constraint(equalToConstant: 25).isActive = true
            v.heightAnchor.constraint(equalToConstant: 25).isActive = true
            v.translatesAutoresizingMaskIntoConstraints = false
        })
    
    var usernameLabel: UILabel = UILabel()
        .configure { v in
            v.textColor = .label
            v.textAlignment = .left
            v.lineBreakMode = .byWordWrapping
            v.numberOfLines = 0
            v.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    
    var reviewLabel: UILabel = UILabel()
        .configure { v in
            v.textColor = .label
            v.textAlignment = .left
            v.lineBreakMode = .byWordWrapping
            v.numberOfLines = 0
            v.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        setupViews()
    }
    
    func setupViews() {
        addSubview(bgView)
        bgView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bgView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        bgView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bgView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        
        bgView.addSubview(profileImage)
        profileImage.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 10).isActive = true
        profileImage.leftAnchor.constraint(equalTo: bgView.leftAnchor, constant: 10).isActive = true
        
        bgView.addSubview(usernameLabel)
        usernameLabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 15).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10).isActive = true
        usernameLabel.rightAnchor.constraint(equalTo: bgView.rightAnchor).isActive = true
        
        bgView.addSubview(reviewLabel)
        reviewLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 5).isActive = true
        reviewLabel.leftAnchor.constraint(equalTo: bgView.leftAnchor, constant: 10).isActive = true
        reviewLabel.rightAnchor.constraint(equalTo: bgView.rightAnchor).isActive = true
        reviewLabel.bottomAnchor.constraint(equalTo: bgView.bottomAnchor).isActive = true
    }
    
}

//
//  MovieCollectionCell.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 13/11/21.
//

import UIKit
class MovieCollectionCell: UICollectionViewCell {
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis  = .vertical
        sv.alignment = .center
        sv.distribution = .fillProportionally
        sv.translatesAutoresizingMaskIntoConstraints = false;
        return sv
    }()
    
    var image: CustomImageView = {
        let image = CustomImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var titleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var title: UILabel = {
        var title = UILabel()
        title.textColor = .label
        title.textAlignment = .center
        title.lineBreakMode = .byWordWrapping
        title.numberOfLines = 2
        title.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = self.frame.height / 20
        self.layer.masksToBounds = true
//        self.backgroundColor = .systemBlue
        addViews()
    }
    
    func addViews() {
        
        addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        stackView.addArrangedSubview(image)
        image.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        image.heightAnchor.constraint(equalToConstant: contentView.frame.height - 50).isActive = true
        image.widthAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true
        image.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//
        stackView.addArrangedSubview(titleView)
        titleView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleView.widthAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true

        titleView.addSubview(title)
        title.widthAnchor.constraint(equalTo: titleView.widthAnchor).isActive = true
        title.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
        title.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

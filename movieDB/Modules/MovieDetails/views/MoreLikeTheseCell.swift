//
//  MoreLikeTheseCell.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 13/11/21.
//

import UIKit

class moreLikeTheseCell: UICollectionViewCell {
    
    
    let image: CustomImageView = {
        let image = CustomImageView()
//        image.image = UIImage(named: "dog")
        image.contentMode = UIView.ContentMode.scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = self.frame.height / 20
        self.layer.masksToBounds = true
        addViews()
    }
    
    func addViews() {
        addSubview(image)
        image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        image.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        image.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

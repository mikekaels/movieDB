//
//  LoadingCollectionCell.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 13/11/21.
//

import UIKit

class LoadingCollectionCell: UICollectionViewCell {
    
    let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        
        return spinner
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    func addViews() {
        spinner.center = contentView.center
        addSubview(spinner)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

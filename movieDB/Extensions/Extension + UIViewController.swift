//
//  Extension + UIViewController.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 13/11/21.
//

import UIKit

extension UIViewController {
    func navigationBarAppearance() {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemBackground
            navigationController?.navigationBar.standardAppearance = appearance;
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        }
    }
}

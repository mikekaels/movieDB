//
//  EasyScroll.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 14/11/21.
//

import UIKit

final class EasyScrollView: UIScrollView {
    // https://medium.com/swift-productions/create-a-uiscrollview-programmatically-xcode-12-swift-5-3-f799b8280e30
    private var scrollView: UIScrollView { self }
    private let contentView = UIView()
    let stack = UIStackView()
    
    struct LayoutSetting {
        var widthMultiplier: CGFloat = 1
        var top: CGFloat = 1
        var bottom: CGFloat = 1
    }
    
    var layoutSetting = LayoutSetting() {
        didSet {
            stack.removeFromSuperview()
            setupStack()
        }
    }
    
    override init(frame: CGRect  = .zero) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setupViews()
    }
    
    private func setupViews() {
        setupStack()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
    }
    
    func setupScrollView(in view: UIView) {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.centerXAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
            .isActive = true
        scrollView.widthAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
            .isActive = true
        scrollView.topAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        scrollView.bottomAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            .isActive = true
        contentView.centerXAnchor
            .constraint(equalTo: scrollView.centerXAnchor)
            .isActive = true
        contentView.widthAnchor
            .constraint(equalTo: scrollView.widthAnchor)
            .isActive = true
        contentView.heightAnchor
            .constraint(greaterThanOrEqualTo: scrollView.heightAnchor)
            .isActive = true
        contentView.topAnchor
            .constraint(equalTo: scrollView.topAnchor)
            .isActive = true
        contentView.bottomAnchor
            .constraint(equalTo: scrollView.bottomAnchor)
            .isActive = true
    }
    
    private func setupStack() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)
        stack.topAnchor
            .constraint(equalTo: contentView.topAnchor,
                        constant: layoutSetting.top)
            .isActive = true
        stack.centerXAnchor
            .constraint(equalTo: contentView.centerXAnchor)
            .isActive = true
        stack.bottomAnchor
            .constraint(equalTo: contentView.bottomAnchor,
                        constant: layoutSetting.bottom)
            .isActive = true
        stack.widthAnchor
            .constraint(equalTo: contentView.widthAnchor,
                        multiplier: layoutSetting.widthMultiplier)
            .isActive = true
    }
}

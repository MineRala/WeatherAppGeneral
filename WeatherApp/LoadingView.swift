//
//  LoadingView.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 12.07.2021.
//

import Foundation
import Lottie
import UIKit

class LoadingView: UIView {
    private static let tag: Int = 1923
    
    private let viewBackground: UIVisualEffectView = {
        let style = UITraitCollection.current.userInterfaceStyle == .light ? UIBlurEffect.Style.light : UIBlurEffect.Style.dark
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = true
        return blurEffectView
    }()
    
    private let viewContainerLoadingAnimation: AnimationView = {
        let animView = AnimationView(name: "loading")
        animView.translatesAutoresizingMaskIntoConstraints = true
        return animView
    }()
    
    init() {
        super.init(frame: .zero)
       setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Set Up UI
extension LoadingView {
    func setUpUI() {
        self.tag = LoadingView.tag
        self.translatesAutoresizingMaskIntoConstraints = true
        self.addSubview(self.viewBackground)
        self.viewBackground.frame = CGRect(x: 0, y: 0, width: KeyWindow!.frame.size.width, height: KeyWindow!.frame.size.height)
        self.viewBackground.contentView.addSubview(self.viewContainerLoadingAnimation)
        self.viewContainerLoadingAnimation.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        self.viewContainerLoadingAnimation.center = self.viewBackground.center
        self.alpha = 0
        
        self.viewContainerLoadingAnimation.play(fromProgress: 0, toProgress: 0.7, loopMode: .loop) { _ in
            
        }
    }
}

// MARK: - Show / Hide
extension LoadingView {
    static func show() {
        guard let window = KeyWindow, window.viewWithTag(LoadingView.tag) == nil else { return }
        let loadingView = LoadingView()
        loadingView.alpha = 1.0
        window.addSubview(loadingView)
    }
    
    static func hide() {
        guard let window = KeyWindow, let view = window.viewWithTag(LoadingView.tag) as? LoadingView else { return }
        view.alpha = 0
        view.removeFromSuperview()
        
    }
}



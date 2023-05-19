//
//  LottieView.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 18/05/23.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var animation: String
    var loopMode: LottieLoopMode = .playOnce
    var animationSpeed: CGFloat = 1
    var completionBlock: LottieCompletionBlock?
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        
        let animationView = LottieAnimationView(configuration: LottieConfiguration(renderingEngine: .automatic))
        animationView.animation = LottieAnimation.named(animation)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.animationSpeed = animationSpeed
        animationView.play(completion: completionBlock)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {}
}

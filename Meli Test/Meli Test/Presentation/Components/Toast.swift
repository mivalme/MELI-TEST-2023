//
//  Toast.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 20/05/23.
//

import Foundation
import SwiftUI

struct Toast: ViewModifier {
    @Binding var isShowing: Bool
    
    private let duration: TimeInterval = 5
    let config: Config
    
    func body(content: Content) -> some View {
        ZStack {
            content
            toastView
        }
    }
    
    private var toastView: some View {
        VStack {
            if isShowing {
                HStack {
                    Image(systemName: config.type.icon)
                        .renderingMode(.template)
                        .foregroundColor(textColor())
                        .frame(width: 20, height: 20)
                    
                    Text(config.message)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(textColor())
                }
                .padding(.all, 12)
                .frame(maxWidth: .infinity)
                .background(backgroundColor())
                .cornerRadius(4)
                .onTapGesture {
                    isShowing = false
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        isShowing = false
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 18)
        .animation(.linear(duration: 0.3), value: isShowing)
        .transition(.opacity)
    }
    
    private func backgroundColor() -> Color {
        switch config.type {
        case .error:
            return .red
        }
    }
    
    private func textColor() -> Color {
        switch config.type {
        case .error:
            return .white
        }
    }
    
    struct Config {
        let message: String
        let type: ToastType
        
        init(message: String,
             type: ToastType) {
            self.message = message
            self.type = type
        }
    }
    
    enum ToastType {
        case error
        
        var icon: String {
            switch self {
            case .error:
                return MeliAssets.Images.closeButton
            }
        }
    }
}

extension View {
    func toast(config: Toast.Config?,
               isShowing: Binding<Bool>) -> some View {
        self.modifier(Toast(isShowing: isShowing,
                            config: config ?? .init(message: String(), type: .error)))
    }
}


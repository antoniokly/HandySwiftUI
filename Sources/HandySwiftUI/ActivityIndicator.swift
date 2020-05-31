//
//  HandySwiftUI
//  https://github.com/antoniokly/HandySwiftUI
//
//  Copyright © 2020 Antonio Yip.
//  Licensed under the MIT license. See LICENSE file.
//

import SwiftUI

public struct ActivityIndicator: View {
    @State private var isAnimating: Bool = false
    var duration: Double = 1
    let n: CGFloat = 5
    
    public var body: some View {
        GeometryReader { (geometry: GeometryProxy) in
            ForEach(0..<5) { index in
                Group {
                    Circle()
                        .frame(width: geometry.size.width / self.n, height: geometry.size.height / self.n)
                        .scaleEffect(!self.isAnimating ? 1 - CGFloat(index) / self.n : 0.2 + CGFloat(index) / self.n)
                        
                        .offset(y: geometry.size.width / 10 - geometry.size.height / 2)
                }.frame(width: geometry.size.width, height: geometry.size.height)
                    .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
                    .animation(Animation
                        .timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: self.duration)
                        .repeatForever(autoreverses: false))
            }
        }.onAppear {
            self.isAnimating = true
        }.onDisappear {
            self.isAnimating = false
        }
        .aspectRatio(1, contentMode: .fit)
        .opacity(isAnimating ? 1 : 0)
    }
}

struct ActivityIndicatorModifier: ViewModifier {
    var isAnimating: Bool
    var text: String?
    var duration: Double
    var width: CGFloat
    var color: Color?
    var opacity: Double
    
    func body(content: Content) -> some View {
        ZStack {
            content.disabled(isAnimating)
            if isAnimating {
                VStack {
                    ActivityIndicator(duration: duration)
                        .frame(width: width)
                        .foregroundColor(color)
                    if text != nil {
                        Text(text!).font(.footnote)
                    }
                }.opacity(opacity)
            }
        }
    }
}

public extension View {
    func activityIndicator(isActive: Bool,
                           text: String? = nil,
                           duration: Double = 1,
                           width: CGFloat = 50,
                           color: Color? = nil,
                           opacity: Double = 0.8) -> some View {
        return self.modifier(ActivityIndicatorModifier(isAnimating: isActive, text: text, duration: duration, width: width, color: color, opacity: opacity))
    }
}

#if DEBUG
struct ActivityIndicator_Previews: PreviewProvider {
    @State static var isProcessing = true
    static var previews: some View {
        VStack {
            Button(isProcessing ? "Processing..." : "Start") {
                self.isProcessing.toggle()
            }
        }.activityIndicator(isActive: isProcessing, text: "Loading", width: 40)
    }
}
#endif

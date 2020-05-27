//
//  HandySwiftUI
//  https://github.com/antoniokly/HandySwiftUI
//
//  Copyright © 2020 Antonio Yip.
//  Licensed under the MIT license. See LICENSE file.
//

import SwiftUI

public struct PageView<Content: View>: View {
    let pageCount: Int
    let content: (Int) -> Content
    
    @Binding var currentPage: Int
    var isNavigating: Binding<Bool>?
    @GestureState var translation: CGFloat = 0

    public init(pageCount: Int,
                currentPage: Binding<Int>,
                isNavigating: Binding<Bool>? = nil,
                @ViewBuilder content: @escaping (Int) -> Content) {
        self.pageCount = pageCount
        self._currentPage = currentPage
        self.content = content
    }

    public var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(0..<self.pageCount, id: \.self) { index in
                    self.content(index)
                        .frame(width: geometry.size.width)
                }
                .opacity(self.isNavigating?.wrappedValue == true ? 0 : 1)
                .animation(self.isNavigating?.wrappedValue == true ? .none : .default)
            }
                
            .frame(width: geometry.size.width, alignment: .leading)
            .offset(x: -CGFloat(self.currentPage) * geometry.size.width)
            .offset(x: self.translation)
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.width
                }.onEnded { value in
                    let offset = value.translation.width / geometry.size.width
                    let newIndex = (CGFloat(self.currentPage) - offset).rounded()
                    self.currentPage = min(max(Int(newIndex), 0), self.pageCount - 1)
                }
            )
            .animation(.easeOut(duration: 0.3))
        }
    }
}

struct IndicatorModifier: ViewModifier {
    @Binding var currentPage: Int
    var pageCount: Int
    var currentPageSize: CGFloat
    var defaultSize: CGFloat
    var currentPageColor: Color?
    var defaultColor: Color?
    var opacity: Double
    
    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                Spacer()
                HStack(alignment: .center) {
                    ForEach(0..<pageCount, id: \.self) {
                        Circle()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: $0 == self.currentPage ? self.currentPageSize : self.defaultSize)
                            .foregroundColor($0 == self.currentPage ? self.currentPageColor : self.defaultColor)
                            .animation(.easeOut(duration: 0.3))
                            .opacity(self.opacity)
                    }
                }
            }
            .watchOS {
                $0.edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}

public extension PageView {
    func indicator(currentPageSize: CGFloat = 8,
                   defaultSize: CGFloat = 6,
                   currentPageColor: Color? = .white,
                   defaultColor: Color? = .gray,
                   opacity: Double = 1) -> some View {
        self.modifier(IndicatorModifier(currentPage: self.$currentPage,
                                        pageCount: self.pageCount,
                                        currentPageSize: currentPageSize,
                                        defaultSize: defaultSize,
                                        currentPageColor: currentPageColor,
                                        defaultColor: defaultColor,
                                        opacity: opacity))
    }
}

#if DEBUG
struct PageView_Previews: PreviewProvider {
    @State static var currentPage = 0
    static var previews: some View {
        PageView(pageCount: 5, currentPage: self.$currentPage, isNavigating: nil) { index in
            if index == 0 {
                Color.gray
                    .frame(maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
            } else if index == 1 {
                Text("Page 2")
            } else if index == 2 {
                Text("Page 3")
            } else {
                ZStack {
                    Color.green
                    Text("Page 4")
                }
            }
        }.indicator(currentPageSize: 10,
                    defaultSize: 5,
                    currentPageColor: .accentColor,
                    defaultColor: .orange,
                    opacity: 0.8
        )
    }
}
#endif

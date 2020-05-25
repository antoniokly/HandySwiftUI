//
//  HandySwiftUI
//  https://github.com/antoniokly/HandySwiftUI
//
//  Copyright © 2020 Antonio Yip.
//  Licensed under the MIT license. See LICENSE file.
//

import SwiftUI

struct NavigationLinkModifier<Destination: View, ButtonStyle: PrimitiveButtonStyle>: ViewModifier {
    var destination: Destination
    var buttonStyle: ButtonStyle
    
    func body(content: Content) -> some View {
        NavigationLink(destination: destination) {
            content
        }.buttonStyle(buttonStyle)
    }
}

struct NavigationLinkBindingModifier<Destination: View, ButtonStyle: PrimitiveButtonStyle>: ViewModifier {
    var destination: Destination
    var buttonStyle: ButtonStyle
    @Binding var isActive: Bool
    
    func body(content: Content) -> some View {
        NavigationLink(destination: destination,
                       isActive: $isActive) {
            content
        }.buttonStyle(buttonStyle)
    }
}

struct NavigationLinkSelectionModifier<Destination: View, ButtonStyle: PrimitiveButtonStyle, Tag : Hashable>: ViewModifier {
    var destination: Destination
    var buttonStyle: ButtonStyle
    var tag: Tag
    @Binding var selction: Tag?
    
    func body(content: Content) -> some View {
        NavigationLink(destination: destination,
                       tag: tag,
                       selection: $selction) {
            content
        }.buttonStyle(buttonStyle)
    }
}


public extension View {
    func push<Destination: View, ButtonStyle: PrimitiveButtonStyle>(buttonStyle: ButtonStyle, destination: @escaping () -> Destination) -> some View {
        self.modifier(NavigationLinkModifier(destination: destination(),
                                             buttonStyle: buttonStyle))
    }
    
    func push<Destination: View>(destination: @escaping () -> Destination) -> some View {
        self.modifier(NavigationLinkModifier(destination: destination(),
                                             buttonStyle: DefaultButtonStyle()))
    }
    
    // MARK: isActive Binding
    func push<Destination: View, ButtonStyle: PrimitiveButtonStyle>(buttonStyle: ButtonStyle, isActive: Binding<Bool>, destination: @escaping () -> Destination) -> some View {
        self.modifier(NavigationLinkBindingModifier(destination: destination(),
                                                    buttonStyle: buttonStyle,
                                                    isActive: isActive))
    }
    
    func push<Destination: View>(isActive: Binding<Bool>, destination: @escaping () -> Destination) -> some View {
        self.modifier(NavigationLinkBindingModifier(destination: destination(),
                                                    buttonStyle: DefaultButtonStyle(),
                                                    isActive: isActive))
    }
    
    // MARK: selection Binding
    func push<Destination: View, ButtonStyle: PrimitiveButtonStyle, Tag : Hashable>(buttonStyle: ButtonStyle, tag: Tag, selection: Binding<Tag?>, destination: @escaping () -> Destination) -> some View {
        self.modifier(NavigationLinkSelectionModifier(destination: destination(),
                                                      buttonStyle: buttonStyle,
                                                      tag: tag,
                                                      selction: selection))
    }
    
    func push<Destination: View, Tag : Hashable>(tag: Tag, selection: Binding<Tag?>, destination: @escaping () -> Destination) -> some View {
        self.modifier(NavigationLinkSelectionModifier(destination: destination(),
                                                      buttonStyle: DefaultButtonStyle(),
                                                      tag: tag,
                                                      selction: selection))
    }
}

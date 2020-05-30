//
//  HandySwiftUI
//  https://github.com/antoniokly/HandySwiftUI
//
//  Copyright © 2020 Antonio Yip.
//  Licensed under the MIT license. See LICENSE file.
//

import SwiftUI

public extension View {
    func watchOS<Content: View>(_ modifier: @escaping (Self) -> Content) -> some View {
        #if os(watchOS)
        return modifier(self)
        #else
        return self
        #endif
    }
    
    func iOS<Content: View>(_ modifier: @escaping (Self) -> Content) -> some View {
        #if os(iOS)
        return modifier(self)
        #else
        return self
        #endif
    }

    func tvOS<Content: View>(_ modifier: @escaping (Self) -> Content) -> some View {
        #if os(tvOS)
        return modifier(self)
        #else
        return self
        #endif
    }
}

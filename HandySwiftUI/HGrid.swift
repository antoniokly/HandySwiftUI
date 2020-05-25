//
//  HandySwiftUI
//  https://github.com/antoniokly/HandySwiftUI
//
//  Copyright © 2020 Antonio Yip.
//  Licensed under the MIT license. See LICENSE file.
//

import SwiftUI

struct HGrid<Content: View>: View {
    
    public init(ratios: [CGFloat]? = nil, spacing: CGFloat = 0, @ViewBuilder content: @escaping (Int) -> Content) {
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
////    static var previews: some View {
////        HGrid()
////    }
//}

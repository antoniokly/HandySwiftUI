//
//  HandySwiftUI
//  https://github.com/antoniokly/HandySwiftUI
//
//  Copyright © 2020 Antonio Yip.
//  Licensed under the MIT license. See LICENSE file.
//

import SwiftUI

public struct HGrid<Content: View>: View {
    var fractions: [CGFloat]
    var spacing: CGFloat
    var content: (Int) -> Content
    
    public init(spacing: CGFloat = 0, ratios: [CGFloat], @ViewBuilder content: @escaping (Int) -> Content ) {
        self.spacing = spacing
        let sum = ratios.reduce(0, {$0 + $1})
        self.fractions = ratios.indices.map { i in
            let fraction = ratios[i] / sum
            return fraction
        }
        self.content = content
    }
    
    public var body: some View {
        let count = CGFloat(self.fractions.count)
        return GeometryReader { geometry in
            HStack(spacing: self.spacing) {
                ForEach(0..<self.fractions.count) { i in
                    return self.content(i).frame(width: (geometry.size.width - (self.spacing * (count - 1))) * self.fractions[i])
                }
            }
        }
    }
}

#if DEBUG
struct HGrid_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HGrid(spacing: 2,
                  ratios: [1,1,1,1],
                  content: cell)
            
            HGrid(spacing: 2,
                  ratios: [1,3],
                  content: cell)
        }
    }
    
    @ViewBuilder
    static func cell(_ index: Int) -> some View {
        if index % 2 == 0 {
            RoundedRectangle(cornerRadius: 15).foregroundColor(Color.red).opacity(0.5)
        } else {
            RoundedRectangle(cornerRadius: 15).opacity(0.5)
        }
    }
}
#endif

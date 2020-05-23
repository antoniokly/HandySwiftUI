//
//  HandySwiftUI
//  https://github.com/antoniokly/HandySwiftUI
//
//  Copyright © 2020 Antonio Yip. All rights reserved.
//  Licensed under the MIT license. See LICENSE file.
//

import SwiftUI

public struct HCollection<Content: View>: View {
    var cells: [Content]
    var fractions: [CGFloat]
    var spacing: CGFloat
    
    public init(cells: [Content], ratios: [CGFloat]? = nil, spacing: CGFloat = 0) {
        self.cells = cells
        let ratios = ratios ?? .init(repeating: 1, count: cells.count)
        let sum = ratios.prefix(cells.count).reduce(0, {$0 + $1})
        self.fractions = self.cells.indices.map { i in
            guard i < ratios.count else { return 0 }
            let fraction = ratios[i] / sum
            return fraction
        }
        self.spacing = spacing
    }
    
    public var body: some View {
        let count = CGFloat(cells.count)
        return GeometryReader { geometry in
            HStack (spacing: self.spacing) {
                ForEach(0..<self.cells.count) { i in
                    return self.cells[i].frame(width: (geometry.size.width - (self.spacing * (count - 1))) * self.fractions[i])
                }
            }
        }
    }
}

#if DEBUG
struct HCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HCollection(
                cells: [
                    Rectangle().cornerRadius(5).foregroundColor(.gray),
                    Rectangle().cornerRadius(5).foregroundColor(.gray),
                    Rectangle().cornerRadius(5).foregroundColor(.gray),
                    Rectangle().cornerRadius(5).foregroundColor(.gray)
                ],
                spacing: 2
            ).frame(height: 40)
            
            HCollection(
                cells: [
                    Rectangle().cornerRadius(5).foregroundColor(.gray),
                    Rectangle().cornerRadius(5).foregroundColor(.gray),
                ],
                ratios: [1, 3],
                spacing: 2
            ).frame(height: 50)
        }
    }
}
#endif

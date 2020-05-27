//
//  ContentView.swift
//  Showcase
//
//  Created by Antonio Yip on 27/05/20.
//

import SwiftUI
import HandySwiftUI

struct ContentView: View {
    @State var currentPage: Int = 0
    
    var body: some View {
        PageView(pageCount: 5, currentPage: $currentPage, isNavigating: nil) { index in
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

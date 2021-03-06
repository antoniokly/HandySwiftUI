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
    @State var toggle: Bool = false
    @State var isNavigating: Bool = false
    
    var body: some View {
        PageView(pageCount: 4,
                 currentPage: $currentPage,
                 isNavigating: $isNavigating,
                 content: page
        ).indicator(currentPageSize: 10,
                    defaultSize: 5,
                    currentPageColor: .accentColor,
                    defaultColor: .orange,
                    opacity: 0.8
        )
    }
    
    @ViewBuilder
    func page(_ index: Int) -> some View {
        if index == 0 {
            NavigationView{
                ZStack {
                    Color(.lightGray)
                        .frame(maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)
                    
                    Text("PUSH")
                        .push(isActive: $isNavigating) {
                            Text("View")
                    }
                }
            }
            
        } else if index == 1 {
            VStack {
                HGrid(spacing: 2,
                      ratios: [1,1,1,1],
                      content: cell)
                
                HGrid(spacing: 2,
                      ratios: [1,3],
                      content: cell)
            }.padding()
        } else if index == 2 {
            HStack {
                VGrid(spacing: 5,
                      ratios: [1,1,1,1],
                      content: cell)
                VGrid(spacing: 5,
                      ratios: [1,2,1],
                      content: cell)
            }.padding()
        } else {
            ZStack {
                Color.white
                    .frame(maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Toggle(isOn: $toggle) {
                        Text("CustomToggleStyle")
                        
                    }.toggleStyle(CustomToggleStyle())
                    
                    Divider()
                                        
                    Toggle(isOn: $toggle) {
                        Text("CustomToggleStyle").font(.largeTitle)
                    }.toggleStyle(
                        CustomToggleStyle(width: 150,
                                          height: 60,
                                          gap: 3,
                                          onText: "開",
                                          offText: "關",
                                          statusTextColor: .white,
                                          onColor: .green,
                                          offColor: .red,
                                          buttonColor: .white))
                }.padding()
            }
        }
    }
    
    @ViewBuilder
    func cell(_ index: Int) -> some View {
        if index % 2 == 0 {
            RoundedRectangle(cornerRadius: 40)
                .foregroundColor(Color.red)
                .opacity(0.5)
        } else {
            Rectangle().iOS { $0
                .foregroundColor(.blue)
            }.watchOS { $0
                .foregroundColor(.green)
                .opacity(0.5)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(currentPage: 2)
    }
}

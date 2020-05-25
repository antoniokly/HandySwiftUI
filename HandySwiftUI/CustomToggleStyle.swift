//
//  HandySwiftUI
//  https://github.com/antoniokly/HandySwiftUI
//
//  Copyright © 2020 Antonio Yip.
//  Licensed under the MIT license. See LICENSE file.
//

import SwiftUI

public struct CustomToggleStyle: ToggleStyle {
    var width: CGFloat
    var height: CGFloat
    var gap: CGFloat
    var onText: String
    var offText: String
    var statusTextColor: Color
    var onColor: Color
    var offColor: Color
    var buttonColor: Color
    
    public init(width: CGFloat = 60,
                height: CGFloat = 26,
                gap: CGFloat = 1.5,
                onText: String = "ON",
                offText: String = "OFF",
                statusTextColor: Color = .white,
                onColor: Color = .green,
                offColor: Color = .gray,
                buttonColor: Color = .white) {
        self.width = width
        self.height = height
        self.gap = gap
        self.onText = onText
        self.offText = offText
        self.statusTextColor = statusTextColor
        self.onColor = onColor
        self.offColor = offColor
        self.buttonColor = buttonColor
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        HStack(alignment: .center) {
            configuration.label
            Spacer()
            ZStack(alignment: configuration.isOn ? .trailing : .leading) {
                RoundedRectangle(cornerRadius: height / 2)
                    .frame(width: width, height: height)
                    .foregroundColor(configuration.isOn ? onColor : offColor)
                
                overlayText(configuration.isOn)
                
                Circle().frame(width: height - gap * 2, height: height - gap * 2)
                    .foregroundColor(buttonColor)
                    .padding(gap)
            }.onTapGesture {
                withAnimation {
                    configuration.$isOn.wrappedValue.toggle()
                }
            }
        }
    }
    
    private func overlayText(_ state: Bool) -> some View {
        HStack(alignment: .center) {
            Text(state ? onText : offText)
                .font(.system(size: height * 0.75, weight: .thin))
                .multilineTextAlignment(.center)
                .truncationMode(.tail)
                .minimumScaleFactor(0.5)
                .foregroundColor(statusTextColor)
        }
        .frame(width: width - height - gap * 2)
        .frame(maxHeight: height * 0.75)
        .padding(state ? .trailing : .leading, height)
    }
}

struct CustomToggleStyle_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Toggle(isOn: .constant(true)) {
                Text("Text")
            }.toggleStyle(CustomToggleStyle())
            
            Toggle(isOn: .constant(false)) {
                Text("Text")
            }.toggleStyle(CustomToggleStyle())
            
            Toggle(isOn: .constant(true)) {
                Text("Text")
            }.toggleStyle(CustomToggleStyle(onText: "開", onColor: .orange))
            
            Toggle(isOn: .constant(false)) {
                Text("Text")
            }.toggleStyle(CustomToggleStyle(width: 100, height: 40, gap: 3, offText: "關", statusTextColor: .accentColor, offColor: .red, buttonColor: .accentColor))
        }
        .previewLayout(.fixed(width: 200, height: 60))
    }
}

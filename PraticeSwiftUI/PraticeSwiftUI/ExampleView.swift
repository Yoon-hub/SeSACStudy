//
//  ExampleView.swift
//  PraticeSwiftUI
//
//  Created by 최윤제 on 2022/12/19.
//

import SwiftUI

struct ExampleView: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .font(.title)
                .foregroundColor(.blue)
                .fontWeight(.semibold)
            Spacer()
            Text("안녕하세요. hello There")
                .font(.caption)
                .italic()
            Spacer()
            Circle()
                .fill(.yellow)
            Ellipse()
                .fill(.green)
            Image(systemName: "person.fill")
            Rectangle()
                .fill(.blue)
            Spacer()
            Text("이게 가능하다고\n세번째, 두번쨰\n 바보야")
                .underline()
                .strikethrough()
                .lineLimit(2)
                .kerning(10)
        }
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
            .previewDevice("iPhone 11")
    }
}


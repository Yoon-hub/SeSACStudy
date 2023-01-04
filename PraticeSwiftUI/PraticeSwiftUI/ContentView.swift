//
//  ContentView.swift
//  PraticeSwiftUI
//
//  Created by 최윤제 on 2022/12/19.
//

import SwiftUI
// iOS13+ WWDC19
// iOS13, iOS14, iOS15 ...


struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "star.fill")
                .imageScale(.large)
                .foregroundColor(Color.red)
            Text("안녕하세유")
        }
        .padding()
        //.frame(width: 200, height: 400)
        .border(.red)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.green)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

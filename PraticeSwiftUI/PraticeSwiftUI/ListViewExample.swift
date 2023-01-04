//
//  ListViewExample.swift
//  PraticeSwiftUI
//
//  Created by 최윤제 on 2022/12/19.
//

import SwiftUI

struct ListViewExample: View {
    var body: some View {
        List {
            Text("1위")
            Text("2위")
            Text("3위")
            Text("4위")
                .font(.subheadline)
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.center)
            Text("5위")
                .foregroundColor(.yellow)

            ForEach(0..<50) {
                Text("리스트셀\($0)")
            }
  
        }
        .listStyle(.plain)
        .font(.title)
    }
}

struct ListViewExample_Previews: PreviewProvider {
    static var previews: some View {
        ListViewExample()
    }
}

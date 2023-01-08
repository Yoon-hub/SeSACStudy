//
//  InputView.swift
//  PraticeSwiftUI
//
//  Created by 최윤제 on 2023/01/05.
//

import SwiftUI

/*
 StoryBoard + SwiftUI -> UIHostingController
 SwiftUI + Storyboard -> UIViewRepresentable / UIViewControllerRepresentable
 
 */

struct UserTextView: View {
    
    @Binding var text: String
    
    var body: some View {
        Text(text)
    }
}

struct ChatTextView: UIViewRepresentable {
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> some UITextView {
        let textview = UITextView()
        textview.backgroundColor = .lightGray
        return textview
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.text = text
    }
}

struct InputView: View {
    
    @State private var nickname = ""
    
    var body: some View {
        VStack {
            TextField("닉네임을 입력해주세요", text: $nickname )
                .padding()
                .lineLimit(2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            //UserTextView(text: $nickname)
            ChatTextView(text: $nickname)
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
}

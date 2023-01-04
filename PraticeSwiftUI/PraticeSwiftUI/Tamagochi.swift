//
//  SwiftUIView.swift
//  PraticeSwiftUI
//
//  Created by 최윤제 on 2023/01/04.
//

import SwiftUI

//불투명 타입 (Opaque Type) <-> 제네릭의 반대
//Swift View에서는 불투명 타입 오파큐타입이 중요하다!!!!
// 프로퍼티 내부에서는 실제 타입이 어떤지 명확하게 알 수 있음.
//프로퍼티 외부에서는 어떤 타입인지 알 수 없음.
//Swift 5.1 some, propertyWrapper

struct GrowButton: View {
    var text: String
    var icon: Image
    var action: (() -> Void)
    var body: some View {
        Button(action: action) {
            icon
            Text(text)
        }
        .padding()
        .background(.black)
        .foregroundColor(.white)
        .cornerRadius(20)
    }
}

//struct ComputedProperty: View { // View Immutable 하기 때문에 안된다 문법적으로 가능하지만
//    @State var apple = "사과" // 구조체는 변경이 안되니까 Property Wrapper
//
//    var body: some View {
//        apple = "바나나"
//        Text(apple)
//
//    }
//}


struct Tamagochi: View {
    
    @State var riceCount: Int = 0 // 구조체에서는 View프로토콜의 특성 때문에 Mutating 키워드를 사용할 수 없는데 그럴때 사용하는게 State 키워드이다
    @State var waterCount: Int = 0
    
    var body: some View { // 프로토콜 형태로 타입을 명시
        //뷰 렌더링 데이터가 바뀌는 시점에 다시 그려진다
        VStack(spacing:10) {
            Text("방실방실 다마고치")
            Text("Lv 1. 밥알 \(riceCount)개 물방을 \(waterCount)개")
            
            GrowButton(text: "밥먹기", icon: Image(systemName: "star")) {
                riceCount += 1
            }
            
            GrowButton(text: "물먹기", icon: Image(systemName: "pencil")) {
                waterCount += 1
            }
      
            
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        //GrowButton()
        Tamagochi()
    }
}

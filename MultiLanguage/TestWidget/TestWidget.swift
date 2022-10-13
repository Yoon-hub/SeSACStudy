//
//  TestWidget.swift
//  TestWidget
//
//  Created by 최윤제 on 2022/10/07.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct TestWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            Text("오늘     ")
                .fontWeight(.bold)
                .font(.system(size: 18))
                .frame(width: 100, height: 12, alignment: .center)
            Divider()
            VStack {
                ForEach(1..<4) { _ in
                    CellView(text: "흠 이건 나도 진짜", imageName: "square")
                        .frame(height: 27, alignment: .leading)
                    //Spacer()
                    
                }
            }
            
            Spacer()
            
        }.padding(EdgeInsets(top: 14, leading: 20, bottom: 14, trailing: 0))
    }
}

@main
struct TestWidget: Widget {
    let kind: String = "com.sesac.MultiLanguage"
    
    //  Configuration. 위젯을 식별하며, 위젯의 Content를 표시하면 SwiftUI View를 정의.
    // kind: 고유한 key값 위에서 선언
    // provider: 위젯을 새로고침할 타임라인을 결정하는 객체
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TestWidgetEntryView(entry: entry)
        }
        //사용자가 보게될 위젯 이름과 설명
        .configurationDisplayName("Plain ToDo")
        .description("오늘 할 일을 확인 해보세요!")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct TestWidget_Previews: PreviewProvider {
    static var previews: some View {
        TestWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

struct CellView: View {
    let text: String
    let imageName: String
    
    var body: some View {
        
        HStack{
            Image(systemName: imageName)
                .foregroundColor(.gray)
            Text(text)
                .font(.system(size: 12))
           Spacer()
        }
    }
}

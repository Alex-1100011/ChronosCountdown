//
//  ChronosWidget.swift
//  ChronosWidget
//
//  Created by Alessandro Alberti on 11/09/22.
//

import WidgetKit
import SwiftUI
import Intents

//MARK: Timeline
struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: SelectCounterIntent())
    }

    func getSnapshot(for configuration: SelectCounterIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: SelectCounterIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: SelectCounterIntent
}

//MARK: View
struct ChronosWidgetEntryView : View {
    var entry: Provider.Entry
    let data = DataController()
    @Environment (\.widgetFamily) var family

    var body: some View {
        if let name = entry.configuration.counter?.name{
            if let counter = data.getCounterNamed(name){
                
                switch family {
                case .systemSmall:
                    CounterCardView(counter: counter, isSmall: true)
                    
                case .systemMedium:
                    CounterCardView(counter: counter)
                    
                case .systemLarge:
                    CounterCardView(counter: counter)
                    
                case .systemExtraLarge:
                    CounterCardView(counter: counter)
                    
                case .accessoryCircular:
                    Color.black
                    
                case .accessoryRectangular:
                    Color.black
                    
                case .accessoryInline:
                    Label(
                        "\(counter.getCounterComponents(type: .showOnlyDays).days) days",
                        systemImage: counter.symbolName
                    )
                     
                @unknown default:
                    Text("Error")
                }
                
            } else {
                Text("🚨 Error: \(name) not found")
            }
        } else {
            Text("🚨 Error: configuration is nil ")
        }
    }
}

//MARK: Widget
@main
struct ChronosWidget: Widget {
    let kind: String = "ChronosWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: SelectCounterIntent.self, provider: Provider()) { entry in
            ChronosWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Single Counter")
        .description("Displays a single counter.")
        .supportedFamilies([.accessoryRectangular,.accessoryCircular,.accessoryInline, .systemSmall, .systemMedium, .systemLarge, .systemExtraLarge])
    }
}

struct ChronosWidget_Previews: PreviewProvider {
    static var previews: some View {
        ChronosWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: SelectCounterIntent()))
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
    }
}

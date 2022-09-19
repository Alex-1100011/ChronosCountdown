//
//  ChronosWidget.swift
//  ChronosWidget
//
//  Created by Alessandro Alberti on 11/09/22.
//

import WidgetKit
import SwiftUI
import Intents

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

struct ChronosWidgetEntryView : View {
    var entry: Provider.Entry
    let data = DataController()

    var body: some View {
        if let name = entry.configuration.counter?.name{
            if let counter = data.getCounterNamed(name){
                
                CounterCardView(counter: counter)
                
            } else {
                Text("🚨 Error: \(name) not found")
            }
        } else {
            Text("🚨 Error: configuration is nil ")
        }
    }
}

@main
struct ChronosWidget: Widget {
    let kind: String = "ChronosWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: SelectCounterIntent.self, provider: Provider()) { entry in
            ChronosWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Single Counter")
        .description("Displays a single counter.")
    }
}

struct ChronosWidget_Previews: PreviewProvider {
    static var previews: some View {
        ChronosWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: SelectCounterIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

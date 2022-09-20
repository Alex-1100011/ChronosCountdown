//
//  ChronosWidget.swift
//  ChronosWidget
//
//  Created by Alessandro Alberti on 11/09/22.
//

import WidgetKit
import SwiftUI
import Intents

//MARK: Timeline Provider
struct Provider: IntentTimelineProvider {
    
    func recommendations() -> [IntentRecommendation<SelectCounterIntent>] {
        let data = DataController()
        
        let recommendations: [IntentRecommendation<SelectCounterIntent>] = data.counters.map { counter in
            let intent = SelectCounterIntent()
            intent.counter?.name = counter.name
            return IntentRecommendation(intent: intent, description: counter.name)
        }
        
        return recommendations
    }
    
    func placeholder(in context: Context) -> CounterTimelineEntry {
        CounterTimelineEntry(date: Date(), configuration: SelectCounterIntent())
    }

    func getSnapshot(for configuration: SelectCounterIntent, in context: Context, completion: @escaping (CounterTimelineEntry) -> ()) {
        let entry = CounterTimelineEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: SelectCounterIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        var entries: [CounterTimelineEntry] = []
        let currentDate = Date()
        //Generate a timeline consisting of seven entries a day apart, starting from the current date.
        for dayOffset in 0 ..< 7 {
            var entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            //Change the date's time to the start of the date
            entryDate = Calendar.current.startOfDay(for: entryDate)
            let entry = CounterTimelineEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

//MARK: Counter Timeline Entry
struct CounterTimelineEntry: TimelineEntry {
    var date: Date
    var counter: Counter
    
    init(date: Date, configuration: SelectCounterIntent) {
        self.date = date
        
        //Retrieves the intent configuration counter from the CoreData Persistent Store
        let data = DataController()
        let counterName = configuration.counter?.name
        self.counter = data.getCounterNamed(counterName) ?? Counter(days: 3)
        
        self.counter.referenceDate = date
        
    }
    
    init(date: Date, counter: Counter){
        self.date = date
        self.counter = counter
        
        self.counter.referenceDate = date
    }
}

//MARK: Views
struct ChronosWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment (\.widgetFamily) var family
    
    var body: some View {
        
        switch family {
        case .systemSmall:
            CounterCardView(counter: entry.counter, isSmall: true)
            
        case .systemMedium:
            CounterCardView(counter: entry.counter)
            
        case .systemLarge:
            CounterCardView(counter: entry.counter)
            
        case .systemExtraLarge:
            CounterCardView(counter: entry.counter)
            
        //MARK: circular
        case .accessoryCircular:
            ZStack {
                AccessoryWidgetBackground()
                VStack(spacing: -2) {
                    Text("\(entry.counter.getCounterComponents(type: .showOnlyDays).days)")
                        .font(Font.system(.title, design: .rounded))
                        
                    Image(systemName: entry.counter.symbolName)
                        .foregroundColor(entry.counter.color)
                        .widgetAccentable()
                }
            }
        //MARK: rectangular
        case .accessoryRectangular:
            VStack(alignment: .leading, spacing: 0) {
                Label(entry.counter.name,systemImage: entry.counter.symbolName)
                    .fontWeight(.medium)
                    .foregroundColor(entry.counter.color)
                    .widgetAccentable()
                
                CounterTopView(counter: entry.counter, type: .showWeeks, daysSize: 30, subtitleSize: 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        //MARK: inline
        case .accessoryInline:
            HStack {
                Image(systemName: entry.counter.symbolName)
                    .foregroundColor(entry.counter.color)
                    .widgetAccentable()
                Text("\(entry.counter.getCounterComponents(type: .showOnlyDays).days) days")
            }
             
        @unknown default:
            Text("Error")
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
#if os (watchOS)
        .supportedFamilies([.accessoryRectangular,.accessoryCircular,.accessoryInline])
#else
        .supportedFamilies([.accessoryRectangular,.accessoryCircular,.accessoryInline, .systemSmall, .systemMedium, .systemLarge, .systemExtraLarge])
#endif
    }
}

//MARK: Preview
struct ChronosWidget_Previews: PreviewProvider {
    static var counter = Counter(name: "Trip to SF", date: Date() + 39 * 24 * 60 * 60, color: .blue, symbolName: "airplane")
    
    static var previews: some View {
#if os (iOS)
        ChronosWidgetEntryView(entry: CounterTimelineEntry(date: Date(),counter: counter))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            .previewDisplayName("systemSmall")
        
        ChronosWidgetEntryView(entry: CounterTimelineEntry(date: Date(),counter: counter))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
            .previewDisplayName("systemMedium")
#endif
        
        ChronosWidgetEntryView(entry: CounterTimelineEntry(date: Date(),counter: counter))
            .previewContext(WidgetPreviewContext(family: .accessoryInline))
            .previewDisplayName("accessoryInline")
        
        ChronosWidgetEntryView(entry: CounterTimelineEntry(date: Date(),counter: counter))
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
            .previewDisplayName("accessoryCircular")
        
        ChronosWidgetEntryView(entry: CounterTimelineEntry(date: Date(),counter: counter))
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
            .previewDisplayName("accessoryRectangular")
    }
}

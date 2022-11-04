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
            intent.counter = CounterSelection(
                identifier: counter.id.uuidString,
                display: counter.name)
            
            intent.counter?.name = counter.name
            intent.counter?.id = counter.id.uuidString
            
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
        let counterID = UUID(uuidString: (configuration.counter?.id) ?? "") ?? UUID()
        self.counter = data.getCounter(from: counterID) ?? Counter(days: 3)
        
        //Adjust the date to count from with the Intent date
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
    @ScaledMetric var padding: CGFloat = 14
    
    var body: some View {
        
        switch family {
        //MARK: Small
        case .systemSmall:
            CounterCardView(counter: entry.counter, isSmall: true, padding: padding)
            
        //MARK: Medium
        case .systemMedium:
            CounterCardView(counter: entry.counter, padding: padding)
            
        //MARK: Large
        case .systemLarge:
            CounterCardView(counter: entry.counter)
            
        //MARK: XL
        case .systemExtraLarge:
            CounterCardView(counter: entry.counter)
            
        //MARK: circular
        case .accessoryCircular:
            CircularWidget(counter: entry.counter)
                .widgetLabel{
                    Text("\(entry.counter.name)")
                }
            
        //MARK: rectangular
        case .accessoryRectangular:
            RectangularWidget(counter: entry.counter)
            
        //MARK: inline
        case .accessoryInline:
            HStack {
                Image(systemName: entry.counter.symbolName)
                    .foregroundColor(entry.counter.color)
                    .widgetAccentable()
                    .symbolVariant(.fill)
                Text("\(entry.counter.getCounterComponents(type: .showOnlyDays).days) days")
            }
#if os (watchOS)
        //MARK: corner
        case .accessoryCorner:
            Image(systemName: entry.counter.symbolName)
                .font(.system(size: 30))
                .foregroundColor(entry.counter.color)
                .widgetAccentable()
                .symbolVariant(.fill)
            
                .widgetLabel{
                    Text("\(entry.counter.getCounterComponents(type: .showOnlyDays).days) days")
                }
#endif
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
        .configurationDisplayName("Single Countdown")
        .description("Displays a single countdown.")
#if os (watchOS)
        .supportedFamilies([.accessoryRectangular,.accessoryCircular,.accessoryInline, .accessoryCorner])
#else
        .supportedFamilies([.accessoryRectangular,.accessoryCircular,.accessoryInline, .systemSmall, .systemMedium])
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

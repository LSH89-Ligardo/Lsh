//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by Jungman Bae on 1/22/25.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(date: Date(), city: "-", temperature: 0, description: "-", icon: "circle.fill", image: "thunder", url: thunderUrl)
    }

    func snapshot(for configuration: SelectCharacterIntent, in context: Context) async -> WeatherEntry {
        return londonTimeline[0]
    }
    
    func timeline(for configuration: SelectCharacterIntent, in context: Context) async -> Timeline<WeatherEntry> {

        return Timeline(entries: londonTimeline, policy: .atEnd)
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct WeatherWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) private var widgetFamily

    var body: some View {
        ZStack {
            Color("weatherBackgroundColor")
            HStack {
                WeatherSubView(entry: entry)
                if widgetFamily == .systemMedium {
                    Image(entry.image)
                        .resizable()
                }
            }
        }
        .widgetURL(entry.url)
    }
}

struct WeatherSubView: View {
    var entry: WeatherEntry
    
    var body: some View {
        VStack {
            VStack {
                Text("\(entry.city)")
                    .font(.title)
                Image(systemName: entry.icon)
                Text("\(entry.description)")
                    .frame(minWidth: 125, minHeight: nil)
            }
            .padding(.bottom, 2)
            .background(ContainerRelativeShape()
                .fill(Color("weatherInsetColor")))
            
            Label("\(entry.temperature)°F", systemImage: "thermometer")
        }
        .foregroundColor(.white)
        .padding()
    }
}

struct WeatherWidget: Widget {
    let kind: String = "WeatherWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind,
                               intent: SelectCharacterIntent.self,
                               provider: Provider()) { entry in
            WeatherWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .contentMarginsDisabled()
        .configurationDisplayName("My Weather Widget")
        .description("A demo weather widget")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    WeatherWidget()
} timeline: {
    londonTimeline[0]
    miamiTimeline[0]
}

#Preview(as: .systemMedium) {
    WeatherWidget()
} timeline: {
    londonTimeline[0]
    miamiTimeline[0]
}


import WidgetKit
import SwiftUI

// MARK: - Widget Data

/// A single verse entry for the widget. Self-contained — the widget extension
/// runs in its own process and cannot import the app's models directly.
struct WidgetVerse: Identifiable {
    let id: Int
    let arabic: String
    let english: String
    let attribution: String
}

/// A compact set of verses embedded in the widget for daily rotation.
enum WidgetVerseData {
    static let verses: [WidgetVerse] = [
        WidgetVerse(id: 0,
            arabic: "إِنَّ مَعَ الْعُسْرِ يُسْرًا",
            english: "Indeed, with hardship comes ease.",
            attribution: "Surah Ash-Sharh 94:6"),
        WidgetVerse(id: 1,
            arabic: "أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ",
            english: "Verily, in the remembrance of Allah do hearts find rest.",
            attribution: "Surah Ar-Ra'd 13:28"),
        WidgetVerse(id: 2,
            arabic: "لَئِن شَكَرْتُمْ لَأَزِيدَنَّكُمْ",
            english: "If you are grateful, I will surely increase you.",
            attribution: "Surah Ibrahim 14:7"),
        WidgetVerse(id: 3,
            arabic: "لَا تَقْنَطُوا مِنْ رَحْمَةِ اللَّهِ",
            english: "Do not despair of the mercy of Allah.",
            attribution: "Surah Az-Zumar 39:53"),
        WidgetVerse(id: 4,
            arabic: "وَهُوَ مَعَكُمْ أَيْنَ مَا كُنتُمْ",
            english: "And He is with you wherever you are.",
            attribution: "Surah Al-Hadid 57:4"),
        WidgetVerse(id: 5,
            arabic: "وَبَشِّرِ الصَّابِرِينَ",
            english: "And give glad tidings to the patient ones.",
            attribution: "Surah Al-Baqarah 2:155"),
        WidgetVerse(id: 6,
            arabic: "فَاذْكُرُونِي أَذْكُرْكُمْ وَاشْكُرُوا لِي",
            english: "So remember Me; I will remember you. And be grateful to Me.",
            attribution: "Surah Al-Baqarah 2:152"),
        WidgetVerse(id: 7,
            arabic: "عَجَبًا لِأَمْرِ الْمُؤْمِنِ، إِنَّ أَمْرَهُ كُلَّهُ خَيْرٌ",
            english: "Wondrous is the affair of the believer — all of it is good.",
            attribution: "Sahih Muslim 2999"),
    ]

    /// Returns the verse for a given day, rotating daily.
    static func verseForDate(_ date: Date) -> WidgetVerse {
        let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: date) ?? 1
        return verses[(dayOfYear - 1) % verses.count]
    }
}

// MARK: - Timeline

struct AyanProvider: TimelineProvider {
    nonisolated func placeholder(in context: Context) -> AyanEntry {
        AyanEntry(date: .now, verse: WidgetVerseData.verseForDate(.now))
    }

    nonisolated func getSnapshot(in context: Context, completion: @escaping (AyanEntry) -> Void) {
        completion(AyanEntry(date: .now, verse: WidgetVerseData.verseForDate(.now)))
    }

    nonisolated func getTimeline(in context: Context, completion: @escaping (Timeline<AyanEntry>) -> Void) {
        let now = Date()
        let verse = WidgetVerseData.verseForDate(now)

        // Refresh at the start of each day
        let calendar = Calendar.current
        let nextRefresh = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: now) ?? now)

        let entry = AyanEntry(date: now, verse: verse)
        completion(Timeline(entries: [entry], policy: .after(nextRefresh)))
    }
}

struct AyanEntry: TimelineEntry {
    let date: Date
    let verse: WidgetVerse
}

// MARK: - Widget Colors

struct WidgetPalette {
    let bg: Color
    let text: Color
    let accent: Color
    let subtext: Color

    static let darkMinimal = WidgetPalette(
        bg: Color(red: 0.07, green: 0.07, blue: 0.07),
        text: Color(red: 0.98, green: 0.96, blue: 0.92),
        accent: Color(red: 0.79, green: 0.66, blue: 0.38),
        subtext: Color(red: 0.60, green: 0.58, blue: 0.54)
    )
}

// MARK: - Widget Views

struct AyanWidgetEntryView: View {
    let entry: AyanEntry
    @Environment(\.widgetFamily) private var family

    private let palette = WidgetPalette.darkMinimal

    var body: some View {
        switch family {
        case .accessoryCircular:
            circularView
        case .accessoryInline:
            inlineView
        case .accessoryRectangular:
            rectangularView
        default:
            homeScreenView
        }
    }

    // MARK: - Home screen widget

    private var homeScreenView: some View {
        VStack(spacing: 8) {
            // Crescent ornament
            HStack {
                Text("MUSLIM WIDGETS")
                    .font(.system(size: 9, weight: .bold, design: .rounded))
                    .tracking(2)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
                    .foregroundStyle(palette.accent)
                Spacer()
                crescent
            }

            // Arabic
            Text(entry.verse.arabic)
                .font(.system(size: family == .systemLarge ? 26 : 20, weight: .medium, design: .serif))
                .foregroundStyle(palette.text)
                .lineSpacing(6)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 4)

            // English
            Text(entry.verse.english)
                .font(.system(size: family == .systemLarge ? 14 : 12, weight: .regular, design: .serif))
                .foregroundStyle(palette.text.opacity(0.8))
                .lineSpacing(4)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)

            // Attribution
            Text(entry.verse.attribution)
                .font(.system(size: 9, weight: .semibold, design: .rounded))
                .foregroundStyle(palette.accent.opacity(0.8))
        }
        .containerBackground(for: .widget) {
            palette.bg
        }
    }

    // MARK: - Lock screen (accessoryRectangular)

    private var rectangularView: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(entry.verse.english)
                .font(.system(size: 12, weight: .medium, design: .serif))
                .lineLimit(2)
            Text(entry.verse.attribution)
                .font(.system(size: 9, weight: .semibold, design: .rounded))
                .foregroundStyle(.secondary)
        }
        .containerBackground(for: .widget) {
            Color.clear
        }
    }

    // MARK: - Lock screen (accessoryCircular)

    private var circularView: some View {
        ZStack {
            // Use AccessoryWidgetBackground for the circular widget
            AccessoryWidgetBackground()
            VStack(spacing: 1) {
                Image(systemName: "moon.stars.fill")
                    .font(.system(size: 14))
                Text(entry.verse.attribution)
                    .font(.system(size: 7, weight: .semibold, design: .rounded))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            .padding(4)
        }
        .containerBackground(for: .widget) {
            Color.clear
        }
    }

    // MARK: - Lock screen (accessoryInline)

    private var inlineView: some View {
        Text("Muslim Widgets — \(entry.verse.english)")
            .containerBackground(for: .widget) {
                Color.clear
            }
    }

    // MARK: - Crescent ornament

    private var crescent: some View {
        ZStack {
            Circle()
                .fill(palette.accent)
                .frame(width: 8, height: 8)
            Circle()
                .fill(palette.bg)
                .frame(width: 7, height: 7)
                .offset(x: 2)
        }
        .frame(width: 8, height: 8)
    }
}

// MARK: - Widget Configuration

struct AyanWidget: Widget {
    let kind: String = "AyanWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: AyanProvider()) { entry in
            AyanWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Muslim Widgets")
        .description("A daily Quranic verse or Hadith on your home and lock screen.")
        .supportedFamilies([
            .systemSmall,
            .systemMedium,
            .systemLarge,
            .accessoryRectangular,
            .accessoryCircular,
            .accessoryInline
        ])
    }
}

import SwiftUI

/// The source type of a wisdom entry.
enum WisdomType: String, Codable, Hashable {
    case verse
    case hadith

    var label: String {
        self == .verse ? "Quran" : "Hadith"
    }
}

/// Emotional / spiritual mood categories used as feed filters.
enum MoodFilter: String, CaseIterable, Codable, Identifiable, Hashable {
    case sabr
    case shukr
    case peace
    case akhlaq
    case hope

    var id: String { rawValue }

    var label: String {
        switch self {
        case .sabr:   "Sabr (Patience)"
        case .shukr:  "Shukr (Gratitude)"
        case .peace:  "Anxiety & Peace"
        case .akhlaq: "Akhlaq (Character)"
        case .hope:   "Hope"
        }
    }

    var shortLabel: String {
        switch self {
        case .sabr:   "Sabr"
        case .shukr:  "Shukr"
        case .peace:  "Peace"
        case .akhlaq: "Akhlaq"
        case .hope:   "Hope"
        }
    }

    var symbol: String {
        switch self {
        case .sabr:   "leaf.fill"
        case .shukr:  "heart.fill"
        case .peace:  "moon.stars.fill"
        case .akhlaq: "person.fill"
        case .hope:   "sun.max.fill"
        }
    }

    var accent: Color {
        switch self {
        case .sabr:   Color(red: 0.45, green: 0.70, blue: 0.55)
        case .shukr:  Color(red: 0.85, green: 0.45, blue: 0.50)
        case .peace:  Color(red: 0.55, green: 0.65, blue: 0.85)
        case .akhlaq: Color(red: 0.80, green: 0.70, blue: 0.50)
        case .hope:   Color(red: 0.90, green: 0.75, blue: 0.45)
        }
    }
}

/// Additional scholarly context shown in the reflection modal.
struct WisdomContext: Codable, Hashable {
    let title: String          // e.g. "Surah Ash-Sharh" or "Book of Good Manners"
    let subtitle: String       // e.g. "Meccan · 8 verses" or "Sahih al-Bukhari"
    let body: String           // Full context / commentary text
    let grading: String?       // e.g. "Sahih (Authentic)" — nil for Quran
    let narrator: String?      // e.g. "Suhayb ibn Sinan (RA)" — nil for Quran
}

/// A single verse or hadith entry.
struct WisdomItem: Identifiable, Codable, Hashable {
    let id: UUID
    let type: WisdomType
    let arabicText: String
    let englishText: String
    let attribution: String
    let moods: [MoodFilter]
    let context: WisdomContext

    init(
        id: UUID = UUID(),
        type: WisdomType,
        arabicText: String,
        englishText: String,
        attribution: String,
        moods: [MoodFilter],
        context: WisdomContext
    ) {
        self.id = id
        self.type = type
        self.arabicText = arabicText
        self.englishText = englishText
        self.attribution = attribution
        self.moods = moods
        self.context = context
    }
}

import SwiftUI

// MARK: - Widget Theme

enum WidgetTheme: String, CaseIterable, Codable, Identifiable, Hashable {
    case darkMinimal
    case warmSand
    case emeraldNight
    case monochrome

    var id: String { rawValue }

    var label: String {
        switch self {
        case .darkMinimal:   "Dark Minimal"
        case .warmSand:       "Warm Sand"
        case .emeraldNight:   "Emerald Night"
        case .monochrome:     "Monochrome"
        }
    }

    var previewColors: (bg: Color, text: Color, accent: Color, subtext: Color) {
        switch self {
        case .darkMinimal:
            return (Color(red: 0.07, green: 0.07, blue: 0.07),
                    Color(red: 0.98, green: 0.96, blue: 0.92),
                    Color(red: 0.79, green: 0.66, blue: 0.38),
                    Color(red: 0.60, green: 0.58, blue: 0.54))
        case .warmSand:
            return (Color(red: 0.96, green: 0.90, blue: 0.78),
                    Color(red: 0.25, green: 0.20, blue: 0.13),
                    Color(red: 0.65, green: 0.45, blue: 0.25),
                    Color(red: 0.50, green: 0.42, blue: 0.32))
        case .emeraldNight:
            return (Color(red: 0.03, green: 0.10, blue: 0.07),
                    Color(red: 0.90, green: 0.95, blue: 0.88),
                    Color(red: 0.30, green: 0.75, blue: 0.50),
                    Color(red: 0.50, green: 0.60, blue: 0.52))
        case .monochrome:
            return (Color(red: 0.11, green: 0.11, blue: 0.11),
                    Color.white,
                    Color.white.opacity(0.7),
                    Color.white.opacity(0.45))
        }
    }
}

// MARK: - Widget Font Style

enum WidgetFontStyle: String, CaseIterable, Codable, Identifiable, Hashable {
    case traditional
    case modernClean
    case serif

    var id: String { rawValue }

    var label: String {
        switch self {
        case .traditional: "Traditional"
        case .modernClean: "Modern Clean"
        case .serif:       "Serif"
        }
    }

    var design: Font.Design {
        switch self {
        case .traditional: .serif
        case .modernClean: .rounded
        case .serif:       .serif
        }
    }

    var arabicFontSize: CGFloat { 28 }
    var englishFontSize: CGFloat { 15 }
    var englishWeight: Font.Weight {
        self == .modernClean ? .medium : .regular
    }
}

// MARK: - Widget Language

enum WidgetLanguage: String, CaseIterable, Codable, Identifiable, Hashable {
    case both
    case englishOnly
    case arabicOnly

    var id: String { rawValue }

    var label: String {
        switch self {
        case .both:         "Arabic + English"
        case .englishOnly:  "English Only"
        case .arabicOnly:   "Arabic Only"
        }
    }

    var showsArabic: Bool { self != .englishOnly }
    var showsEnglish: Bool { self != .arabicOnly }
}

// MARK: - Widget Update Frequency

enum WidgetUpdateFrequency: String, CaseIterable, Codable, Identifiable, Hashable {
    case hourly
    case everyThreeHours
    case daily

    var id: String { rawValue }

    var label: String {
        switch self {
        case .hourly:         "Hourly"
        case .everyThreeHours: "Every 3 Hours"
        case .daily:          "Daily"
        }
    }
}

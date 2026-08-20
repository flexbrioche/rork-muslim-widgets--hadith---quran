import SwiftUI

/// A reflection entry saved by the user.
struct Reflection: Codable, Hashable, Identifiable {
    let id: UUID
    let date: Date
    let text: String
}

// MARK: - App State

/// The central observable model managing all persisted state:
/// bookmarks, streak data, widget preferences, and reflections.
@Observable
final class AppState {

    // MARK: Bookmarks

    private(set) var bookmarkedIDs: Set<UUID> = []

    /// Returns bookmarked wisdom items, grouped by primary mood.
    var bookmarkedItemsGrouped: [(MoodFilter, [WisdomItem])] {
        let bookmarked = WisdomSeed.items.filter { bookmarkedIDs.contains($0.id) }
        return MoodFilter.allCases.compactMap { mood in
            let filtered = bookmarked.filter { $0.moods.contains(mood) }
            return filtered.isEmpty ? nil : (mood, filtered)
        }
    }

    // MARK: Streak

    private(set) var streakCount: Int = 0
    private(set) var lastCheckIn: Date?

    // MARK: Reflections

    private(set) var reflections: [Reflection] = []

    // MARK: Widget Preferences

    var widgetTheme: WidgetTheme = .darkMinimal {
        didSet { persistWidget() }
    }
    var widgetFont: WidgetFontStyle = .traditional {
        didSet { persistWidget() }
    }
    var widgetLanguage: WidgetLanguage = .both {
        didSet { persistWidget() }
    }
    var widgetFrequency: WidgetUpdateFrequency = .daily {
        didSet { persistWidget() }
    }

    // MARK: Feed

    var selectedMood: MoodFilter? = nil

    /// Items filtered by the selected mood, or all items if no filter.
    var filteredItems: [WisdomItem] {
        guard let mood = selectedMood else { return WisdomSeed.items }
        return WisdomSeed.items.filter { $0.moods.contains(mood) }
    }

    // MARK: Init

    init() {
        loadAll()
    }

    // MARK: Bookmark Actions

    func toggleBookmark(for item: WisdomItem) {
        if bookmarkedIDs.contains(item.id) {
            bookmarkedIDs.remove(item.id)
        } else {
            bookmarkedIDs.insert(item.id)
        }
        persistBookmarks()
    }

    func isBookmarked(_ item: WisdomItem) -> Bool {
        bookmarkedIDs.contains(item.id)
    }

    // MARK: Streak

    /// Registers a daily check-in. Called when the user opens the feed.
    func registerCheckIn() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        if let last = lastCheckIn {
            let lastDay = calendar.startOfDay(for: last)
            if lastDay == today { return } // already checked in today

            let dayDiff = calendar.dateComponents([.day], from: lastDay, to: today).day ?? 0
            if dayDiff == 1 {
                streakCount += 1
            } else {
                streakCount = 1 // streak broken, restart
            }
        } else {
            streakCount = 1
        }

        lastCheckIn = today
        persistStreak()
    }

    // MARK: Reflections

    func addReflection(for item: WisdomItem, text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        reflections.append(Reflection(id: item.id, date: Date(), text: trimmed))
        persistReflections()
    }

    func reflection(for item: WisdomItem) -> Reflection? {
        reflections.first { $0.id == item.id }
    }

    // MARK: Persistence

    private enum StorageKey {
        static let bookmarks = "ayan.bookmarks"
        static let streak = "ayan.streak"
        static let reflections = "ayan.reflections"
        static let widget = "ayan.widget"
    }

    private func loadAll() {
        loadBookmarks()
        loadStreak()
        loadReflections()
        loadWidget()
    }

    private func persistBookmarks() {
        let ids = Array(bookmarkedIDs)
        if let data = try? JSONEncoder().encode(ids) {
            UserDefaults.standard.set(data, forKey: StorageKey.bookmarks)
        }
    }

    private func loadBookmarks() {
        guard let data = UserDefaults.standard.data(forKey: StorageKey.bookmarks),
              let ids = try? JSONDecoder().decode([UUID].self, from: data) else { return }
        bookmarkedIDs = Set(ids)
    }

    private func persistStreak() {
        let data: [String: Any] = [
            "count": streakCount,
            "lastCheckIn": lastCheckIn?.timeIntervalSince1970 ?? 0
        ]
        UserDefaults.standard.set(data, forKey: StorageKey.streak)
    }

    private func loadStreak() {
        guard let dict = UserDefaults.standard.dictionary(forKey: StorageKey.streak) else { return }
        streakCount = dict["count"] as? Int ?? 0
        if let ts = dict["lastCheckIn"] as? Double, ts > 0 {
            lastCheckIn = Date(timeIntervalSince1970: ts)
        }
    }

    private func persistReflections() {
        if let data = try? JSONEncoder().encode(reflections) {
            UserDefaults.standard.set(data, forKey: StorageKey.reflections)
        }
    }

    private func loadReflections() {
        guard let data = UserDefaults.standard.data(forKey: StorageKey.reflections) else { return }
        if let decoded = try? JSONDecoder().decode([Reflection].self, from: data) {
            reflections = decoded
        }
    }

    private func persistWidget() {
        let data: [String: String] = [
            "theme": widgetTheme.rawValue,
            "font": widgetFont.rawValue,
            "language": widgetLanguage.rawValue,
            "frequency": widgetFrequency.rawValue
        ]
        UserDefaults.standard.set(data, forKey: StorageKey.widget)
    }

    private func loadWidget() {
        guard let dict = UserDefaults.standard.dictionary(forKey: StorageKey.widget) else { return }
        if let raw = dict["theme"] as? String, let v = WidgetTheme(rawValue: raw) {
            widgetTheme = v
        }
        if let raw = dict["font"] as? String, let v = WidgetFontStyle(rawValue: raw) {
            widgetFont = v
        }
        if let raw = dict["language"] as? String, let v = WidgetLanguage(rawValue: raw) {
            widgetLanguage = v
        }
        if let raw = dict["frequency"] as? String, let v = WidgetUpdateFrequency(rawValue: raw) {
            widgetFrequency = v
        }
    }
}

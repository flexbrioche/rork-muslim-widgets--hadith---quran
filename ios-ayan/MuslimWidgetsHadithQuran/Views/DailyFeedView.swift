import SwiftUI

/// The Daily Feed tab — hero "Verse/Hadith of the Day" card with mood filtering.
struct DailyFeedView: View {

    @Environment(AppState.self) private var state

    @State private var contextItem: WisdomItem?
    @State private var showShareToast = false

    var body: some View {
        ZStack {
            MuslimWidgetsHadithQuranDesign.canvas.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {

                    // Header
                    headerSection

                    // Mood filters
                    MoodFilterBar(selected: Binding(
                        get: { state.selectedMood },
                        set: { state.selectedMood = $0 }
                    ))

                    // Hero card — "of the day"
                    if let dailyItem = dailyItem {
                        WisdomCard(
                            item: dailyItem,
                            isBookmarked: state.isBookmarked(dailyItem),
                            onBookmark: { state.toggleBookmark(for: dailyItem) },
                            onShare: { shareItem(dailyItem) },
                            onReflect: { contextItem = dailyItem }
                        )
                    }

                    // More entries (filtered)
                    if !moreItems.isEmpty {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("More Reflections")
                                .font(.system(size: 13, weight: .semibold, design: .rounded))
                                .tracking(1.5)
                                .foregroundStyle(MuslimWidgetsHadithQuranDesign.textSecondary)
                                .padding(.horizontal, 20)

                            ForEach(moreItems) { item in
                                CompactWisdomRow(
                                    item: item,
                                    isBookmarked: state.isBookmarked(item),
                                    onBookmark: { state.toggleBookmark(for: item) },
                                    onTap: { contextItem = item }
                                )
                            }
                        }
                    }

                    Spacer(minLength: 40)
                }
            }
            .scrollIndicators(.hidden)
        }
        .onAppear {
            state.registerCheckIn()
        }
        .sheet(item: $contextItem) { item in
            ContextModal(
                item: item,
                existingReflection: state.reflection(for: item),
                onSaveReflection: { state.addReflection(for: item, text: $0) }
            )
        }
        .overlay {
            if showShareToast {
                ShareToast()
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }

    // MARK: - Subviews

    private var headerSection: some View {
        VStack(spacing: 6) {
            Text("Muslim Widgets")
                .font(.system(size: 28, weight: .bold, design: .serif))
                .foregroundStyle(MuslimWidgetsHadithQuranDesign.textPrimary)

            Text(greeting)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundStyle(MuslimWidgetsHadithQuranDesign.textSecondary)
        }
        .padding(.top, 8)
    }

    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12:  return "Good morning — a new verse awaits"
        case 12..<17: return "Good afternoon — pause and reflect"
        case 17..<21: return "Good evening — evening reflections"
        default:       return "Peaceful night — verses for the soul"
        }
    }

    // MARK: - Data

    /// The "verse of the day" — rotates daily based on the date.
    private var dailyItem: WisdomItem? {
        let items = state.filteredItems
        guard !items.isEmpty else { return nil }
        let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 1
        let index = (dayOfYear - 1) % items.count
        return items[index]
    }

    /// Remaining items below the hero card.
    private var moreItems: [WisdomItem] {
        guard let daily = dailyItem else { return state.filteredItems }
        return state.filteredItems.filter { $0.id != daily.id }
    }

    // MARK: - Actions

    private func shareItem(_ item: WisdomItem) {
        let text = "\(item.arabicText)\n\n\(item.englishText)\n\n— \(item.attribution)"
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let root = scene.windows.first?.rootViewController else { return }
        let av = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        root.present(av, animated: true)
        withAnimation { showShareToast = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation { showShareToast = false }
        }
    }
}

// MARK: - Compact Row

private struct CompactWisdomRow: View {
    let item: WisdomItem
    let isBookmarked: Bool
    let onBookmark: () -> Void
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(item.arabicText)
                        .font(.system(size: 20, weight: .medium, design: .serif))
                        .foregroundStyle(MuslimWidgetsHadithQuranDesign.textPrimary)
                        .lineLimit(2)
                    Text(item.englishText)
                        .font(.system(size: 14, weight: .regular, design: .serif))
                        .foregroundStyle(MuslimWidgetsHadithQuranDesign.textSecondary)
                        .lineLimit(2)
                    Text(item.attribution)
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundStyle(MuslimWidgetsHadithQuranDesign.gold.opacity(0.7))
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Button(action: onBookmark) {
                    Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(isBookmarked ? MuslimWidgetsHadithQuranDesign.gold : MuslimWidgetsHadithQuranDesign.textSecondary)
                }
                .buttonStyle(.plain)
            }
            .padding(18)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(MuslimWidgetsHadithQuranDesign.surface)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .strokeBorder(Color.white.opacity(0.05), lineWidth: 0.5)
                    )
            )
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 20)
    }
}

// MARK: - Share Toast

private struct ShareToast: View {
    var body: some View {
        VStack {
            HStack(spacing: 8) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(MuslimWidgetsHadithQuranDesign.gold)
                Text("Share sheet opened")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(MuslimWidgetsHadithQuranDesign.textPrimary)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(
                Capsule().fill(MuslimWidgetsHadithQuranDesign.surface)
                    .overlay(Capsule().strokeBorder(MuslimWidgetsHadithQuranDesign.goldMuted, lineWidth: 0.5))
            )
            .padding(.top, 60)
            Spacer()
        }
    }
}

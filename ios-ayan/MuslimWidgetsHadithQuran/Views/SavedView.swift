import SwiftUI

/// The Saved & Reflections tab — bookmarks grouped by topic, streak counter,
/// and tap-to-open context modal.
struct SavedView: View {

    @Environment(AppState.self) private var state
    @State private var contextItem: WisdomItem?

    var body: some View {
        ZStack {
            MuslimWidgetsHadithQuranDesign.canvas.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 28) {

                    // Header
                    headerSection

                    // Streak card
                    StreakCard(count: state.streakCount)

                    // Bookmarked items grouped by topic
                    if state.bookmarkedIDs.isEmpty {
                        EmptyBookmarksView()
                    } else {
                        bookmarkGroups
                    }

                    // Reflections
                    if !state.reflections.isEmpty {
                        reflectionsSection
                    }

                    Spacer(minLength: 40)
                }
            }
            .scrollIndicators(.hidden)
        }
        .sheet(item: $contextItem) { item in
            ContextModal(
                item: item,
                existingReflection: state.reflection(for: item),
                onSaveReflection: { state.addReflection(for: item, text: $0) }
            )
        }
    }

    private var headerSection: some View {
        VStack(spacing: 6) {
            Text("Saved")
                .font(.system(size: 28, weight: .bold, design: .serif))
                .foregroundStyle(MuslimWidgetsHadithQuranDesign.textPrimary)
            Text("Your bookmarks and reflections")
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundStyle(MuslimWidgetsHadithQuranDesign.textSecondary)
        }
        .padding(.top, 8)
    }

    // MARK: - Bookmark groups

    private var bookmarkGroups: some View {
        VStack(alignment: .leading, spacing: 24) {
            ForEach(state.bookmarkedItemsGrouped, id: \.0) { mood, items in
                VStack(alignment: .leading, spacing: 12) {
                    // Topic header
                    HStack(spacing: 8) {
                        Image(systemName: mood.symbol)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(mood.accent)
                        Text(mood.label)
                            .font(.system(size: 15, weight: .semibold, design: .serif))
                            .foregroundStyle(MuslimWidgetsHadithQuranDesign.textPrimary)
                        Text("\(items.count)")
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .foregroundStyle(MuslimWidgetsHadithQuranDesign.textSecondary)
                    }
                    .padding(.horizontal, 20)

                    // Items
                    ForEach(items) { item in
                        SavedWisdomRow(
                            item: item,
                            isBookmarked: state.isBookmarked(item),
                            onBookmark: { state.toggleBookmark(for: item) },
                            onTap: { contextItem = item }
                        )
                    }
                }
            }
        }
    }

    // MARK: - Reflections

    private var reflectionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "pencil.and.scribble")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(MuslimWidgetsHadithQuranDesign.gold)
                Text("Reflections")
                    .font(.system(size: 15, weight: .semibold, design: .serif))
                    .foregroundStyle(MuslimWidgetsHadithQuranDesign.textPrimary)
                Text("\(state.reflections.count)")
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundStyle(MuslimWidgetsHadithQuranDesign.textSecondary)
            }
            .padding(.horizontal, 20)

            ForEach(state.reflections) { reflection in
                if let item = WisdomSeed.items.first(where: { $0.id == reflection.id }) {
                    ReflectionRow(reflection: reflection, item: item) {
                        contextItem = item
                    }
                }
            }
        }
    }
}

// MARK: - Streak Card

private struct StreakCard: View {
    let count: Int

    var body: some View {
        HStack(spacing: 16) {
            // Flame / streak icon
            ZStack {
                Circle()
                    .fill(MuslimWidgetsHadithQuranDesign.gold.opacity(0.12))
                    .frame(width: 52, height: 52)
                Image(systemName: "flame.fill")
                    .font(.system(size: 24))
                    .foregroundStyle(MuslimWidgetsHadithQuranDesign.gold)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text("\(count) Day\(count == 1 ? "" : "s") of Reflection")
                    .font(.system(size: 18, weight: .bold, design: .serif))
                    .foregroundStyle(MuslimWidgetsHadithQuranDesign.textPrimary)
                Text(count > 0 ? "Keep the streak alive — open daily" : "Start your streak today")
                    .font(.system(size: 13, weight: .medium, design: .rounded))
                    .foregroundStyle(MuslimWidgetsHadithQuranDesign.textSecondary)
            }

            Spacer()
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: MuslimWidgetsHadithQuranDesign.cornerRadius)
                .fill(MuslimWidgetsHadithQuranDesign.surfaceWarm)
                .overlay(
                    RoundedRectangle(cornerRadius: MuslimWidgetsHadithQuranDesign.cornerRadius)
                        .strokeBorder(MuslimWidgetsHadithQuranDesign.goldMuted, lineWidth: 0.5)
                )
        )
        .padding(.horizontal, 20)
    }
}

// MARK: - Saved Row

private struct SavedWisdomRow: View {
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
                    Image(systemName: "bookmark.fill")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(MuslimWidgetsHadithQuranDesign.gold)
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

// MARK: - Reflection Row

private struct ReflectionRow: View {
    let reflection: Reflection
    let item: WisdomItem
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 8) {
                Text(item.attribution)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundStyle(MuslimWidgetsHadithQuranDesign.gold.opacity(0.7))
                Text(reflection.text)
                    .font(.system(size: 15, weight: .regular, design: .serif))
                    .foregroundStyle(MuslimWidgetsHadithQuranDesign.textPrimary.opacity(0.85))
                    .lineSpacing(5)
                    .lineLimit(3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(reflection.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.system(size: 11, weight: .medium, design: .rounded))
                    .foregroundStyle(MuslimWidgetsHadithQuranDesign.textSecondary)
            }
            .padding(18)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(MuslimWidgetsHadithQuranDesign.gold.opacity(0.04))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .strokeBorder(MuslimWidgetsHadithQuranDesign.goldMuted, lineWidth: 0.5)
                    )
            )
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 20)
    }
}

// MARK: - Empty State

private struct EmptyBookmarksView: View {
    var body: some View {
        VStack(spacing: 16) {
            Spacer(minLength: 20)
            Image(systemName: "bookmark")
                .font(.system(size: 40, weight: .light))
                .foregroundStyle(MuslimWidgetsHadithQuranDesign.textSecondary.opacity(0.5))
            Text("No bookmarks yet")
                .font(.system(size: 17, weight: .semibold, design: .serif))
                .foregroundStyle(MuslimWidgetsHadithQuranDesign.textPrimary)
            Text("Tap the bookmark icon on any verse\nor hadith to save it here")
                .font(.system(size: 14, weight: .regular, design: .rounded))
                .foregroundStyle(MuslimWidgetsHadithQuranDesign.textSecondary)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }
}

import SwiftUI

/// The "Verse / Hadith of the Day" hero card displayed at the top of the feed.
struct WisdomCard: View {

    let item: WisdomItem
    let isBookmarked: Bool
    let onBookmark: () -> Void
    let onShare: () -> Void
    let onReflect: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Type badge + crescent ornament
            HStack {
                Text(item.type.label.uppercased())
                    .font(.system(size: 11, weight: .semibold, design: .rounded))
                    .tracking(2)
                    .foregroundStyle(MuslimWidgetsHadithQuranDesign.gold)

                Spacer()

                CrescentOrnament(size: 12)
            }
            .padding(.bottom, 20)

            // Arabic calligraphy
            Text(item.arabicText)
                .font(.system(size: 32, weight: .medium, design: .serif))
                .foregroundStyle(MuslimWidgetsHadithQuranDesign.textPrimary)
                .lineSpacing(10)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 16)

            GoldDivider()
                .padding(.vertical, 20)

            // English translation
            Text(item.englishText)
                .font(.system(size: 17, weight: .regular, design: .serif))
                .foregroundStyle(MuslimWidgetsHadithQuranDesign.textPrimary.opacity(0.92))
                .lineSpacing(6)
                .fixedSize(horizontal: false, vertical: true)

            // Attribution
            Text(item.attribution)
                .font(.system(size: 13, weight: .medium, design: .rounded))
                .foregroundStyle(MuslimWidgetsHadithQuranDesign.gold.opacity(0.8))
                .padding(.top, 12)

            // Action buttons
            HStack(spacing: 12) {
                ActionButton(
                    label: "Share",
                    icon: "square.and.arrow.up",
                    action: onShare
                )
                ActionButton(
                    label: isBookmarked ? "Saved" : "Bookmark",
                    icon: isBookmarked ? "bookmark.fill" : "bookmark",
                    action: onBookmark,
                    isActive: isBookmarked
                )
                ActionButton(
                    label: "Reflect",
                    icon: "book.open",
                    action: onReflect
                )
            }
            .padding(.top, 24)
        }
        .padding(MuslimWidgetsHadithQuranDesign.cardPadding)
        .background(
            RoundedRectangle(cornerRadius: MuslimWidgetsHadithQuranDesign.cornerRadius)
                .fill(MuslimWidgetsHadithQuranDesign.surfaceWarm)
                .overlay(
                    RoundedRectangle(cornerRadius: MuslimWidgetsHadithQuranDesign.cornerRadius)
                        .strokeBorder(MuslimWidgetsHadithQuranDesign.goldMuted, lineWidth: 0.5)
                )
        )
    }
}

/// A compact pill-shaped action button used on the hero card.
private struct ActionButton: View {

    let label: String
    let icon: String
    let action: () -> Void
    var isActive: Bool = false

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .medium))
                Text(label)
                    .font(.system(size: 10, weight: .medium, design: .rounded))
            }
            .foregroundStyle(isActive ? MuslimWidgetsHadithQuranDesign.gold : MuslimWidgetsHadithQuranDesign.textSecondary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(isActive ? MuslimWidgetsHadithQuranDesign.gold.opacity(0.12) : Color.white.opacity(0.04))
            )
        }
        .buttonStyle(.plain)
        .sensoryFeedback(.selection, trigger: isActive)
    }
}

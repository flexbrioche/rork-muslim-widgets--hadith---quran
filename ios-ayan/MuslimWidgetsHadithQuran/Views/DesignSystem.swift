import SwiftUI

/// Central design system for MuslimWidgetsHadithQuran — colors, typography, and shared modifiers.
enum MuslimWidgetsHadithQuranDesign {

    // MARK: - Colors

    /// Deep charcoal background for the app's primary surface.
    static let canvas = Color(red: 0.07, green: 0.07, blue: 0.07)

    /// Slightly elevated surface for cards.
    static let surface = Color(red: 0.10, green: 0.10, blue: 0.11)

    /// A subtly warmer surface for the hero card.
    static let surfaceWarm = Color(red: 0.11, green: 0.10, blue: 0.09)

    /// Antique gold — the app's signature accent.
    static let gold = Color(red: 0.79, green: 0.66, blue: 0.38)

    /// Muted gold for borders / dividers.
    static let goldMuted = Color(red: 0.79, green: 0.66, blue: 0.38).opacity(0.25)

    /// Warm off-white for primary text.
    static let textPrimary = Color(red: 0.98, green: 0.96, blue: 0.92)

    /// Dimmer text for attribution / secondary lines.
    static let textSecondary = Color(red: 0.65, green: 0.62, blue: 0.56)

    /// Subtle separator.
    static let separator = Color(red: 0.18, green: 0.18, blue: 0.18)

    // MARK: - Metrics

    static let cornerRadius: CGFloat = 20
    static let cardPadding: CGFloat = 24
    static let spacing: CGFloat = 16
}

/// A reusable gold-accented divider with a subtle ornament feel.
struct GoldDivider: View {
    var body: some View {
        HStack(spacing: 8) {
            MuslimWidgetsHadithQuranDesign.goldMuted
                .frame(height: 0.5)
            Circle()
                .fill(MuslimWidgetsHadithQuranDesign.gold)
                .frame(width: 3, height: 3)
            MuslimWidgetsHadithQuranDesign.goldMuted
                .frame(height: 0.5)
        }
    }
}

/// A small crescent ornament used as a decorative accent.
struct CrescentOrnament: View {
    var size: CGFloat = 14
    var body: some View {
        ZStack {
            Circle()
                .fill(MuslimWidgetsHadithQuranDesign.gold)
                .frame(width: size, height: size)
            Circle()
                .fill(MuslimWidgetsHadithQuranDesign.canvas)
                .frame(width: size * 0.85, height: size * 0.85)
                .offset(x: size * 0.25)
        }
        .frame(width: size, height: size)
        .allowsHitTesting(false)
    }
}

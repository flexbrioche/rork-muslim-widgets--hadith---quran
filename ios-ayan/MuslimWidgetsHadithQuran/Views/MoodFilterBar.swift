import SwiftUI

/// A horizontally scrollable row of mood filter pills.
struct MoodFilterBar: View {

    @Binding var selected: MoodFilter?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                // "All" pill
                Pill(
                    label: "All",
                    icon: nil,
                    isSelected: selected == nil,
                    accent: MuslimWidgetsHadithQuranDesign.gold,
                    action: { selected = nil }
                )

                ForEach(MoodFilter.allCases) { mood in
                    Pill(
                        label: mood.shortLabel,
                        icon: mood.symbol,
                        isSelected: selected == mood,
                        accent: mood.accent,
                        action: { selected = mood }
                    )
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

private struct Pill: View {
    let label: String
    let icon: String?
    let isSelected: Bool
    let accent: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 11, weight: .semibold))
                }
                Text(label)
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
            }
            .foregroundStyle(isSelected ? Color.black : MuslimWidgetsHadithQuranDesign.textSecondary)
            .padding(.horizontal, 16)
            .padding(.vertical, 9)
            .background(
                Capsule()
                    .fill(isSelected ? accent : Color.white.opacity(0.06))
            )
            .overlay(
                Capsule()
                    .strokeBorder(isSelected ? Color.clear : Color.white.opacity(0.08), lineWidth: 0.5)
            )
        }
        .buttonStyle(.plain)
        .sensoryFeedback(.selection, trigger: isSelected)
    }
}

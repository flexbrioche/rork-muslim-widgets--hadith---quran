import SwiftUI

/// The Widget Studio tab — customize and preview lock-screen widgets.
struct WidgetStudioView: View {

    @Environment(AppState.self) private var state

    var body: some View {
        ZStack {
            MuslimWidgetsHadithQuranDesign.canvas.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 28) {

                    // Header
                    headerSection

                    // Live lock-screen preview
                    LockScreenPreview(
                        theme: state.widgetTheme,
                        font: state.widgetFont,
                        language: state.widgetLanguage,
                        item: previewItem
                    )

                    // Customization controls
                    VStack(spacing: 24) {
                        ThemeSelector(selected: Binding(
                            get: { state.widgetTheme },
                            set: { state.widgetTheme = $0 }
                        ))

                        FontSelector(selected: Binding(
                            get: { state.widgetFont },
                            set: { state.widgetFont = $0 }
                        ))

                        LanguageSelector(selected: Binding(
                            get: { state.widgetLanguage },
                            set: { state.widgetLanguage = $0 }
                        ))

                        FrequencySelector(selected: Binding(
                            get: { state.widgetFrequency },
                            set: { state.widgetFrequency = $0 }
                        ))
                    }
                    .padding(.horizontal, 20)

                    Spacer(minLength: 40)
                }
            }
            .scrollIndicators(.hidden)
        }
    }

    private var headerSection: some View {
        VStack(spacing: 6) {
            Text("Widget Studio")
                .font(.system(size: 28, weight: .bold, design: .serif))
                .foregroundStyle(MuslimWidgetsHadithQuranDesign.textPrimary)
            Text("Design your lock-screen verse")
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundStyle(MuslimWidgetsHadithQuranDesign.textSecondary)
        }
        .padding(.top, 8)
    }

    /// The verse shown in the preview — rotates daily.
    private var previewItem: WisdomItem {
        let items = WisdomSeed.items
        let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 1
        return items[(dayOfYear - 1) % items.count]
    }
}

// MARK: - Lock Screen Preview

/// A simulated phone lock screen showing the widget with the selected style.
struct LockScreenPreview: View {

    let theme: WidgetTheme
    let font: WidgetFontStyle
    let language: WidgetLanguage
    let item: WisdomItem

    private var colors: (bg: Color, text: Color, accent: Color, subtext: Color) {
        theme.previewColors
    }

    var body: some View {
        VStack(spacing: 0) {
            // Simulated phone frame
            RoundedRectangle(cornerRadius: 44)
                .fill(colors.bg)
                .frame(width: 280, height: 480)
                .overlay(
                    RoundedRectangle(cornerRadius: 44)
                        .strokeBorder(Color.white.opacity(0.08), lineWidth: 2)
                )
                .overlay(
                    // Notch
                    Capsule()
                        .fill(Color.black.opacity(0.8))
                        .frame(width: 90, height: 26)
                        .offset(y: -238)
                )
                .overlay(
                    // Lock screen content
                    VStack(spacing: 0) {
                        // Time
                        VStack(spacing: 2) {
                            Text(timeString)
                                .font(.system(size: 56, weight: .light, design: font.design))
                                .foregroundStyle(colors.text)
                            Text(dateString)
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundStyle(colors.subtext)
                        }
                        .padding(.top, 60)

                        Spacer()

                        // Widget content
                        widgetContent
                            .padding(.horizontal, 20)
                            .padding(.vertical, 16)
                            .frame(maxWidth: 240)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(0.08))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .strokeBorder(colors.accent.opacity(0.2), lineWidth: 0.5)
                                    )
                            )

                        Spacer()

                        // Bottom home indicator
                        Capsule()
                            .fill(colors.text.opacity(0.4))
                            .frame(width: 100, height: 4)
                            .padding(.bottom, 16)
                    }
                )
                .shadow(color: Color.black.opacity(0.5), radius: 30, y: 15)
        }
        .padding(.vertical, 12)
        .animation(.easeInOut(duration: 0.3), value: theme)
        .animation(.easeInOut(duration: 0.3), value: font)
        .animation(.easeInOut(duration: 0.3), value: language)
    }

    @ViewBuilder
    private var widgetContent: some View {
        VStack(spacing: 10) {
            if language.showsArabic {
                Text(item.arabicText)
                    .font(.system(size: font.arabicFontSize, weight: .medium, design: .serif))
                    .foregroundStyle(colors.text)
                    .lineSpacing(6)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            }

            if language.showsArabic && language.showsEnglish {
                Divider()
                    .frame(height: 0.5)
                    .background(colors.accent.opacity(0.3))
                    .padding(.horizontal, 30)
            }

            if language.showsEnglish {
                Text(item.englishText)
                    .font(.system(size: font.englishFontSize, weight: font.englishWeight, design: font.design))
                    .foregroundStyle(colors.text.opacity(0.85))
                    .lineSpacing(4)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            }

            Text(item.attribution)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
                .foregroundStyle(colors.accent)
                .padding(.top, 2)
        }
    }

    private var timeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm"
        return formatter.string(from: Date())
    }

    private var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        return formatter.string(from: Date())
    }
}

// MARK: - Theme Selector

private struct ThemeSelector: View {
    @Binding var selected: WidgetTheme

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Theme", systemImage: "paintpalette")
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .tracking(1)
                .foregroundStyle(MuslimWidgetsHadithQuranDesign.textSecondary)

            HStack(spacing: 10) {
                ForEach(WidgetTheme.allCases) { theme in
                    ThemeChip(theme: theme, isSelected: selected == theme) {
                        selected = theme
                    }
                }
            }
        }
    }
}

private struct ThemeChip: View {
    let theme: WidgetTheme
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        let colors = theme.previewColors
        Button(action: action) {
            VStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(colors.bg)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(colors.accent.opacity(isSelected ? 0.8 : 0.3), lineWidth: isSelected ? 1.5 : 0.5)
                    )
                    .overlay(
                        VStack(spacing: 3) {
                            Circle().fill(colors.accent).frame(width: 8, height: 8)
                            RoundedRectangle(cornerRadius: 2)
                                .fill(colors.text.opacity(0.5))
                                .frame(width: 24, height: 2)
                        }
                    )
                    .frame(width: 56, height: 56)

                Text(theme.label)
                    .font(.system(size: 10, weight: .semibold, design: .rounded))
                    .foregroundStyle(isSelected ? MuslimWidgetsHadithQuranDesign.textPrimary : MuslimWidgetsHadithQuranDesign.textSecondary)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
        .sensoryFeedback(.selection, trigger: isSelected)
    }
}

// MARK: - Font Selector

private struct FontSelector: View {
    @Binding var selected: WidgetFontStyle

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Font Style", systemImage: "textformat")
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .tracking(1)
                .foregroundStyle(MuslimWidgetsHadithQuranDesign.textSecondary)

            HStack(spacing: 10) {
                ForEach(WidgetFontStyle.allCases) { font in
                    Button {
                        selected = font
                    } label: {
                        Text("Aa")
                            .font(.system(size: 20, weight: .semibold, design: font.design))
                            .foregroundStyle(selected == font ? MuslimWidgetsHadithQuranDesign.canvas : MuslimWidgetsHadithQuranDesign.textSecondary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(selected == font ? MuslimWidgetsHadithQuranDesign.gold : Color.white.opacity(0.05))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .strokeBorder(
                                        selected == font ? Color.clear : Color.white.opacity(0.08),
                                        lineWidth: 0.5
                                    )
                            )
                            .overlay(alignment: .bottom) {
                                Text(font.label)
                                    .font(.system(size: 9, weight: .medium, design: .rounded))
                                    .foregroundStyle(selected == font ? MuslimWidgetsHadithQuranDesign.canvas.opacity(0.7) : MuslimWidgetsHadithQuranDesign.textSecondary)
                                    .padding(.bottom, 6)
                            }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

// MARK: - Language Selector

private struct LanguageSelector: View {
    @Binding var selected: WidgetLanguage

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Language", systemImage: "globe")
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .tracking(1)
                .foregroundStyle(MuslimWidgetsHadithQuranDesign.textSecondary)

            HStack(spacing: 10) {
                ForEach(WidgetLanguage.allCases) { lang in
                    Button {
                        selected = lang
                    } label: {
                        Text(lang.label)
                            .font(.system(size: 13, weight: .semibold, design: .rounded))
                            .foregroundStyle(selected == lang ? MuslimWidgetsHadithQuranDesign.canvas : MuslimWidgetsHadithQuranDesign.textSecondary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(selected == lang ? MuslimWidgetsHadithQuranDesign.gold : Color.white.opacity(0.05))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .strokeBorder(
                                        selected == lang ? Color.clear : Color.white.opacity(0.08),
                                        lineWidth: 0.5
                                    )
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

// MARK: - Frequency Selector

private struct FrequencySelector: View {
    @Binding var selected: WidgetUpdateFrequency

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Update Frequency", systemImage: "clock.arrow.circlepath")
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .tracking(1)
                .foregroundStyle(MuslimWidgetsHadithQuranDesign.textSecondary)

            HStack(spacing: 10) {
                ForEach(WidgetUpdateFrequency.allCases) { freq in
                    Button {
                        selected = freq
                    } label: {
                        Text(freq.label)
                            .font(.system(size: 13, weight: .semibold, design: .rounded))
                            .foregroundStyle(selected == freq ? MuslimWidgetsHadithQuranDesign.canvas : MuslimWidgetsHadithQuranDesign.textSecondary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(selected == freq ? MuslimWidgetsHadithQuranDesign.gold : Color.white.opacity(0.05))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .strokeBorder(
                                        selected == freq ? Color.clear : Color.white.opacity(0.08),
                                        lineWidth: 0.5
                                    )
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

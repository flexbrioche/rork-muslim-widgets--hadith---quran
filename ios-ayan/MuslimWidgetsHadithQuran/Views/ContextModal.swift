import SwiftUI

/// A modal sheet showing full Surah context or Hadith commentary for a wisdom item.
struct ContextModal: View {

    let item: WisdomItem
    @State private var reflectionText: String = ""
    let existingReflection: Reflection?
    let onSaveReflection: (String) -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {

                    // Arabic
                    Text(item.arabicText)
                        .font(.system(size: 30, weight: .medium, design: .serif))
                        .foregroundStyle(MuslimWidgetsHadithQuranDesign.textPrimary)
                        .lineSpacing(10)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 8)

                    GoldDivider()

                    // English
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Translation")
                            .font(.system(size: 12, weight: .semibold, design: .rounded))
                            .tracking(1.5)
                            .foregroundStyle(MuslimWidgetsHadithQuranDesign.gold)
                        Text(item.englishText)
                            .font(.system(size: 18, weight: .regular, design: .serif))
                            .foregroundStyle(MuslimWidgetsHadithQuranDesign.textPrimary.opacity(0.92))
                            .lineSpacing(6)
                    }

                    // Attribution + grading
                    VStack(alignment: .leading, spacing: 6) {
                        Text(item.attribution)
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundStyle(MuslimWidgetsHadithQuranDesign.gold.opacity(0.9))
                        if let grading = item.context.grading {
                            Text(grading)
                                .font(.system(size: 13, weight: .medium, design: .rounded))
                                .foregroundStyle(MuslimWidgetsHadithQuranDesign.textSecondary)
                        }
                        if let narrator = item.context.narrator {
                            Text("Narrated by \(narrator)")
                                .font(.system(size: 13, weight: .regular, design: .rounded))
                                .foregroundStyle(MuslimWidgetsHadithQuranDesign.textSecondary)
                        }
                    }

                    // Context section
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 8) {
                            Image(systemName: item.type == .verse ? "book.closed" : "scroll")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(MuslimWidgetsHadithQuranDesign.gold)
                            Text(item.context.title)
                                .font(.system(size: 16, weight: .semibold, design: .serif))
                                .foregroundStyle(MuslimWidgetsHadithQuranDesign.textPrimary)
                        }
                        Text(item.context.subtitle)
                            .font(.system(size: 13, weight: .medium, design: .rounded))
                            .foregroundStyle(MuslimWidgetsHadithQuranDesign.textSecondary)

                        Text(item.context.body)
                            .font(.system(size: 15, weight: .regular, design: .serif))
                            .foregroundStyle(MuslimWidgetsHadithQuranDesign.textPrimary.opacity(0.78))
                            .lineSpacing(7)
                    }

                    // Mood tags
                    HStack(spacing: 8) {
                        ForEach(item.moods) { mood in
                            HStack(spacing: 4) {
                                Image(systemName: mood.symbol)
                                    .font(.system(size: 10))
                                Text(mood.shortLabel)
                                    .font(.system(size: 12, weight: .medium, design: .rounded))
                            }
                            .foregroundStyle(mood.accent)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(
                                Capsule().fill(mood.accent.opacity(0.12))
                            )
                        }
                    }

                    // Reflection
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 8) {
                            Image(systemName: "pencil.and.scribble")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(MuslimWidgetsHadithQuranDesign.gold)
                            Text(existingReflection == nil ? "Write a Reflection" : "Your Reflection")
                                .font(.system(size: 16, weight: .semibold, design: .serif))
                                .foregroundStyle(MuslimWidgetsHadithQuranDesign.textPrimary)
                        }

                        if let existing = existingReflection {
                            Text(existing.text)
                                .font(.system(size: 15, weight: .regular, design: .serif))
                                .foregroundStyle(MuslimWidgetsHadithQuranDesign.textPrimary.opacity(0.85))
                                .lineSpacing(6)
                                .padding(16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(MuslimWidgetsHadithQuranDesign.gold.opacity(0.06))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 14)
                                                .strokeBorder(MuslimWidgetsHadithQuranDesign.goldMuted, lineWidth: 0.5)
                                        )
                                )
                        } else {
                            TextField("What is this verse teaching you today?", text: $reflectionText, axis: .vertical)
                                .font(.system(size: 15, weight: .regular, design: .serif))
                                .foregroundStyle(MuslimWidgetsHadithQuranDesign.textPrimary)
                                .lineSpacing(6)
                                .multilineTextAlignment(.leading)
                                .padding(16)
                                .frame(minHeight: 80, alignment: .topLeading)
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(Color.white.opacity(0.04))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .strokeBorder(Color.white.opacity(0.08), lineWidth: 0.5)
                                )

                            if !reflectionText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                Button {
                                    onSaveReflection(reflectionText)
                                    reflectionText = ""
                                } label: {
                                    Text("Save Reflection")
                                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                                        .foregroundStyle(MuslimWidgetsHadithQuranDesign.canvas)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 14)
                                        .background(
                                            RoundedRectangle(cornerRadius: 14)
                                                .fill(MuslimWidgetsHadithQuranDesign.gold)
                                        )
                                }
                                .buttonStyle(.plain)
                                .transition(.opacity.combined(with: .move(edge: .bottom)))
                            }
                        }
                    }
                }
                .padding(24)
            }
            .background(MuslimWidgetsHadithQuranDesign.canvas.ignoresSafeArea())
            .navigationTitle("Context")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 22))
                            .foregroundStyle(MuslimWidgetsHadithQuranDesign.textSecondary)
                    }
                }
            }
        }
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
    }
}

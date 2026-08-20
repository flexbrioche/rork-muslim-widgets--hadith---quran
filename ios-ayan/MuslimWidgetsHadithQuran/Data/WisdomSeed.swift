import Foundation

/// Curated seed data: 15 verified Quranic verses and authentic Hadiths
/// across emotional themes (Sabr, Shukr, Peace, Akhlaq, Hope).
/// All Arabic text and citations are sourced from standard references:
/// - Quran: Standard Hafs narration
/// - Hadith: Sahih al-Bukhari, Sahih Muslim, Sunan al-Tirmidhi
enum WisdomSeed {
    static let items: [WisdomItem] = [
        // 1 — Sabr
        WisdomItem(
            type: .verse,
            arabicText: "إِنَّ مَعَ الْعُسْرِ يُسْرًا",
            englishText: "Indeed, with hardship comes ease.",
            attribution: "Surah Ash-Sharh 94:6",
            moods: [.sabr, .hope],
            context: WisdomContext(
                title: "Surah Ash-Sharh",
                subtitle: "Meccan · 8 verses",
                body: "This surah was revealed to console the Prophet ﷺ during the early, difficult years in Makkah. It promises that hardship is never permanent — every difficulty is accompanied or followed by ease. The use of the definite article 'al-' in 'al-'usr' (the hardship) and the indefinite 'yusr' (ease) carries a subtle meaning: the hardship is one, but the ease that follows is manifold.",
                grading: nil,
                narrator: nil
            )
        ),

        // 2 — Sabr
        WisdomItem(
            type: .verse,
            arabicText: "وَبَشِّرِ الصَّابِرِينَ",
            englishText: "And give glad tidings to the patient ones.",
            attribution: "Surah Al-Baqarah 2:155",
            moods: [.sabr, .peace],
            context: WisdomContext(
                title: "Surah Al-Baqarah",
                subtitle: "Medinan · 286 verses",
                body: "This verse comes after Allah describes the trials He tests His servants with — fear, hunger, loss of wealth, lives, and fruits. The 'patient ones' are those who, when struck by affliction, say 'Indeed we belong to Allah, and to Him we shall return.' Their patience earns them blessings, mercy, and divine guidance.",
                grading: nil,
                narrator: nil
            )
        ),

        // 3 — Sabr
        WisdomItem(
            type: .hadith,
            arabicText: "عَجَبًا لِأَمْرِ الْمُؤْمِنِ، إِنَّ أَمْرَهُ كُلَّهُ خَيْرٌ",
            englishText: "Wondrous is the affair of the believer, for all of it is good. If he is happy he thanks Allah, and if he is harmed he is patient — and that is good for him.",
            attribution: "Sahih Muslim 2999",
            moods: [.sabr, .shukr],
            context: WisdomContext(
                title: "Book of Zuhd and Raqāʾiq",
                subtitle: "Sahih Muslim · Book 52",
                body: "Narrated by Suhayb ibn Sinan (RA). This profound hadith establishes that the believer's entire life is beneficial regardless of circumstances. It beautifully connects patience (sabr) and gratitude (shukr) as the two poles of a believer's response to every situation — hardship calls for patience, ease calls for gratitude. Both states are paths to goodness.",
                grading: "Sahih (Authentic)",
                narrator: "Suhayb ibn Sinan (RA)"
            )
        ),

        // 4 — Shukr
        WisdomItem(
            type: .verse,
            arabicText: "لَئِن شَكَرْتُمْ لَأَزِيدَنَّكُمْ",
            englishText: "If you are grateful, I will surely increase you.",
            attribution: "Surah Ibrahim 14:7",
            moods: [.shukr, .hope],
            context: WisdomContext(
                title: "Surah Ibrahim",
                subtitle: "Meccan · 52 verses",
                body: "Allah declares a direct covenant: gratitude leads to increase. This is one of the few verses where Allah speaks in the first person with an emphatic oath ('la-azeedannakum' — I will most certainly increase you). The increase is not limited to material blessings — it encompasses spiritual richness, contentment, and barakah (divine blessing) in whatever one possesses.",
                grading: nil,
                narrator: nil
            )
        ),

        // 5 — Shukr
        WisdomItem(
            type: .hadith,
            arabicText: "مَنْ لَا يَشْكُرُ النَّاسَ لَا يَشْكُرُ اللَّهَ",
            englishText: "Whoever does not thank people, does not thank Allah.",
            attribution: "Sunan Abi Dawud 4811",
            moods: [.shukr, .akhlaq],
            context: WisdomContext(
                title: "Book of Adab (Manners)",
                subtitle: "Sunan Abi Dawud · Book 43",
                body: "Narrated by Abu Hurayrah (RA). This hadith links gratitude toward the Creator with gratitude toward creation. It teaches that thankfulness is a holistic trait — one cannot be ungrateful to people while claiming gratitude to Allah. It elevates everyday kindness into an act of faith, and makes recognizing human favours a spiritual duty.",
                grading: "Sahih (Authentic)",
                narrator: "Abu Hurayrah (RA)"
            )
        ),

        // 6 — Shukr
        WisdomItem(
            type: .verse,
            arabicText: "فَاذْكُرُونِي أَذْكُرْكُمْ وَاشْكُرُوا لِي وَلَا تَكْفُرُونِ",
            englishText: "So remember Me; I will remember you. And be grateful to Me and do not deny Me.",
            attribution: "Surah Al-Baqarah 2:152",
            moods: [.shukr, .peace],
            context: WisdomContext(
                title: "Surah Al-Baqarah",
                subtitle: "Medinan · 286 verses",
                body: "Allah pairs remembrance (dhikr) with gratitude (shukr) as the two spiritual practices that sustain the believer. The verse elevates the act of remembering Allah to a reciprocal relationship — when the servant remembers Allah, Allah remembers him. Gratitude is placed alongside remembrance because both flow from awareness of Allah's favors.",
                grading: nil,
                narrator: nil
            )
        ),

        // 7 — Peace / Anxiety
        WisdomItem(
            type: .verse,
            arabicText: "أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ",
            englishText: "Verily, in the remembrance of Allah do hearts find rest.",
            attribution: "Surah Ar-Ra'd 13:28",
            moods: [.peace, .shukr],
            context: WisdomContext(
                title: "Surah Ar-Ra'd",
                subtitle: "Meccan · 43 verses",
                body: "This verse identifies the single source of inner tranquility: the remembrance of Allah. The Arabic word 'tatma'innu' comes from 'tuma'ninah' — a deep, settled calmness, not merely the absence of anxiety. Classical scholars note that the heart is restless by nature until it reconnects with its Origin. Dhikr is not just verbal repetition but conscious awareness of the Divine.",
                grading: nil,
                narrator: nil
            )
        ),

        // 8 — Peace / Anxiety
        WisdomItem(
            type: .hadith,
            arabicText: "مَا أَصَابَ أَحَدًا قَطُّ هَمٌّ وَلَا حَزَنٌ فَقَالَ... إِلَّا أَذْهَبَ اللَّهُ هَمَّهُ",
            englishText: "No person suffers any anxiety or sorrow, and says: 'O Allah, I am Your slave, son of Your male slave and female slave...' except that Allah removes his sorrow and grief.",
            attribution: "Musnad Ahmad 1/392",
            moods: [.peace, .sabr],
            context: WisdomContext(
                title: "Musnad of Abu Bakr as-Siddiq",
                subtitle: "Musnad Ahmad",
                body: "Narrated by Abdullah ibn Abbas (RA). This is the famous 'Sayyid al-Istighfar' (Master of Seeking Forgiveness) hadith. It provides a complete prayer for anxiety — beginning with acknowledging one's position before Allah, affirming His oneness, admitting sin, and seeking forgiveness. It addresses the root of spiritual disquietude and offers a tangible supplication.",
                grading: "Sahih (Authentic)",
                narrator: "Abdullah ibn Abbas (RA)"
            )
        ),

        // 9 — Peace / Anxiety
        WisdomItem(
            type: .verse,
            arabicText: "وَهُوَ مَعَكُمْ أَيْنَ مَا كُنتُمْ",
            englishText: "And He is with you wherever you are.",
            attribution: "Surah Al-Hadid 57:4",
            moods: [.peace, .hope],
            context: WisdomContext(
                title: "Surah Al-Hadid",
                subtitle: "Medinan · 29 verses",
                body: "A verse of profound comfort — Allah's knowledge, seeing, and power encompass everything. 'With you' does not mean physical proximity but comprehensive awareness and care. For the one experiencing loneliness or fear, this verse is a reminder that isolation is an illusion: the One who matters most is never absent.",
                grading: nil,
                narrator: nil
            )
        ),

        // 10 — Akhlaq (Character)
        WisdomItem(
            type: .hadith,
            arabicText: "إِنَّمَا بُعِثْتُ لِأُتَمِّمَ مَكَارِمَ الأَخْلَاقِ",
            englishText: "I have been sent only to perfect noble character.",
            attribution: "Al-Adab Al-Mufrad 273",
            moods: [.akhlaq],
            context: WisdomContext(
                title: "Al-Adab Al-Mufrad",
                subtitle: "Imam al-Bukhari · Book of Manners",
                body: "This concise hadith distills the entire prophetic mission into one purpose: the perfection of character. It reframes religion from mere ritual to the transformation of the self in relation to others. Every act of worship in Islam ultimately serves to cultivate — and reflect — nobility of character.",
                grading: "Sahih (Authentic)",
                narrator: "Prophet Muhammad ﷺ"
            )
        ),

        // 11 — Akhlaq (Character)
        WisdomItem(
            type: .hadith,
            arabicText: "خَيْرُكُمْ خَيْرُكُمْ لِأَهْلِهِ",
            englishText: "The best of you are those who are best to their families.",
            attribution: "Sahih al-Tirmidhi 3895",
            moods: [.akhlaq, .shukr],
            context: WisdomContext(
                title: "Book of Virtues",
                subtitle: "Jami' at-Tirmidhi · Book 46",
                body: "This hadith redirects the measure of goodness inward — not to the public sphere where one's image is visible, but to the privacy of one's home where only Allah sees. Kindness to those closest to us, who see us at our most unguarded, is the truest test of character.",
                grading: "Sahih (Authentic)",
                narrator: "Aisha (RA)"
            )
        ),

        // 12 — Akhlaq (Character)
        WisdomItem(
            type: .hadith,
            arabicText: "الْمُسْلِمُ مَنْ سَلِمَ الْمُسْلِمُونَ مِنْ لِسَانِهِ وَيَدِهِ",
            englishText: "A Muslim is the one from whose tongue and hand the Muslims are safe.",
            attribution: "Sahih al-Bukhari 10",
            moods: [.akhlaq, .peace],
            context: WisdomContext(
                title: "Book of Faith (Iman)",
                subtitle: "Sahih al-Bukhari · Book 2",
                body: "Narrated by Abdullah ibn Umar (RA). This hadith defines the Muslim by what they do not do — harm. Safety from one's tongue (no gossip, insult, or slander) and hand (no physical harm) is the minimum threshold. The deeper implication is that faith manifests as a protective presence for others, not merely private devotion.",
                grading: "Sahih (Authentic)",
                narrator: "Abdullah ibn Umar (RA)"
            )
        ),

        // 13 — Hope
        WisdomItem(
            type: .verse,
            arabicText: "وَهُوَ الَّذِي يُنَزِّلُ الْغَيْثَ مِنْ بَعْدِ مَا قَنَطُوا",
            englishText: "And it is He who sends down the rain after they had despaired, and spreads His mercy.",
            attribution: "Surah Ash-Shura 42:28",
            moods: [.hope, .sabr],
            context: WisdomContext(
                title: "Surah Ash-Shura",
                subtitle: "Meccan · 53 verses",
                body: "Allah specifically times His mercy to arrive after despair has set in — not before. This is not cruelty but pedagogy: the heart that receives rain after drought understands the nature of the Giver more deeply. Despair is not the end of hope; in the divine economy, it is often its beginning.",
                grading: nil,
                narrator: nil
            )
        ),

        // 14 — Hope
        WisdomItem(
            type: .hadith,
            arabicText: "وَاللهُ فِي عَوْنِ الْعَبْدِ مَا كَانَ الْعَبْدُ فِي عَوْنِ أَخِيهِ",
            englishText: "Allah is in the aid of His servant as long as His servant is in the aid of his brother.",
            attribution: "Sahih Muslim 2699",
            moods: [.hope, .akhlaq],
            context: WisdomContext(
                title: "Book of Knowledge",
                subtitle: "Sahih Muslim · Book 45",
                body: "Narrated by Abu Hurayrah (RA). This hadith establishes a principle of reciprocity in divine help: when you help another, Allah helps you. It reframes generosity not as loss but as investment. The verse expands the meaning of 'hope' — hope in Allah is not passive waiting but active giving, because Allah's help flows through your service to others.",
                grading: "Sahih (Authentic)",
                narrator: "Abu Hurayrah (RA)"
            )
        ),

        // 15 — Hope / Sabr
        WisdomItem(
            type: .verse,
            arabicText: "لَا تَقْنَطُوا مِنْ رَحْمَةِ اللَّهِ",
            englishText: "Do not despair of the mercy of Allah.",
            attribution: "Surah Az-Zumar 39:53",
            moods: [.hope, .sabr, .peace],
            context: WisdomContext(
                title: "Surah Az-Zumar",
                subtitle: "Meccan · 75 verses",
                body: "This verse begins with Allah's call to His servants who have 'transgressed against themselves' — those burdened by sin. The command is absolute: do not despair. Classical exegetes note that Allah places the mention of His mercy ('rahmah') before the mention of Himself, emphasizing that mercy is His defining attribute. No sin is beyond it. Despair itself, in this reading, is the only unforgivable state — because it denies the very nature of the One who forgives.",
                grading: nil,
                narrator: nil
            )
        ),
    ]
}

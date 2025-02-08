import 'package:cloud_firestore/cloud_firestore.dart';

class QuranService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch verse based on event or month
  Future<Map<String, String>> fetchQuranVerseByEventOrMonth({
    String? event,
    String? month,
  }) async {
    try {
      // Query Arabic Collection
      QuerySnapshot arabicSnapshot = await _db
          .collection('quran_arabic')
          .where('event', isEqualTo: event)
          .where('month', isEqualTo: month)
          .limit(1)
          .get();

      // Query English Collection
      QuerySnapshot englishSnapshot = await _db
          .collection('quran_english')
          .where('event', isEqualTo: event)
          .where('month', isEqualTo: month)
          .limit(1)
          .get();

      if (arabicSnapshot.docs.isNotEmpty && englishSnapshot.docs.isNotEmpty) {
        var arabicData = arabicSnapshot.docs.first.data() as Map<String, dynamic>;
        var englishData = englishSnapshot.docs.first.data() as Map<String, dynamic>;

        return {
          'verse_arabic': arabicData['verse_arabic'] ?? '',
          'verse_translation': englishData['verse_translation'] ?? '',
        };
      }

      return {
        'verse_arabic': 'No verse found',
        'verse_translation': 'No verse found',
      };
    } catch (e) {
      print("Error fetching verse: $e");
      return {
        'verse_arabic': 'Error fetching data',
        'verse_translation': 'Error fetching data',
      };
    }
  }
}

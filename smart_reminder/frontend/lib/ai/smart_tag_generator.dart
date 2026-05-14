import '../api/ai_api.dart';

class SmartTagGenerator {
  // Common stop words to exclude from local tag extraction
  static const _stopWords = {
    'the', 'a', 'an', 'and', 'or', 'but', 'in', 'on', 'at', 'to', 'for',
    'of', 'with', 'by', 'from', 'is', 'it', 'this', 'that', 'was', 'are',
    'be', 'as', 'i', 'my', 'we', 'you', 'he', 'she', 'they', 'have', 'has',
    'had', 'do', 'did', 'not', 'so', 'if', 'can', 'will', 'just', 'about',
  };

  /// Calls AI API to suggest tags for note content.
  Future<List<String>> suggestFromAi(String content) async {
    if (content.trim().isEmpty) return [];
    try {
      return await AiApi.suggestTags(content);
    } catch (e) {
      return _extractLocally(content);
    }
  }

  /// Local fallback: extracts frequent meaningful words as tags.
  List<String> _extractLocally(String content) {
    final words = content
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z\s]'), '')
        .split(RegExp(r'\s+'))
        .where((w) => w.length > 3 && !_stopWords.contains(w))
        .toList();

    // Count frequency
    final freq = <String, int>{};
    for (final w in words) {
      freq[w] = (freq[w] ?? 0) + 1;
    }

    // Sort by frequency, take top 5
    final sorted = freq.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sorted.take(5).map((e) => e.key).toList();
  }

  /// Merges existing tags with new suggestions (deduped).
  List<String> merge(List<String> existing, List<String> newTags) {
    final merged = {...existing, ...newTags}.toList();
    return merged.take(10).toList();
  }
}

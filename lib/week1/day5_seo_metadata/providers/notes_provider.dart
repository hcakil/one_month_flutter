import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/note.dart';

/// State notifier for managing notes
class NotesNotifier extends StateNotifier<List<Note>> {
  NotesNotifier() : super([]);

  void addNote(Note note) {
    state = [...state, note];
  }

  void updateNote(Note updatedNote) {
    state = [
      for (final note in state)
        if (note.id == updatedNote.id) updatedNote else note,
    ];
  }

  void deleteNote(String id) {
    state = state.where((note) => note.id != id).toList();
  }

  void togglePin(String id) {
    state = [
      for (final note in state)
        if (note.id == id) note.copyWith(isPinned: !note.isPinned) else note,
    ];
  }

  void loadSampleNotes() {
    final now = DateTime.now();
    state = [
      Note(
        id: '1',
        title: 'SEO Basics',
        content: '''
Key points about SEO:
- Meta tags are crucial
- Page titles should be 30-60 characters
- Descriptions should be 120-160 characters
- Use relevant keywords naturally
- Optimize images with alt text
        ''',
        createdAt: now.subtract(const Duration(days: 2)),
        updatedAt: now.subtract(const Duration(hours: 3)),
        tags: ['SEO', 'Basics'],
        isPinned: true,
      ),
      Note(
        id: '2',
        title: 'Open Graph Protocol',
        content: '''
Essential OG tags:
- og:title - Page title for social media
- og:description - Brief description
- og:image - Featured image (1200x630px recommended)
- og:url - Canonical URL
- og:type - Content type (website, article, etc.)

Remember: Test with Facebook Debugger and Twitter Card Validator!
        ''',
        createdAt: now.subtract(const Duration(days: 1)),
        updatedAt: now.subtract(const Duration(hours: 1)),
        tags: ['Social Media', 'Meta Tags'],
      ),
      Note(
        id: '3',
        title: 'Flutter Web SEO Checklist',
        content: '''
✅ Dynamic title updates on route changes
✅ Meta description for each page
✅ Structured data (JSON-LD)
✅ Semantic HTML structure
✅ Image optimization
✅ Mobile responsiveness
✅ Fast loading times
✅ Clean URLs
✅ Sitemap.xml
✅ Robots.txt

Priority: Focus on meta tags and performance first!
        ''',
        createdAt: now.subtract(const Duration(hours: 12)),
        updatedAt: now.subtract(const Duration(minutes: 30)),
        tags: ['Flutter', 'Checklist'],
        isPinned: true,
      ),
    ];
  }
}

/// Provider for notes management
final notesProvider = StateNotifierProvider<NotesNotifier, List<Note>>((ref) {
  final notifier = NotesNotifier();
  notifier.loadSampleNotes(); // Load sample notes on initialization
  return notifier;
});

/// Provider for filtered notes (search)
final notesSearchQueryProvider = StateProvider<String>((ref) => '');

final filteredNotesProvider = Provider<List<Note>>((ref) {
  final notes = ref.watch(notesProvider);
  final searchQuery = ref.watch(notesSearchQueryProvider);

  if (searchQuery.isEmpty) {
    // Sort by pinned first, then by updated date
    final sorted = List<Note>.from(notes);
    sorted.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      return b.updatedAt.compareTo(a.updatedAt);
    });
    return sorted;
  }

  // Filter by search query
  final query = searchQuery.toLowerCase();
  return notes.where((note) {
    return note.title.toLowerCase().contains(query) ||
        note.content.toLowerCase().contains(query) ||
        note.tags.any((tag) => tag.toLowerCase().contains(query));
  }).toList();
});


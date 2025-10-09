import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/note.dart';
import '../providers/notes_provider.dart';

/// Notes management card
class NotesManagementCard extends ConsumerStatefulWidget {
  const NotesManagementCard({super.key});

  @override
  ConsumerState<NotesManagementCard> createState() => _NotesManagementCardState();
}

class _NotesManagementCardState extends ConsumerState<NotesManagementCard> {
  @override
  Widget build(BuildContext context) {
    final notes = ref.watch(filteredNotesProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.note_alt,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '📝 Learning Notes',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FilledButton.icon(
                  onPressed: () => _showAddNoteDialog(context),
                  icon: const Icon(Icons.add),
                  label: const Text('New Note'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Take notes about SEO concepts, best practices, and your learnings.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search notes...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                ref.read(notesSearchQueryProvider.notifier).state = value;
              },
            ),
            const SizedBox(height: 20),
            if (notes.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.note_add,
                        size: 64,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No notes yet',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Start taking notes about your SEO learnings',
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            else
              ...notes.map((note) => _buildNoteItem(context, note)),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteItem(BuildContext context, Note note) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: note.isPinned
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.5)
              : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
        ),
        borderRadius: BorderRadius.circular(12),
        color: note.isPinned
            ? Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3)
            : null,
      ),
      child: InkWell(
        onTap: () => _showNoteDialog(context, note),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (note.isPinned)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.push_pin,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  Expanded(
                    child: Text(
                      note.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (value) {
                      switch (value) {
                        case 'pin':
                          ref.read(notesProvider.notifier).togglePin(note.id);
                          break;
                        case 'edit':
                          _showEditNoteDialog(context, note);
                          break;
                        case 'delete':
                          _deleteNote(note.id);
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'pin',
                        child: Row(
                          children: [
                            Icon(note.isPinned ? Icons.push_pin_outlined : Icons.push_pin),
                            const SizedBox(width: 8),
                            Text(note.isPinned ? 'Unpin' : 'Pin'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit),
                            SizedBox(width: 8),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Delete', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                note.content,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    note.formattedDate,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  if (note.tags.isNotEmpty) ...[
                    const SizedBox(width: 16),
                    Expanded(
                      child: Wrap(
                        spacing: 4,
                        children: note.tags.take(3).map((tag) {
                          return Chip(
                            label: Text(tag),
                            labelStyle: const TextStyle(fontSize: 10),
                            padding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showNoteDialog(BuildContext context, Note note) {
    showDialog(
      context: context,
      builder: (context) => NoteViewDialog(note: note),
    );
  }

  void _showAddNoteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => NoteEditDialog(
        onSave: (title, content, tags) {
          final newNote = Note(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: title,
            content: content,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            tags: tags,
          );
          ref.read(notesProvider.notifier).addNote(newNote);
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _showEditNoteDialog(BuildContext context, Note note) {
    showDialog(
      context: context,
      builder: (context) => NoteEditDialog(
        note: note,
        onSave: (title, content, tags) {
          final updatedNote = note.copyWith(
            title: title,
            content: content,
            tags: tags,
            updatedAt: DateTime.now(),
          );
          ref.read(notesProvider.notifier).updateNote(updatedNote);
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _deleteNote(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              ref.read(notesProvider.notifier).deleteNote(id);
              Navigator.of(context).pop();
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

/// Dialog for viewing note details
class NoteViewDialog extends StatelessWidget {
  final Note note;

  const NoteViewDialog({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 500),
        child: Column(
          children: [
            AppBar(
              title: const Text('Note Details'),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (note.isPinned)
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.push_pin,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        Expanded(
                          child: Text(
                            note.title,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Updated ${note.formattedDate}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 16),
                    if (note.tags.isNotEmpty) ...[
                      Wrap(
                        spacing: 8,
                        children: note.tags.map((tag) {
                          return Chip(label: Text(tag));
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                    ],
                    const Divider(),
                    const SizedBox(height: 16),
                    Text(
                      note.content,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Dialog for adding/editing notes
class NoteEditDialog extends StatefulWidget {
  final Note? note;
  final Function(String title, String content, List<String> tags) onSave;

  const NoteEditDialog({
    super.key,
    this.note,
    required this.onSave,
  });

  @override
  State<NoteEditDialog> createState() => _NoteEditDialogState();
}

class _NoteEditDialogState extends State<NoteEditDialog> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late TextEditingController _tagsController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(text: widget.note?.content ?? '');
    _tagsController = TextEditingController(
      text: widget.note?.tags.join(', ') ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  void _save() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title')),
      );
      return;
    }

    final tags = _tagsController.text
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toList();

    widget.onSave(
      _titleController.text,
      _contentController.text,
      tags,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 600),
        child: Column(
          children: [
            AppBar(
              title: Text(widget.note == null ? 'New Note' : 'Edit Note'),
              automaticallyImplyLeading: false,
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: _save,
                  child: const Text('Save'),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                      autofocus: true,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _contentController,
                      decoration: const InputDecoration(
                        labelText: 'Content',
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                      maxLines: 10,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _tagsController,
                      decoration: const InputDecoration(
                        labelText: 'Tags (comma separated)',
                        border: OutlineInputBorder(),
                        hintText: 'SEO, Flutter, Web',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


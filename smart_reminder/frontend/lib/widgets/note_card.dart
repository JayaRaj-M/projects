import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/utils/date_formatter.dart';
import '../models/note_model.dart';

class NoteCard extends StatelessWidget {
  final NoteModel note;
  final VoidCallback onTap;

  const NoteCard({super.key, required this.note, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.noteColors[note.colorIndex],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (note.isPinned)
              const Icon(Icons.push_pin, size: 14, color: AppColors.textSecondary),
            if (note.title.isNotEmpty)
              Text(
                note.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textPrimary),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            if (note.title.isNotEmpty && note.content.isNotEmpty)
              const SizedBox(height: 6),
            Expanded(
              child: Text(
                note.content,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                if (note.hasVoice) const Icon(Icons.mic, size: 12, color: AppColors.textSecondary),
                const Spacer(),
                Text(
                  DateFormatter.format(note.updatedAt),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
            if (note.tags.isNotEmpty) ...[
              const SizedBox(height: 6),
              Wrap(
                spacing: 4,
                children: note.tags.take(2).map((tag) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('#$tag', style: const TextStyle(fontSize: 10, color: AppColors.primary)),
                )).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
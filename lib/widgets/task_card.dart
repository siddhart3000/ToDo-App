import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../core/constants/colors.dart';
import '../core/constants/spacing.dart';
import '../models/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const TaskCard({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    String formattedTime = task.dueDateTime != null 
        ? DateFormat('h:mm a').format(task.dueDateTime!) 
        : '';
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onEdit, // Make the whole card clickable for editing
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          children: [
            // Styled Icon Box
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: _getCategoryColor(task.category),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getCategoryIcon(task.category),
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            // Task Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                      decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    task.isCompleted ? 'Completed' : (formattedTime.isNotEmpty ? 'Due at $formattedTime' : 'In Progress'),
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.textSecondaryDark : Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            // Completion Status Badge or Toggle
            GestureDetector(
              onTap: () { // Fixed: Removed (e) parameter
                onToggle();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: task.isCompleted 
                      ? AppColors.green.withOpacity(0.1) 
                      : AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  task.isCompleted ? 'DONE' : 'TODO',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: task.isCompleted ? AppColors.green : AppColors.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 4),
            // Simple Popup Menu for Edit/Delete
            PopupMenuButton<String>(
              padding: EdgeInsets.zero,
              onSelected: (val) {
                if (val == 'edit') onEdit();
                if (val == 'delete') onDelete();
              },
              itemBuilder: (ctx) => [
                const PopupMenuItem(value: 'edit', child: Text('Edit')),
                const PopupMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(color: Colors.red))),
              ],
              icon: Icon(Icons.more_vert, size: 20, color: isDark ? Colors.grey[400] : Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Design': return const Color(0xFF68E1FD);
      case 'Meeting': return const Color(0xFF9086FF);
      case 'Learning': return const Color(0xFFFF9A6C);
      case 'Work': return const Color(0xFF5AC8FA);
      case 'Health': return const Color(0xFFFF7171);
      case 'Personal': return const Color(0xFFFDA085);
      case 'Shopping': return const Color(0xFFF6D365);
      default: return AppColors.primary;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Design': return Icons.edit_outlined;
      case 'Meeting': return Icons.videocam_outlined;
      case 'Learning': return Icons.psychology_outlined;
      case 'Work': return Icons.laptop_mac;
      case 'Health': return Icons.favorite_outline;
      case 'Personal': return Icons.person_outline;
      case 'Shopping': return Icons.shopping_cart_outlined;
      default: return Icons.check_circle_outline;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/spacing.dart';
import '../../providers/task_provider.dart';
import '../../widgets/task_card.dart';
import '../../models/task_model.dart';

class CategoryTasksScreen extends ConsumerWidget {
  final String category;
  final Gradient gradient;

  const CategoryTasksScreen({
    super.key,
    required this.category,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksState = ref.watch(tasksProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                category,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              background: Container(decoration: BoxDecoration(gradient: gradient)),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          tasksState.when(
            data: (tasks) {
              final filteredTasks = tasks.where((t) => t.category == category).toList();
              return SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                sliver: filteredTasks.isEmpty
                    ? const SliverFillRemaining(
                        child: Center(child: Text('No tasks in this category.')),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (ctx, i) => TaskCard(
                            task: filteredTasks[i],
                            onToggle: () => ref.read(tasksProvider.notifier).toggleTask(filteredTasks[i]),
                            onDelete: () => ref.read(tasksProvider.notifier).deleteTask(filteredTasks[i].id),
                            onEdit: () => _showEditTaskSheet(context, ref, filteredTasks[i]),
                          ),
                          childCount: filteredTasks.length,
                        ),
                      ),
              );
            },
            loading: () => const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
            error: (err, stack) => SliverFillRemaining(child: Center(child: Text('Error: $err'))),
          ),
        ],
      ),
    );
  }

  void _showEditTaskSheet(BuildContext context, WidgetRef ref, TaskModel task) async {
    final titleController = TextEditingController(text: task.title);
    final descController = TextEditingController(text: task.description);
    DateTime? selectedDateTime = task.dueDateTime;
    String selectedCategory = task.category;
    bool isReminderEnabled = task.isReminderEnabled;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    bool isDateTimeRequired(String cat) => cat == 'Meeting' || cat == 'Work' || cat == 'Health';

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 24, right: 24, top: 24),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white, 
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Edit Task', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary)),
              const SizedBox(height: 20),
              TextField(
                controller: titleController,
                autofocus: true,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  hintText: 'What needs to be done?', 
                  hintStyle: TextStyle(color: isDark ? Colors.grey : Colors.grey[400]),
                  prefixIcon: Icon(Icons.task_alt, color: isDark ? AppColors.primary : Colors.grey), 
                  filled: true, 
                  fillColor: isDark ? Colors.grey[900] : Colors.grey[100], 
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),
              if (isDateTimeRequired(selectedCategory)) ...[
                const Text('This category requires a date & time', style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
              ],
              InkWell(
                onTap: () async {
                  final date = await showDatePicker(context: context, initialDate: selectedDateTime ?? DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)));
                  if (date != null) {
                    final time = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(selectedDateTime ?? DateTime.now()));
                    if (time != null) {
                      setSheetState(() => selectedDateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute));
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: (isDateTimeRequired(selectedCategory) && selectedDateTime == null) ? Colors.red.withOpacity(0.05) : AppColors.primary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: (isDateTimeRequired(selectedCategory) && selectedDateTime == null) ? Border.all(color: Colors.red.withOpacity(0.5)) : null,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_month_outlined, color: (isDateTimeRequired(selectedCategory) && selectedDateTime == null) ? Colors.red : AppColors.primary),
                      const SizedBox(width: 12),
                      Text(
                        selectedDateTime == null ? 'Select Date & Time' : DateFormat('MMM d, h:mm a').format(selectedDateTime!), 
                        style: TextStyle(color: selectedDateTime == null ? Colors.grey : AppColors.primary, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: Text('Enable Reminder', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                value: isReminderEnabled,
                onChanged: (val) => setSheetState(() => isReminderEnabled = val),
                activeColor: AppColors.primary,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isEmpty) return;
                    if (isDateTimeRequired(selectedCategory) && selectedDateTime == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Date and Time is required for this category!')));
                      return;
                    }
                    ref.read(tasksProvider.notifier).updateTask(task.copyWith(
                      title: titleController.text, 
                      description: descController.text, 
                      dueDateTime: selectedDateTime, 
                      isReminderEnabled: isReminderEnabled
                    ));
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                  child: const Text('Save Changes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

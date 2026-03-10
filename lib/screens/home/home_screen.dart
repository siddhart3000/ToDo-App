import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/spacing.dart';
import '../../providers/auth_provider.dart';
import '../../providers/task_provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/category_card.dart';
import '../../widgets/task_card.dart';
import '../../models/task_model.dart';
import '../profile/profile_screen.dart';
import 'category_tasks_screen.dart';
import '../analytics/analytics_screen.dart';
import '../../services/notification_service.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final tasksState = ref.watch(tasksProvider);
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    final List<Map<String, dynamic>> categories = [
      {'title': 'Design', 'icon': Icons.brush_outlined, 'gradient': AppColors.categoryGradient1},
      {'title': 'Meeting', 'icon': Icons.groups_outlined, 'gradient': AppColors.categoryGradient2},
      {'title': 'Learning', 'icon': Icons.psychology_outlined, 'gradient': AppColors.categoryGradient3},
      {'title': 'Work', 'icon': Icons.work_outline, 'gradient': const LinearGradient(colors: [Colors.indigoAccent, Colors.blue])},
      {'title': 'Health', 'icon': Icons.favorite_border, 'gradient': const LinearGradient(colors: [Colors.greenAccent, Colors.teal])},
      {'title': 'Personal', 'icon': Icons.person_outline, 'gradient': const LinearGradient(colors: [Colors.purpleAccent, Colors.deepPurple])},
      {'title': 'Shopping', 'icon': Icons.shopping_bag_outlined, 'gradient': const LinearGradient(colors: [Colors.orangeAccent, Colors.deepOrange])},
      {'title': 'Others', 'icon': Icons.more_horiz, 'gradient': const LinearGradient(colors: [Colors.blueGrey, Colors.grey])},
    ];

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Hello!', style: TextStyle(color: Colors.white70, fontSize: 18)),
                              Text(
                                user?.displayName ?? user?.email?.split('@')[0].toUpperCase() ?? 'USER',
                                style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (ctx) => const ProfileScreen()),
                            ),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white24,
                              backgroundImage: user?.photoURL != null && user!.photoURL!.isNotEmpty 
                                  ? NetworkImage(user!.photoURL!) 
                                  : const NetworkImage('https://i.pravatar.cc/150?u=a042581f4e29026704d'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (val) => setState(() => _searchQuery = val.toLowerCase()),
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Search tasks...',
                            hintStyle: TextStyle(color: Colors.white60),
                            icon: Icon(Icons.search, color: Colors.white),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      const Text('Categories', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: AppSpacing.md),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: categories.map((cat) {
                            return CategoryCard(
                              title: cat['title'],
                              taskCount: tasksState.maybeWhen(
                                data: (tasks) => tasks.where((t) => t.category == cat['title']).length,
                                orElse: () => 0,
                              ),
                              icon: cat['icon'],
                              gradient: cat['gradient'],
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => CategoryTasksScreen(category: cat['title'], gradient: cat['gradient']),
                                ),
                              ),
                              onAddTap: () => _showAddTaskSheet(context, ref, cat['title']),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                    ],
                  ),
                ),
              ),
            ),

            // Progress Card
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: InkWell(
                onTap: () => Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (ctx) => const AnalyticsScreen()),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFF8E86FF), Color(0xFF6C63FF)]),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [BoxShadow(color: const Color(0xFF6C63FF).withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('You are on Track', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            tasksState.maybeWhen(
                              data: (tasks) {
                                if (tasks.isEmpty) return const Text('No tasks yet', style: TextStyle(color: Colors.white70, fontSize: 12));
                                final completed = tasks.where((t) => t.isCompleted).length;
                                final percent = (completed / tasks.length * 100).toInt();
                                return Text('$percent% Progress have made', style: const TextStyle(color: Colors.white70, fontSize: 12));
                              },
                              orElse: () => const Text('Calculating...', style: TextStyle(color: Colors.white70, fontSize: 12)),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.show_chart, color: Colors.white, size: 40),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today's Task", 
                    style: TextStyle(
                      fontSize: 22, 
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  tasksState.when(
                    data: (tasks) {
                      // Filter by Date (Only show tasks for today) AND Search Query
                      final now = DateTime.now();
                      final filteredTasks = tasks.where((t) {
                        final isSameDay = t.dueDateTime != null && 
                            t.dueDateTime!.year == now.year &&
                            t.dueDateTime!.month == now.month &&
                            t.dueDateTime!.day == now.day;
                        
                        final matchesSearch = t.title.toLowerCase().contains(_searchQuery);
                        
                        return isSameDay && matchesSearch;
                      }).toList();

                      if (filteredTasks.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(50), 
                            child: Text(
                              _searchQuery.isEmpty ? 'No tasks for today!' : 'No matching tasks found.',
                              style: TextStyle(color: isDark ? AppColors.textSecondaryDark : Colors.grey),
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredTasks.length,
                        itemBuilder: (context, index) => TaskCard(
                          task: filteredTasks[index],
                          onToggle: () => ref.read(tasksProvider.notifier).toggleTask(filteredTasks[index]),
                          onDelete: () => ref.read(tasksProvider.notifier).deleteTask(filteredTasks[index].id),
                          onEdit: () => _showAddTaskSheet(context, ref, filteredTasks[index].category, task: filteredTasks[index]),
                        ),
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (err, stack) => Center(child: Text('Error: $err')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskSheet(context, ref, 'General'),
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }

  void _showAddTaskSheet(BuildContext context, WidgetRef ref, String initialCategory, {TaskModel? task}) async {
    final titleController = TextEditingController(text: task?.title);
    final descController = TextEditingController(text: task?.description);
    DateTime? selectedDateTime = task?.dueDateTime;
    String selectedCategory = task?.category ?? initialCategory;
    bool isReminderEnabled = task?.isReminderEnabled ?? false;
    bool isAlarmEnabled = task?.isAlarmEnabled ?? false;
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
              Text(
                task == null ? 'New Task' : 'Edit Task', 
                style: TextStyle(
                  fontSize: 24, 
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ['General', 'Design', 'Meeting', 'Learning', 'Work', 'Health', 'Personal', 'Shopping', 'Others'].map((cat) {
                    final isSelected = selectedCategory == cat;
                    return GestureDetector(
                      onTap: () => setSheetState(() => selectedCategory = cat),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : (isDark ? Colors.grey[800] : Colors.grey[200]), 
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(cat, style: TextStyle(color: isSelected ? Colors.white : (isDark ? Colors.grey[400] : Colors.black), fontWeight: FontWeight.bold)),
                      ),
                    );
                  }).toList(),
                ),
              ),
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
                onChanged: (val) async {
                  if (val) {
                    final granted = await NotificationService().requestPermission();
                    if (!granted) return;
                  }
                  setSheetState(() => isReminderEnabled = val);
                },
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
                    if (task == null) {
                      ref.read(tasksProvider.notifier).addTask(titleController.text, descController.text, selectedCategory, dueDateTime: selectedDateTime);
                    } else {
                      ref.read(tasksProvider.notifier).updateTask(task.copyWith(title: titleController.text, description: descController.text, category: selectedCategory, dueDateTime: selectedDateTime, isReminderEnabled: isReminderEnabled, isAlarmEnabled: isAlarmEnabled));
                    }
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                  child: const Text('Save Task', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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

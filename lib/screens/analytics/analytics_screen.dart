import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/spacing.dart';
import '../../providers/task_provider.dart';
import '../../providers/theme_provider.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksState = ref.watch(tasksProvider);
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        title: const Text('Statistics'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: tasksState.when(
        data: (tasks) {
          final completedCount = tasks.where((t) => t.isCompleted).length;
          final totalCount = tasks.length;
          final completionRate = totalCount == 0 ? 0 : (completedCount / totalCount * 100).toInt();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Summary Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'You are on Track',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '$completionRate% Progress have made',
                            style: const TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                        ],
                      ),
                      const Icon(Icons.auto_graph, color: Colors.white, size: 40),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                
                const Text(
                  'Category Overview',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppSpacing.md),
                _buildCategoryProgress('Design', tasks, Colors.cyan),
                _buildCategoryProgress('Meeting', tasks, Colors.orange),
                _buildCategoryProgress('Learning', tasks, Colors.purple),
                
                const SizedBox(height: AppSpacing.xl),
                const Text(
                  'Weekly Activity',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppSpacing.md),
                
                // Calendar Days
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    itemBuilder: (ctx, i) {
                      final day = DateTime.now().add(Duration(days: i - 2));
                      final isToday = i == 2;
                      return Container(
                        width: 60,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: isToday ? AppColors.primary : (isDark ? AppColors.surfaceDark : Colors.white),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            if (!isToday) BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('dd').format(day),
                              style: TextStyle(
                                color: isToday ? Colors.white : (isDark ? Colors.white : Colors.black),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              DateFormat('EEE').format(day),
                              style: TextStyle(
                                color: isToday ? Colors.white70 : Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                
                // Line Chart
                Container(
                  height: 200,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceDark : Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: false),
                      titlesData: const FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true,
                          color: AppColors.primary,
                          barWidth: 4,
                          dotData: const FlDotData(show: true),
                          belowBarData: BarAreaData(
                            show: true,
                            color: AppColors.primary.withOpacity(0.1),
                          ),
                          spots: const [
                            FlSpot(0, 1),
                            FlSpot(1, 3),
                            FlSpot(2, 2),
                            FlSpot(3, 5),
                            FlSpot(4, 3),
                            FlSpot(5, 4),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildCategoryProgress(String category, List tasks, Color color) {
    final catTasks = tasks.where((t) => t.category == category).toList();
    final completed = catTasks.where((t) => t.isCompleted).length;
    final total = catTasks.length;
    final percent = total == 0 ? 0.0 : completed / total;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.brush, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(category, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text('${(percent * 100).toInt()}%', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: percent,
                  backgroundColor: color.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  borderRadius: BorderRadius.circular(10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

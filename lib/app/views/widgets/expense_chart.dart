import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../../models/expense_model.dart';

class ExpenseChart extends GetView<HomeController> {
  const ExpenseChart({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Expense Overview',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: Obx(() {
                final expenses = controller.expenses;
                if (expenses.isEmpty) {
                  return Center(
                    child: Text(
                      'No data available',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  );
                }

                // Group expenses by category
                final Map<String, double> categoryTotals = {};
                for (var expense in expenses) {
                  categoryTotals[expense.category] =
                      (categoryTotals[expense.category] ?? 0) + expense.amount;
                }

                final sections = categoryTotals.entries.map((entry) {
                  final color = _getCategoryColor(entry.key);
                  return PieChartSectionData(
                    value: entry.value,
                    title: '${(entry.value / categoryTotals.values.reduce((a, b) => a + b) * 100).toStringAsFixed(1)}%',
                    color: color,
                    radius: 80,
                    titleStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  );
                }).toList();

                return PieChart(
                  PieChartData(
                    sections: sections,
                    centerSpaceRadius: 40,
                    sectionsSpace: 2,
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            Obx(() {
              final expenses = controller.expenses;
              if (expenses.isEmpty) return const SizedBox.shrink();

              // Group expenses by category
              final Map<String, double> categoryTotals = {};
              for (var expense in expenses) {
                categoryTotals[expense.category] =
                    (categoryTotals[expense.category] ?? 0) + expense.amount;
              }

              return Wrap(
                spacing: 16,
                runSpacing: 8,
                children: categoryTotals.entries.map((entry) {
                  final color = _getCategoryColor(entry.key);
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        entry.key,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  );
                }).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return Colors.orange;
      case 'Transport':
        return Colors.blue;
      case 'Entertainment':
        return Colors.purple;
      case 'Shopping':
        return Colors.pink;
      case 'Utilities':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
} 
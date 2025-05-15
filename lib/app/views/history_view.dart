import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'widgets/expense_list_item.dart';

class HistoryView extends GetView<HomeController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
          ),
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () => controller.clearFilters(),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.shadow.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );
                          if (date != null) {
                            controller.setDateFilter(date);
                          }
                        },
                        icon: const Icon(Icons.calendar_today),
                        label: Obx(() => Text(
                              controller.selectedDate.value != null
                                  ? '${controller.selectedDate.value!.day}/${controller.selectedDate.value!.month}/${controller.selectedDate.value!.year}'
                                  : 'Date',
                            )),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => _buildCategoryFilter(context),
                          );
                        },
                        icon: const Icon(Icons.category),
                        label: Obx(() => Text(
                              controller.selectedCategory.value ?? 'Category',
                            )),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(() => Row(
                        children: [
                          _buildFilterChip(
                            context,
                            label: 'All',
                            isSelected: controller.selectedFilter.value == 'All',
                            onTap: () => controller.setFilter('All'),
                          ),
                          _buildFilterChip(
                            context,
                            label: 'Today',
                            isSelected: controller.selectedFilter.value == 'Today',
                            onTap: () => controller.setFilter('Today'),
                          ),
                          _buildFilterChip(
                            context,
                            label: 'This Week',
                            isSelected: controller.selectedFilter.value == 'This Week',
                            onTap: () => controller.setFilter('This Week'),
                          ),
                          _buildFilterChip(
                            context,
                            label: 'This Month',
                            isSelected: controller.selectedFilter.value == 'This Month',
                            onTap: () => controller.setFilter('This Month'),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => controller.expenses.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.receipt_long,
                            size: 64,
                            color: theme.colorScheme.primary.withValues(alpha: 0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No expenses found',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: controller.expenses.length,
                      itemBuilder: (context, index) {
                        final expense = controller.expenses[index];
                        return ExpenseListItem(
                          expense: expense,
                          onDelete: () => controller.deleteExpense(expense.id),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter(BuildContext context) {
    final theme = Theme.of(context);
    final categories = [
      'Food',
      'Transport',
      'Entertainment',
      'Shopping',
      'Utilities',
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select Category',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          ...categories.map((category) => ListTile(
                title: Text(category),
                onTap: () {
                  controller.setCategoryFilter(category);
                  Get.back();
                },
              )),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () {
              controller.setCategoryFilter(null);
              Get.back();
            },
            child: const Text('Clear Category'),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context, {
    required String label,
    bool isSelected = false,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isSelected
                  ? Colors.white
                  : theme.colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
} 
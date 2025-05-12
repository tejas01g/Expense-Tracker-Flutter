import 'package:get/get.dart';
import '../models/expense_model.dart';

class HomeController extends GetxController {
  final expenses = <ExpenseModel>[].obs;
  final totalBalance = 0.0.obs;
  final selectedFilter = 'All'.obs;
  final selectedDate = Rxn<DateTime>();
  final selectedCategory = RxnString();

  @override
  void onInit() {
    super.onInit();
    loadExpenses();
  }

  void loadExpenses() {
    // Load dummy data for now
    expenses.value = ExpenseModel.getDummyExpenses();
    calculateTotalBalance();
  }

  void calculateTotalBalance() {
    totalBalance.value = expenses.fold(0, (sum, expense) => sum + expense.amount);
  }

  void addExpense(ExpenseModel expense) {
    expenses.add(expense);
    calculateTotalBalance();
  }

  void deleteExpense(String id) {
    expenses.removeWhere((expense) => expense.id == id);
    calculateTotalBalance();
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
    applyFilters();
  }

  void setDateFilter(DateTime? date) {
    selectedDate.value = date;
    applyFilters();
  }

  void setCategoryFilter(String? category) {
    selectedCategory.value = category;
    applyFilters();
  }

  void applyFilters() {
    var filteredExpenses = ExpenseModel.getDummyExpenses();

    // Apply date filter
    if (selectedDate.value != null) {
      filteredExpenses = filteredExpenses.where((expense) {
        return expense.date.year == selectedDate.value!.year &&
            expense.date.month == selectedDate.value!.month &&
            expense.date.day == selectedDate.value!.day;
      }).toList();
    }

    // Apply category filter
    if (selectedCategory.value != null) {
      filteredExpenses = filteredExpenses
          .where((expense) => expense.category == selectedCategory.value)
          .toList();
    }

    // Apply time period filter
    switch (selectedFilter.value) {
      case 'Today':
        final today = DateTime.now();
        filteredExpenses = filteredExpenses.where((expense) {
          return expense.date.year == today.year &&
              expense.date.month == today.month &&
              expense.date.day == today.day;
        }).toList();
        break;
      case 'This Week':
        final now = DateTime.now();
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        filteredExpenses = filteredExpenses.where((expense) {
          return expense.date.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
              expense.date.isBefore(now.add(const Duration(days: 1)));
        }).toList();
        break;
      case 'This Month':
        final now = DateTime.now();
        filteredExpenses = filteredExpenses.where((expense) {
          return expense.date.year == now.year && expense.date.month == now.month;
        }).toList();
        break;
    }

    expenses.value = filteredExpenses;
    calculateTotalBalance();
  }

  void clearFilters() {
    selectedFilter.value = 'All';
    selectedDate.value = null;
    selectedCategory.value = null;
    loadExpenses();
  }
} 
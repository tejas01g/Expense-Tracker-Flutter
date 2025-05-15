import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class DashboardController extends GetxController {
  // Time period selection
  final RxString selectedPeriod = 'Monthly'.obs;
  final List<String> periods = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

  // Summary data
  final RxDouble totalIncome = 0.0.obs;
  final RxDouble totalExpenses = 0.0.obs;
  final RxDouble savings = 0.0.obs;
  final RxDouble averageExpense = 0.0.obs;

  // Chart data
  final RxList<PieChartSectionData> pieChartSections = <PieChartSectionData>[].obs;
  final RxList<FlSpot> lineChartSpots = <FlSpot>[].obs;
  final RxList<BarChartGroupData> barChartGroups = <BarChartGroupData>[].obs;

  // Categories
  final List<Map<String, dynamic>> categories = [
    {'name': 'Food', 'color': const Color(0xFF4e54c8), 'amount': 1200.0},
    {'name': 'Transport', 'color': const Color(0xFF8f94fb), 'amount': 800.0},
    {'name': 'Shopping', 'color': const Color(0xFF6750A4), 'amount': 1500.0},
    {'name': 'Bills', 'color': const Color(0xFF625B71), 'amount': 2000.0},
    {'name': 'Entertainment', 'color': const Color(0xFFCCC2DC), 'amount': 600.0},
  ];

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  void _initializeData() {
    // Initialize summary data
    totalIncome.value = 5000.0;
    totalExpenses.value = 3500.0;
    savings.value = totalIncome.value - totalExpenses.value;
    averageExpense.value = totalExpenses.value / 30; // Monthly average

    // Initialize pie chart sections
    _updatePieChartSections();

    // Initialize line chart spots
    _updateLineChartSpots();

    // Initialize bar chart groups
    _updateBarChartGroups();
  }

  void _updatePieChartSections() {
    double total = categories.fold(0, (sum, category) => sum + category['amount']);
    
    pieChartSections.value = categories.map((category) {
      final percentage = (category['amount'] / total) * 100;
      return PieChartSectionData(
        color: category['color'],
        value: category['amount'],
        title: '${percentage.toStringAsFixed(1)}%',
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  void _updateLineChartSpots() {
    // Generate sample data for the last 7 days
    lineChartSpots.value = List.generate(7, (index) {
      return FlSpot(
        index.toDouble(),
        (index * 100 + 500).toDouble(), // Sample data
      );
    });
  }

  void _updateBarChartGroups() {
    // Generate sample data for the last 6 months
    barChartGroups.value = List.generate(6, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: (index * 500 + 1000).toDouble(), // Sample data
            color: const Color(0xFF4e54c8),
            width: 20,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
          ),
        ],
      );
    });
  }

  void updatePeriod(String period) {
    selectedPeriod.value = period;
    // Update chart data based on selected period
    _updateLineChartSpots();
    _updateBarChartGroups();
  }

  // Get color for category
  Color getCategoryColor(String category) {
    final categoryData = categories.firstWhere(
      (c) => c['name'] == category,
      orElse: () => {'color': const Color(0xFF4e54c8)},
    );
    return categoryData['color'];
  }

  // Get amount for category
  double getCategoryAmount(String category) {
    final categoryData = categories.firstWhere(
      (c) => c['name'] == category,
      orElse: () => {'amount': 0.0},
    );
    return categoryData['amount'];
  }
} 
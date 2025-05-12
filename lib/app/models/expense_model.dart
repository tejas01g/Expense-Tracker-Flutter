import 'package:flutter/material.dart';

class ExpenseModel {
  final String id;
  final double amount;
  final String description;
  final DateTime date;
  final String category;
  final IconData categoryIcon;
  final Color categoryColor;

  ExpenseModel({
    required this.id,
    required this.amount,
    required this.description,
    required this.date,
    required this.category,
    required this.categoryIcon,
    required this.categoryColor,
  });

  // Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'description': description,
      'date': date.toIso8601String(),
      'category': category,
      'categoryIcon': categoryIcon.codePoint,
      'categoryColor': categoryColor.value,
    };
  }

  // Create from Map for retrieval
  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'] as String,
      amount: map['amount'] as double,
      description: map['description'] as String,
      date: DateTime.parse(map['date'] as String),
      category: map['category'] as String,
      categoryIcon: IconData(map['categoryIcon'] as int, fontFamily: 'MaterialIcons'),
      categoryColor: Color(map['categoryColor'] as int),
    );
  }

  // Dummy data for testing
  static List<ExpenseModel> getDummyExpenses() {
    return [
      ExpenseModel(
        id: '1',
        amount: 50.0,
        description: 'Grocery shopping',
        date: DateTime.now().subtract(const Duration(days: 1)),
        category: 'Food',
        categoryIcon: Icons.restaurant,
        categoryColor: Colors.orange,
      ),
      ExpenseModel(
        id: '2',
        amount: 30.0,
        description: 'Movie tickets',
        date: DateTime.now().subtract(const Duration(days: 2)),
        category: 'Entertainment',
        categoryIcon: Icons.movie,
        categoryColor: Colors.purple,
      ),
      ExpenseModel(
        id: '3',
        amount: 100.0,
        description: 'Electricity bill',
        date: DateTime.now().subtract(const Duration(days: 3)),
        category: 'Utilities',
        categoryIcon: Icons.power,
        categoryColor: Colors.blue,
      ),
    ];
  }
} 
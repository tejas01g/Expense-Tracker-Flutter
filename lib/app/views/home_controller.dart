import 'package:get/get.dart';

class HomeController extends GetxController {
  final balance = 0.0.obs;
  final expenses = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with sample data
    balance.value = 5000.0;
    expenses.value = [
      {'title': 'Groceries', 'amount': 150.0, 'date': DateTime.now()},
      {'title': 'Transport', 'amount': 50.0, 'date': DateTime.now()},
    ];
  }

  void addExpense(Map<String, dynamic> expense) {
    expenses.add(expense);
    balance.value -= expense['amount'];
  }
} 
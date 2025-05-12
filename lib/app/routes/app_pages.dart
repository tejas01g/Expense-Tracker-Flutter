import 'package:get/get.dart';
import '../bindings/home_binding.dart';
import '../views/home_view.dart';
import '../views/add_expense_view.dart';
import '../views/history_view.dart';
import '../views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.ADD_EXPENSE,
      page: () => const AddExpenseView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.HISTORY,
      page: () => const HistoryView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfileView(),
    ),
  ];
} 
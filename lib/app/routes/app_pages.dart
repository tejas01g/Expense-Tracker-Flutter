import 'package:get/get.dart';
import '../bindings/home_binding.dart';
import '../views/home_view.dart';
import '../views/add_expense_view.dart';
import '../views/history_view.dart';
import '../views/profile_view.dart';
import '../views/expense_detail_view.dart';
import '../features/auth/auth_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/auth/auth_controller.dart';
import '../features/dashboard/dashboard_controller.dart';
import '../controllers/home_controller.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.AUTH,
      page: () => const AuthScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: Routes.DASHBOARD,
      page: () => DashboardScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<DashboardController>(() => DashboardController());
      }),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeController>(() => HomeController());
      }),
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
    GetPage(
      name: Routes.ONBOARDING,
      page: () => OnboardingScreen(),
    ),
    GetPage(
      name: Routes.EXPENSE_DETAIL,
      page: () => ExpenseDetailView(
        expense: Get.arguments,
      ),
      binding: HomeBinding(),
    ),
  ];
} 
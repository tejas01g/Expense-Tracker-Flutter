import 'package:get/get.dart';
import '../bindings/home_binding.dart';
import '../views/home_view.dart';
import '../views/add_expense_view.dart';
import '../views/history_view.dart';
import '../views/profile_view.dart';
import '../features/auth/auth_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/auth/auth_controller.dart';
import '../features/dashboard/dashboard_controller.dart';
import '../views/home_controller.dart';
import '../middleware/auth_middleware.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.ONBOARDING;

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
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeController>(() => HomeController());
      }),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.ADD_EXPENSE,
      page: () => const AddExpenseView(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.HISTORY,
      page: () => const HistoryView(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfileView(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.ONBOARDING,
      page: () => OnboardingScreen(),
    ),
  ];
} 
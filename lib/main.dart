import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/services/auth_service.dart';
import 'app/services/theme_service.dart';
import 'app/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize GetStorage
  await GetStorage.init();
  
  // Initialize Services
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => ThemeService().init());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeService = Get.find<ThemeService>();
    
    return GetMaterialApp(
      title: 'Expense Tracker',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeService.theme,
      initialRoute: Routes.HOME,
      getPages: AppPages.routes,
      defaultTransition: Transition.fade,
      debugShowCheckedModeBanner: false,
    );
  }
}

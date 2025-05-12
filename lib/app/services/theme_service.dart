import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService extends GetxService {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;
  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  void saveTheme(bool isDarkMode) => _box.write(_key, isDarkMode);

  void changeThemeMode(ThemeMode themeMode) {
    Get.changeThemeMode(themeMode);
    saveTheme(themeMode == ThemeMode.dark);
  }

  void switchTheme() {
    if (Get.isDarkMode) {
      changeThemeMode(ThemeMode.light);
    } else {
      changeThemeMode(ThemeMode.dark);
    }
  }
} 
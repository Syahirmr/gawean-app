import 'package:flutter/material.dart';

enum AppThemeMode {
  light,
  dark,
  auto,
}

class ThemeController {
  /// notifier yang dipakai MaterialApp
  static final ValueNotifier<ThemeMode> themeMode =
  ValueNotifier(ThemeMode.light);

  /// simpan pilihan user (light / dark / auto)
  static AppThemeMode _mode = AppThemeMode.light;

  /// dipakai UI
  static bool get isDarkMode => themeMode.value == ThemeMode.dark;

  /// support toggle lama
  static void toggleTheme(bool dark) {
    _mode = dark ? AppThemeMode.dark : AppThemeMode.light;
    themeMode.value = dark ? ThemeMode.dark : ThemeMode.light;
  }

  /// set auto mode
  static void setAutoMode() {
    _mode = AppThemeMode.auto;
    _applyAutoTheme();
  }

  /// 🔴 DIPANGGIL SAAT APP START (RELEASE SAFE)
  static Future<void> refreshAutoThemeIfNeeded() async {
    if (_mode == AppThemeMode.auto) {
      _applyAutoTheme();
    }
  }

  /// ===== PRIVATE =====
  static void _applyAutoTheme() {
    final hour = DateTime.now().hour;

    // 🌙 maghrib – subuh
    if (hour >= 18 || hour < 5) {
      themeMode.value = ThemeMode.dark;
    } else {
      themeMode.value = ThemeMode.light;
    }
  }
}

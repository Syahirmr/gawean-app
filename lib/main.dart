import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'theme/theme_controller.dart';
import 'navigation/main_navbar.dart';
import 'pages/calendar_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 🔴 WAJIB

  await ThemeController.refreshAutoThemeIfNeeded(); // 🔴 ASYNC

  runApp(const Gawean());
}

class Gawean extends StatelessWidget {
  const Gawean({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeMode,
      builder: (context, mode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Gawean',

          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          themeMode: mode,

          home: const MainNavbar(),

          routes: {
            '/calendar': (context) => const CalendarPage(),
          },
        );
      },
    );
  }
}

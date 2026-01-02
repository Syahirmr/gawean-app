import 'package:flutter/material.dart';
import '../theme/theme_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isDarkMode =
        Theme.of(context).brightness == Brightness.dark;
  }

  void _toggleTheme(bool isDark) {
    setState(() => _isDarkMode = isDark);
    ThemeController.toggleTheme(isDark);
  }

  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Theme Settings"),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _themeOption(
              icon: Icons.light_mode,
              label: "Light",
              active: !_isDarkMode,
              onTap: () {
                Navigator.pop(context);
                _toggleTheme(false);
              },
            ),
            const SizedBox(width: 16),
            _themeOption(
              icon: Icons.dark_mode,
              label: "Dark",
              active: _isDarkMode,
              onTap: () {
                Navigator.pop(context);
                _toggleTheme(true);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _themeOption({
    required IconData icon,
    required String label,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: active
                ? Theme.of(context).colorScheme.primary
                : Colors.grey,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(icon,
                size: 30,
                color: active
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey),
            const SizedBox(height: 8),
            Text(label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: active
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey,
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: _showThemeDialog,
        child: const Text("Change Theme"),
      ),
    );
  }
}

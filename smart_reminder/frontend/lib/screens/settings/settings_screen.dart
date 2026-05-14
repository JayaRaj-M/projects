import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_strings.dart';
import '../../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.settings)),
      body: ListView(
        children: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) => SwitchListTile(
              title: const Text(AppStrings.darkMode),
              secondary: const Icon(Icons.dark_mode_outlined),
              value: themeProvider.isDarkMode,
              onChanged: (_) => themeProvider.toggleTheme(),
            ),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text(AppStrings.notifications),
            secondary: const Icon(Icons.notifications_outlined),
            value: true,
            onChanged: (_) {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text(AppStrings.about),
            subtitle: const Text(AppStrings.version),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
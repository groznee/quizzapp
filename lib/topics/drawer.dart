import 'package:flutter/material.dart';
import 'package:quizz_app/services/models.dart';
import 'package:quizz_app/main.dart';
import 'package:quizz_app/theme.dart';

class ThemeDrawer extends StatelessWidget {
  final List<Topic> topics;
  const ThemeDrawer({super.key, required this.topics});

  void changeThemePls() {}

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).primaryColorDark.withOpacity(0.75),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  textAlign: TextAlign.center,
                  "What... is your favourite color? Please choose a theme below (no restart required).",
                ),
                ElevatedButton(
                    onPressed: () => HomeMaterialWidget.of(context)
                        .changeTheme(themeDefault),
                    child: const Text("Default Theme")),
                ElevatedButton(
                    onPressed: () =>
                        HomeMaterialWidget.of(context).changeTheme(themeBlue),
                    child: const Text("Amber Theme")),
                ElevatedButton(
                    onPressed: () =>
                        HomeMaterialWidget.of(context).changeTheme(themeRed),
                    child: const Text("Red Theme")),
                ElevatedButton(
                    onPressed: () =>
                        HomeMaterialWidget.of(context).changeTheme(themeGreen),
                    child: const Text("Green Theme")),
                ElevatedButton(
                    onPressed: () =>
                        HomeMaterialWidget.of(context).changeTheme(themeAmber),
                    child: const Text("Indigo Theme")),
              ],
            ),
          ),
        ));
  }
}

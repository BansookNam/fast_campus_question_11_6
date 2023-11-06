import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../app.dart';
import 'custom_theme.dart';
import 'custom_theme_holder.dart';

class CustomThemeApp extends StatefulWidget {
  final Widget child;

  const CustomThemeApp({Key? key, required this.child}) : super(key: key);

  @override
  State<CustomThemeApp> createState() => _CustomThemeAppState();
}

class _CustomThemeAppState extends State<CustomThemeApp> {
  final CustomTheme? defaultTheme = App.defaultTheme;
  late CustomTheme theme = defaultTheme ?? systemTheme;

  @override
  Widget build(BuildContext context) {
    return CustomThemeHolder(
      changeTheme: handleChangeTheme,
      theme: theme,
      child: widget.child,
    );
  }

  CustomTheme get systemTheme {
    switch (systemBrightness) {
      case Brightness.dark:
        return CustomTheme.dark;
      case Brightness.light:
        return CustomTheme.light;
    }
  }

  void handleChangeTheme(CustomTheme theme) {
    setState(() => this.theme = theme);
  }

  Brightness get systemBrightness =>
      SchedulerBinding.instance.platformDispatcher.platformBrightness;
}

extension ContextExtension on BuildContext {
  CustomTheme get themeType => CustomThemeHolder.of(this).theme;
}

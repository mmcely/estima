import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/theme/theme.dart';
import 'routes/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppThemes.lightTheme,
      dark: AppThemes.darkTheme,
      initial: AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ESTIMA - Gestion de Projets',
        theme: theme,
        darkTheme: darkTheme,
        initialRoute: '/login',

        getPages: AppRoutes.routes,

        // Page 404
        unknownRoute: GetPage(
          name: '/not-found',
          page: () => Scaffold(
            appBar: AppBar(title: const Text('Page non trouvée')),
            body: const Center(child: Text('Page non trouvée')),
          ),
        ),

        // Optionnel: Configuration responsive
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(1.0)),
            child: child!,
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/features/my_pokedex/presentation/pages/my_pokedex_page.dart';

import 'core/colors.dart';
import 'features/login/presentation/pages/login_page.dart';
import 'features/search/presentation/search_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.light,
      routerConfig: router,
      theme: appTheme,
    );
  }
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: LoginPage.route,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: SearchPage.route,
      builder: (context, state) => const SearchPage(),
    ),
    GoRoute(
      path: MyPokedexPage.route,
      builder: (context, state) => const MyPokedexPage(),
    ),
  ],
);

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primaryColor,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primaryColor,
    primary: AppColors.primaryColor,
  ),
  useMaterial3: true,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.primaryColor,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.primaryColor,
    foregroundColor: Colors.white,
  ),
);

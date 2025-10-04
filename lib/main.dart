import 'package:flutter/material.dart';
import 'package:food_recognizer_app/routes/route_navigation.dart';
import 'package:food_recognizer_app/screens/home_screen.dart';
import 'package:food_recognizer_app/themes/theme_apps.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Recognizer App',
      theme: ThemeApps.lightTheme,
      darkTheme: ThemeApps.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: RouteNavigation.home.name,
      routes: {
        RouteNavigation.home.name: (context) => const HomeScreen(),
        // RouteNavigation.result.name: (context) => const ResultScreen(),
        // RouteNavigation.details.name: (context) => const DetailsScreen(),
      },
    );
  }
}



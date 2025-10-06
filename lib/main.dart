import 'package:flutter/material.dart';
import 'package:food_recognizer_app/controller/image_classification_provider.dart';
import 'package:food_recognizer_app/controller/image_preview_provider.dart';
import 'package:food_recognizer_app/routes/route_navigation.dart';
import 'package:food_recognizer_app/screens/home_screen.dart';
import 'package:food_recognizer_app/screens/result_screen.dart';
import 'package:food_recognizer_app/service/image_classification_service.dart';
import 'package:food_recognizer_app/themes/theme_apps.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final imageClassificationService = ImageClassificationService();
  await imageClassificationService.initHelper();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ImagePreviewProvider()),
        ChangeNotifierProvider(
          create: (_) =>
              ImageClassificationProvider(imageClassificationService),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'home':
            return MaterialPageRoute(builder: (_) => const HomeScreen());
          case 'result':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => ResultScreen(
                label: args['label'] as String,
                confidence: args['confidence'] as double,
                imagePath: args['imagePath'] as String,
              ),
            );
        }
        return null;
      },
    );
  }
}

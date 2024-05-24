import 'package:flutter/material.dart';
import 'package:mock_movies_app/core/services/dependency_injection.dart';
import 'package:mock_movies_app/utils/navigation_routes.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: Routes.kSplashView,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mock_movies_app/features/presentation/views/splash/splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  static const String kSplashView = "kSplashView";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.kSplashView:
        return PageTransition(
          child: const SplashScreen(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kSplashView),
        );
      default:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const Scaffold(
            body: Center(
              child: Text("Invalid Route"),
            ),
          ),
        );
    }
  }
}

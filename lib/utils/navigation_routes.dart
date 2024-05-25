import 'package:flutter/material.dart';
import 'package:mock_movies_app/features/data/model/movie_list_response.dart';
import 'package:mock_movies_app/features/presentation/views/details/detail_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../features/presentation/views/dashboard/dashboard_screen.dart';

class Routes {
  static const String kDetailsView = "kDetailsView";
  static const String kDashboardView = "kDashboardView";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.kDashboardView:
        return PageTransition(
          child: const DashboardScreen(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kDashboardView),
        );
      case Routes.kDetailsView:
        return PageTransition(
          child: DetailsScreen(
            movieData: settings.arguments as Result,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kDetailsView),
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

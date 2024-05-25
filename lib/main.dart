import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mock_movies_app/core/services/dependency_injection.dart';
import 'package:mock_movies_app/utils/app_colors.dart';
import 'package:mock_movies_app/utils/navigation_routes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          title: 'Mock Movies App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.colorSecondary,
            ).copyWith(
              background: AppColors.colorPrimary,
            ),
            textTheme: GoogleFonts.readexProTextTheme(
              Theme.of(context).textTheme.apply(
                    bodyColor: AppColors.fontColorWhite,
                  ),
            ),
          ),
          initialRoute: Routes.kDashboardView,
          onGenerateRoute: Routes.generateRoute,
        );
      },
    );
  }
}

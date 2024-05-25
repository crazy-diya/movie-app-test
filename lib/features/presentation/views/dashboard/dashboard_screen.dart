import 'package:flutter/material.dart';
import 'package:mock_movies_app/features/domain/entities/nav_item.dart';
import 'package:mock_movies_app/features/presentation/views/download/download_screen.dart';
import 'package:mock_movies_app/features/presentation/views/home/home_screen.dart';
import 'package:mock_movies_app/features/presentation/views/profile/profile_screen.dart';
import 'package:mock_movies_app/features/presentation/views/search/search_screeen.dart';
import 'package:mock_movies_app/utils/app_colors.dart';
import 'package:mock_movies_app/utils/app_strings.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var navItem = [
    NavItem(
      navName: AppStrings.homeNavText,
      navIcon: Icons.add_home_outlined,
      isSelected: true,
    ),
    NavItem(
      navName: AppStrings.searchNavText,
      navIcon: Icons.search_rounded,
      isSelected: false,
    ),
    NavItem(
      navName: AppStrings.downloadNavText,
      navIcon: Icons.update_outlined,
      isSelected: false,
    ),
    NavItem(
      navName: AppStrings.profileNavText,
      navIcon: Icons.person_outline_rounded,
      isSelected: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8.0),
        child: Stack(
          children: [
            navItem[0].isSelected
                ? const HomeScreen()
                : navItem[1].isSelected
                    ? const SearchScreen()
                    : navItem[2].isSelected
                        ? const DownloadScreen()
                        : const ProfileScreen(),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 20.w,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.colorSecondary,
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: navItem.map((item) {
                    return InkWell(
                      onTap: () {
                        print(item.navName);
                        setState(() {
                          List.generate(navItem.length, (index) {
                            if (navItem[index].navName != item.navName) {
                              navItem[index].isSelected = false;
                            } else {
                              navItem[index].isSelected = true;
                            }
                          });
                        });
                      },
                      child: Wrap(
                        direction: Axis.vertical,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(
                            item.navIcon,
                            color: item.isSelected ? AppColors.iconColorYellow : AppColors.iconColorGray,
                          ),
                          Text(
                            item.navName,
                            style: TextStyle(
                              color: item.isSelected ? AppColors.fontColorYellow : AppColors.iconColorGray,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

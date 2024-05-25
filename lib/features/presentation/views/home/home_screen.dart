import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_movies_app/features/domain/entities/category.dart';
import 'package:mock_movies_app/features/presentation/common/loading.dart';
import 'package:mock_movies_app/utils/app_colors.dart';
import 'package:mock_movies_app/utils/app_strings.dart';
import 'package:mock_movies_app/utils/navigation_routes.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../data/model/movie_list_response.dart';
import '../../common/movie_card.dart';
import '../../cubit/movie_list/movie_list_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _cubit = injection.call<MovieListCubit>();
  final category = [
    Category(catName: AppStrings.home, isSelected: true),
    Category(catName: AppStrings.movies),
    Category(catName: AppStrings.series),
    Category(catName: AppStrings.drama),
  ];

  List<Result>? topList = [];
  List<Result>? popList = [];
  List<Result>? upcomingList = [];
  bool isPopListLoading = true;
  bool isTopListLoading = true;
  bool isUpcomingListLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    print("Shit init 0");
    _cubit.getPopularMovieListData();
    _cubit.getTopRatedMovieListData();
    _cubit.getUpcomingMovieListData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(bottom: 9.h),
      child: BlocProvider(
        create: (context) => _cubit,
        child: BlocListener<MovieListCubit, MovieListState>(
          listener: (context, state) {
            if (state is TopRatedApiLoadingState) {
              setState(() {
                isTopListLoading = true;
              });
            } else if (state is PopularApiLoadingState) {
              setState(() {
                isPopListLoading = true;
              });
            } else if (state is PopularApiLoadingState) {
              setState(() {
                isUpcomingListLoading = true;
              });
            } else if (state is TopRatedMovieListSuccessState) {
              setState(() {
                topList = state.result;
                isTopListLoading = false;
              });
            } else if (state is PopularMovieListSuccessState) {
              setState(() {
                popList = state.result;
                isPopListLoading = false;
              });
            } else if (state is UpcomingMovieListSuccessState) {
              setState(() {
                upcomingList = state.result;
                isUpcomingListLoading = false;
              });
            }
          },
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 1.0.w,
                        vertical: 1.0.w,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.colorSecondary,
                        borderRadius: BorderRadius.circular(
                          17,
                        ),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            PhosphorIcons.magnifyingGlass(),
                            color: AppColors.iconColorWhite,
                            size: 6.0.w,
                          ),
                          hintText: AppStrings.searchHomeHint,
                          hintStyle:
                              TextStyle(color: AppColors.fontColorGray.withOpacity(0.3), fontWeight: FontWeight.w100),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 1.0.w,
                      vertical: 1.0.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.colorSecondary,
                      borderRadius: BorderRadius.circular(
                        17,
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.person_outline_rounded,
                        color: AppColors.iconColorWhite,
                        size: 32,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Container(
                // height: 20.w,
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: category.map((cat) {
                    return InkWell(
                      splashFactory: InkRipple.splashFactory,
                      splashColor: Colors.transparent,
                      onTap: () {
                        print(cat.catName);
                        setState(() {
                          List.generate(category.length, (index) {
                            if (category[index].catName != cat.catName) {
                              category[index].isSelected = false;
                            } else {
                              category[index].isSelected = true;
                            }
                          });
                        });
                      },
                      child: Text(
                        cat.catName,
                        style: TextStyle(
                          color: cat.isSelected ? AppColors.fontColorWhite : AppColors.fontColorDarkBlue,
                          fontSize: 15.sp,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        AppStrings.featureSeries,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      !isPopListLoading
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: popList!.map((movie) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        Routes.kDetailsView,
                                        arguments: movie,
                                      );
                                    },
                                    child: MovieCard(
                                      movie: movie,
                                    ),
                                  );
                                }).toList(),
                              ),
                            )
                          : const Loading(),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        AppStrings.recommendedForYou,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      !isTopListLoading
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: topList!.map((movie) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        Routes.kDetailsView,
                                        arguments: movie,
                                      );
                                    },
                                    child: MovieCard(
                                      movie: movie,
                                    ),
                                  );
                                }).toList(),
                              ),
                            )
                          : const Loading(),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        AppStrings.justAdded,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      !isUpcomingListLoading
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: upcomingList!.map((movie) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        Routes.kDetailsView,
                                        arguments: movie,
                                      );
                                    },
                                    child: MovieCard(
                                      movie: movie,
                                    ),
                                  );
                                }).toList(),
                              ),
                            )
                          : const Loading(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

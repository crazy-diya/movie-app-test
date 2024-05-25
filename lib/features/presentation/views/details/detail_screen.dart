import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_movies_app/core/services/dependency_injection.dart';
import 'package:mock_movies_app/features/data/model/movie_list_response.dart';
import 'package:mock_movies_app/features/presentation/cubit/movie_list/movie_list_cubit.dart';
import 'package:mock_movies_app/utils/app_colors.dart';
import 'package:mock_movies_app/utils/common_info.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../utils/app_constants.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/navigation_routes.dart';
import '../../common/loading.dart';
import '../../common/movie_card.dart';

class DetailsScreen extends StatefulWidget {
  Result movieData;

  DetailsScreen({required this.movieData, super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<Result>? newList = [];
  bool isNewListLoading = true;

  final _cubit = injection<MovieListCubit>();

  @override
  void initState() {
    _cubit.newUpcomingMovieListData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _cubit,
        child: BlocListener<MovieListCubit, MovieListState>(
          listener: (context, state) {
            if (state is NewMovieListSuccessState) {
              setState(() {
                newList = state.result;
                isNewListLoading = false;
              });
            } else if (state is NewApiLoadingState) {
              setState(() {
                isNewListLoading = true;
              });
            }
          },
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 70.h,
                  width: 100.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        AppConstants.imgUrl + widget.movieData.posterPath!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 6.h,
                left: 2.w,
                child: BackButton(
                  color: AppColors.iconColorWhite,
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.kDashboardView,
                    (route) => false,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 70.h, // More than half the height
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: CommonInfo().gradientColor, // Gradient colors
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  height: 50.h,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.movieData.title!,
                              style: TextStyle(
                                fontSize: 22.sp,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
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
                                    Icons.get_app_outlined,
                                    color: AppColors.iconColorWhite,
                                    size: 32,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
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
                                    Icons.share_outlined,
                                    color: AppColors.iconColorWhite,
                                    size: 32,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 1.5.h, bottom: 1.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.movieData.releaseDate!.year} • ${widget.movieData.popularity} • ${widget.movieData.voteCount}",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: AppColors.fontColorGray,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.movieData.overview!,
                              style: const TextStyle(
                                color: AppColors.fontColorGray,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: Row(
                          children: [
                            Text(
                              AppStrings.newReleases,
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      !isNewListLoading
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: newList!.map((movie) {
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

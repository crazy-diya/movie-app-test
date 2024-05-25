import 'package:flutter/cupertino.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../utils/app_constants.dart';
import '../../data/model/movie_list_response.dart';
class MovieCard extends StatelessWidget {
  Result movie;

  MovieCard({
    required this.movie,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image(
          image: NetworkImage(
            AppConstants.imgUrl + movie.posterPath!,
          ),
          height: 18.h,
          width: 28.w,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'app_colors.dart';

// use site frr api - https://developer.themoviedb.org/reference/movie-upcoming-list
// registered by using 2016 account
// Application Name: mack_movies_app
// Application Url: com.example.mock_movies_app
/** There have a bearer token
 * API Key: d835c27208745670367a265798471cb6
 * can use this way - https://api.themoviedb.org/3/movie/550?api_key=d835c27208745670367a265798471cb6
 *
 **/

// Example
/* curl --request GET \
    --url 'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&with_release_type=2|3&release_date.gte={min_date}&release_date.lte={max_date}' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkODM1YzI3MjA4NzQ1NjcwMzY3YTI2NTc5ODQ3MWNiNiIsInN1YiI6IjY2NTBkYTkzZDM1MTBkNjRhMTIyZGM1NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ftw_s8yqSt4NBA8zrl7UFxB_roucIaBlhlHpZGgXg_8' \
    --header 'accept: application/json'
*/

class CommonInfo {
  List<Color> gradientColor = [
    AppColors.colorPrimary.withOpacity(0.01),
    AppColors.colorPrimary.withOpacity(0.5),
    AppColors.colorPrimary.withOpacity(0.7),
    AppColors.colorPrimary.withOpacity(0.9),
    AppColors.colorPrimary,
    AppColors.colorPrimary,
    AppColors.colorPrimary,
    AppColors.colorPrimary,
    AppColors.colorPrimary,
    AppColors.colorPrimary,
  ];
}

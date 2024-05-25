import 'package:dartz/dartz.dart';
import 'package:mock_movies_app/features/data/model/movie_list_response.dart';

import '../../../error/failures.dart';

abstract class Repository{
  Future<Either<Failure,MovieListResponse>> movieList(Map<String, dynamic> query,);
  Future<Either<Failure,MovieListResponse>> topMovieList(Map<String, dynamic> query,);
}
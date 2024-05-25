import 'package:mock_movies_app/core/network/api_helper.dart';
import 'package:mock_movies_app/features/data/model/movie_list_response.dart';

abstract class RemoteDatasource {
  Future<MovieListResponse> movieList(Map<String, dynamic> query);
  Future<MovieListResponse> topMovieList(Map<String, dynamic> query);
}

class RemoteDatasourceImpl extends RemoteDatasource {
  final APIHelper apiHelper;

  RemoteDatasourceImpl({required this.apiHelper});

  @override
  Future<MovieListResponse> movieList(Map<String, dynamic> query) async {
    try {
      final response = await apiHelper.get(
        "discover/movie",
        param: query,
      );
      return MovieListResponse.fromJson(response);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<MovieListResponse> topMovieList(Map<String, dynamic> query) async {
    try {
      final response = await apiHelper.get(
        "discover/movie",
        param: query,
      );
      return MovieListResponse.fromJson(response);
    } on Exception {
      rethrow;
    }
  }
}

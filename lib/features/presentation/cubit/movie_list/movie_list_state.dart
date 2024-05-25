part of 'movie_list_cubit.dart';

@immutable
abstract class MovieListState {}

class MovieListInitial extends MovieListState {}

class PopularApiLoadingState extends MovieListState {}

class TopRatedApiLoadingState extends MovieListState {}

class UpcomingApiLoadingState extends MovieListState {}

class NewApiLoadingState extends MovieListState {}

class ApiFailureState extends MovieListState {}

class DioExceptionFailureState extends MovieListState {}

class ServerFailureState extends MovieListState {}

class ConnectionFailureState extends MovieListState {}

class PopularMovieListSuccessState extends MovieListState {
  List<Result>? result;

  PopularMovieListSuccessState({required this.result});
}

class TopRatedMovieListSuccessState extends MovieListState {
  List<Result>? result;

  TopRatedMovieListSuccessState({required this.result});
}

class UpcomingMovieListSuccessState extends MovieListState {
  List<Result>? result;

  UpcomingMovieListSuccessState({required this.result});
}

class NewMovieListSuccessState extends MovieListState {
  List<Result>? result;

  NewMovieListSuccessState({required this.result});
}

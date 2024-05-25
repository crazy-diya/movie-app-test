import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../error/failures.dart';
import '../../../data/model/movie_list_response.dart';
import '../../../domain/usecases/movie_list_usecase.dart';
import '../../../domain/usecases/top_movie_list_usecase.dart';

part 'movie_list_state.dart';

class MovieListCubit extends Cubit<MovieListState> {
  final MovieListUseCase popularMovieListUseCase;
  final TopMovieListUseCase topRatedMovieListUseCase;
  final TopMovieListUseCase upcomingMovieListUseCase;
  final TopMovieListUseCase newMovieListUseCase;

  MovieListCubit({
    required this.popularMovieListUseCase,
    required this.upcomingMovieListUseCase,
    required this.topRatedMovieListUseCase,
    required this.newMovieListUseCase,
  }) : super(MovieListInitial());

  Future<dynamic> getPopularMovieListData() async {
    emit(PopularApiLoadingState());
    final result = await popularMovieListUseCase({
      'include_adult': false,
      'include_video': false,
      'language': 'en-US',
      'page': 2,
      'sort_by': 'popularity.desc',
    });

    emit(
      result.fold(
        (l) {
          if (l is DioExceptionFailure) {
            return DioExceptionFailureState();
          } else if (l is ServerFailure) {
            return ServerFailureState();
          } else if (l is ConnectionFailure) {
            return ConnectionFailureState();
          } else {
            return ApiFailureState();
          }
        },
        (r) {
          return PopularMovieListSuccessState(result: r.results);
        },
      ),
    );
  }

  Future<dynamic> getTopRatedMovieListData() async {
    emit(TopRatedApiLoadingState());
    final result = await topRatedMovieListUseCase({
      'include_adult': false,
      'include_video': false,
      'language': 'en-US',
      'page': 1,
      'sort_by': 'vote_average.desc',
      'without_genres': [99, 10755],
      'vote_count.gte': 200,
    });

    emit(
      result.fold(
        (l) {
          if (l is DioExceptionFailure) {
            return DioExceptionFailureState();
          } else if (l is ServerFailure) {
            return ServerFailureState();
          } else if (l is ConnectionFailure) {
            return ConnectionFailureState();
          } else {
            return ApiFailureState();
          }
        },
        (r) {
          return TopRatedMovieListSuccessState(result: r.results);
        },
      ),
    );
  }

  Future<dynamic> getUpcomingMovieListData() async {
    emit(UpcomingApiLoadingState());
    final result = await upcomingMovieListUseCase({
      'include_adult': false,
      'include_video': false,
      'language': 'en-US',
      'page': 1,
      'sort_by': 'popularity.desc',
      'with_release_type': '2|3',
      'release_date.gte': '{min_date}',
      'release_date.lte': '{max_date}',
    });

    emit(
      result.fold(
        (l) {
          if (l is DioExceptionFailure) {
            return DioExceptionFailureState();
          } else if (l is ServerFailure) {
            return ServerFailureState();
          } else if (l is ConnectionFailure) {
            return ConnectionFailureState();
          } else {
            return ApiFailureState();
          }
        },
        (r) {
          return UpcomingMovieListSuccessState(result: r.results);
        },
      ),
    );
  }

  Future<dynamic> newUpcomingMovieListData() async {
    emit(NewApiLoadingState());
    final result = await newMovieListUseCase({
      'include_adult': false,
      'include_video': false,
      'language': 'en-US',
      'page': 3,
      'sort_by': 'popularity.desc',
      'with_release_type': '2|3',
      'release_date.gte': '{min_date}',
      'release_date.lte': '{max_date}',
    });

    emit(
      result.fold(
        (l) {
          if (l is DioExceptionFailure) {
            return DioExceptionFailureState();
          } else if (l is ServerFailure) {
            return ServerFailureState();
          } else if (l is ConnectionFailure) {
            return ConnectionFailureState();
          } else {
            return ApiFailureState();
          }
        },
        (r) {
          return NewMovieListSuccessState(result: r.results);
        },
      ),
    );
  }
}

import 'package:dartz/dartz.dart';
import 'package:mock_movies_app/features/data/model/movie_list_response.dart';
import 'package:mock_movies_app/features/domain/usecases/usecase.dart';

import '../../../error/failures.dart';
import '../repository/repository.dart';

class TopMovieListUseCase extends UseCase<MovieListResponse, Map<String, dynamic>> {
  final Repository repository;

  TopMovieListUseCase({required this.repository});

  @override
  Future<Either<Failure, MovieListResponse>> call(Map<String, dynamic> params) async {
    return await repository.topMovieList(params);
  }
}

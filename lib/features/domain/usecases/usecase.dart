import 'package:dartz/dartz.dart';
import 'package:mock_movies_app/error/failures.dart';

abstract class UseCase<T, P> {
  Future<Either<Failure, T>> call(P params);
}

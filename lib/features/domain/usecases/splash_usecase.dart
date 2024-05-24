import 'package:dartz/dartz.dart';
import 'package:mock_movies_app/error/failures.dart';
import 'package:mock_movies_app/features/domain/repository/repository.dart';
import 'package:mock_movies_app/features/domain/usecases/usecase.dart';

class Splash extends UseCase<dynamic, Map<String, dynamic>> {
  final Repository repository;

  Splash({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(Map<String, dynamic> params) async {
    return await repository.splash(params);
  }
}

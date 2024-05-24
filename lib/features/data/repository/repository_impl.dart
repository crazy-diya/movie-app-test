import 'package:dartz/dartz.dart';
import 'package:mock_movies_app/core/network/network_info.dart';
import 'package:mock_movies_app/error/failures.dart';
import 'package:mock_movies_app/features/data/datasources/remote_datasource.dart';
import 'package:mock_movies_app/features/domain/entities/error_response_entity.dart';
import 'package:mock_movies_app/features/domain/repository/repository.dart';

import '../../../error/exception.dart';

class RepositoryImpl extends Repository {
  final RemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  RepositoryImpl({required this.remoteDatasource, required this.networkInfo});

  @override
  Future<Either<Failure, dynamic>> splash(Map<String, dynamic> data) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.splashRequest(data);
        return Right(response);
      } on DioExceptionError catch (e) {
        return Left(DioExceptionFailure(e.errorResponse!));
      } on Exception catch (e) {
        return Left(
          ServerFailure(
            errorResponse: ErrorResponseEntity(
              responseCode: "",
              responseError: e.toString(),
            ),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}

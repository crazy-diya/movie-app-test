import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mock_movies_app/core/network/api_helper.dart';
import 'package:mock_movies_app/core/network/network_info.dart';
import 'package:mock_movies_app/features/data/datasources/remote_datasource.dart';
import 'package:mock_movies_app/features/data/repository/repository_impl.dart';
import 'package:mock_movies_app/features/domain/repository/repository.dart';
import 'package:mock_movies_app/features/domain/usecases/movie_list_usecase.dart';

import '../../features/domain/usecases/top_movie_list_usecase.dart';
import '../../features/presentation/cubit/movie_list/movie_list_cubit.dart';

final injection = GetIt.instance;

Future<dynamic> init() async {
  injection.registerSingleton(Dio());
  injection.registerLazySingleton<APIHelper>(() => APIHelper(dio: injection()));
  injection.registerLazySingleton(() => Connectivity());
  injection.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectivity: injection()));

  //RemoteDataSource
  injection.registerLazySingleton<RemoteDatasource>(() => RemoteDatasourceImpl(apiHelper: injection()));

  //Repository
  injection
      .registerLazySingleton<Repository>(() => RepositoryImpl(remoteDatasource: injection(), networkInfo: injection()));

  //UseCase
  injection.registerLazySingleton(() => MovieListUseCase(repository: injection()));
  injection.registerLazySingleton(() => TopMovieListUseCase(repository: injection()));

  //Bloc
  injection.registerFactory(
    () => MovieListCubit(
      popularMovieListUseCase: injection(),
      topRatedMovieListUseCase: injection(),
      upcomingMovieListUseCase: injection(),
      newMovieListUseCase: injection(),
    ),
  );
}

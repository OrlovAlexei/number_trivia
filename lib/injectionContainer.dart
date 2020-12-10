import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'core/platform/networkInfo.dart';
import 'core/util/inputConverter.dart';
import 'features/numberTrivia/data/datasources/NumberTriviaLocalDataSource.dart';
import 'features/numberTrivia/data/datasources/NumberTriviaRemoteDataSource.dart';
import 'features/numberTrivia/data/repository/NumberTriviaRepository.dart';
import 'features/numberTrivia/domain/repository/numberTriviaRepository.dart';
import 'features/numberTrivia/domain/usecases/getConcreteNT.dart';
import 'features/numberTrivia/domain/usecases/getRandomNT.dart';
import 'features/numberTrivia/presentation/bloc/numberTrivia_bloc.dart';

final sl = GetIt.instance;

Future<void> setup() async {
  //! Features - Number Trivia
//Bloc
  sl.registerFactory(
    () => NumberTriviaBloc(
      concrete: sl(),
      random: sl(),
      inputConverter: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));
  //! Core
  sl.registerLazySingleton(() => InputConverter());
  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}

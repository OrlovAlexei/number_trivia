import 'package:flutter/material.dart';
import 'package:number_trivia/core/error/exception.dart';
import 'package:number_trivia/core/platform/networkInfo.dart';
import 'package:number_trivia/features/numberTrivia/data/datasources/NumberTriviaLocalDataSource.dart';
import 'package:number_trivia/features/numberTrivia/data/datasources/NumberTriviaRemoteDataSource.dart';
import 'package:number_trivia/features/numberTrivia/domain/entities/nuberTrivia.dart';
import 'package:number_trivia/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import 'package:number_trivia/features/numberTrivia/domain/repository/numberTriviaRepository.dart';

typedef Future<NumberTrivia> _ConcreteOrRandomChooser();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNT(
    int number,
  ) async {
    return await _getTrivia(() => remoteDataSource.getConcreteNT(number));
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNT() async {
    return await _getTrivia(() => remoteDataSource.getRandomNT());
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
    _ConcreteOrRandomChooser getConcreteOrRandom,
  ) async {
    final online = await networkInfo.isConnected;

    if (online) {
      try {
        final remoteTrivia = await getConcreteOrRandom();

        localDataSource.cacheNumberTrivia(remoteTrivia);

        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    }

    try {
      final localTrivia = await localDataSource.getLastNumberTrivia();

      return Right(localTrivia);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}

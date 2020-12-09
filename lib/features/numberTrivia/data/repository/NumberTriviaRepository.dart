import 'package:flutter/material.dart';
import 'package:number_trivia/core/platform/networkInfo.dart';
import 'package:number_trivia/features/numberTrivia/data/datasources/NumberTriviaLocalDataSource.dart';
import 'package:number_trivia/features/numberTrivia/data/datasources/NumberTriviaRemoteDataSource.dart';
import 'package:number_trivia/features/numberTrivia/domain/entities/nuberTrivia.dart';
import 'package:number_trivia/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:number_trivia/features/numberTrivia/domain/repository/numberTriviaRepository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
      {@required this.remoteDataSource,
      @required this.localDataSource,
      @required this.networkInfo});

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNT(int number) {}

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNT() {}
}

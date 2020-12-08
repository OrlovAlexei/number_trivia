import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/error/failure.dart';
import 'package:number_trivia/features/numberTrivia/domain/entities/nuberTrivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNT(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNT();
}

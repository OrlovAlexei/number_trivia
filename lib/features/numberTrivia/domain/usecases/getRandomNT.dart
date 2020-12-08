import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/error/failure.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/features/numberTrivia/domain/entities/nuberTrivia.dart';
import 'package:number_trivia/features/numberTrivia/domain/repository/numberTriviaRepository.dart';

class GetRandomNumberTrivia extends UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNT();
  }
}

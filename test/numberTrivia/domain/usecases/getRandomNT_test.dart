import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/features/numberTrivia/domain/entities/nuberTrivia.dart';
import 'package:number_trivia/features/numberTrivia/domain/repository/numberTriviaRepository.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/features/numberTrivia/domain/usecases/getConcreteNT.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/features/numberTrivia/domain/usecases/getRandomNT.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetRandomNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(text: 'test', number: 1);

  test('should get trivia from the repository', () async {
    // arrange
    when(mockNumberTriviaRepository.getRandomNT())
        .thenAnswer((_) async => Right(tNumberTrivia));
    // action
    final result = await usecase(NoParams());
    // assert
    expect(result, Right(tNumberTrivia));
    verify(mockNumberTriviaRepository.getRandomNT());
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}

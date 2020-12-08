import 'package:dartz/dartz.dart';
import 'package:number_trivia/features/numberTrivia/domain/entities/nuberTrivia.dart';
import 'package:number_trivia/features/numberTrivia/domain/repository/numberTriviaRepository.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/features/numberTrivia/domain/usecases/getConcreteNT.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetConcreteNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(text: 'test', number: 1);

  test('should get trivia for the number from the repository', () async {
    // arrange
    when(mockNumberTriviaRepository.getConcreteNT(any))
        .thenAnswer((_) async => Right(tNumberTrivia));
    // action
    final result = await usecase.call(Params(number: tNumber));
    // assert
    expect(result, Right(tNumberTrivia));
    verify(mockNumberTriviaRepository.getConcreteNT(tNumber));
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}

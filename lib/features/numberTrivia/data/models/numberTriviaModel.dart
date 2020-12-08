import 'package:flutter/material.dart';
import 'package:number_trivia/features/numberTrivia/domain/entities/nuberTrivia.dart';
import 'package:meta/meta.dart';

class NumberTriviaModel extends NumberTrivia {
  NumberTriviaModel({
    @required text,
    @required number,
  }) : super(text: text, number: number);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) =>
      NumberTriviaModel(
        text: json["text"],
        number: (json['number'] as num).toInt(),
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "number": number,
      };
}

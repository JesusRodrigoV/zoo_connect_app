// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Quiz _$QuizFromJson(Map<String, dynamic> json) => _Quiz(
  type: json['type'] as String,
  difficulty: json['difficulty'] as String,
  category: json['category'] as String,
  question: json['question'] as String,
  correctAnswer: json['correctAnswer'] as String,
  incorrectAnswers:
      (json['incorrectAnswers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
);

Map<String, dynamic> _$QuizToJson(_Quiz instance) => <String, dynamic>{
  'type': instance.type,
  'difficulty': instance.difficulty,
  'category': instance.category,
  'question': instance.question,
  'correctAnswer': instance.correctAnswer,
  'incorrectAnswers': instance.incorrectAnswers,
};

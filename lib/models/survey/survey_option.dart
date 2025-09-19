import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'survey_option.freezed.dart';
part 'survey_option.g.dart';

@freezed
abstract class SurveyOption with _$SurveyOption {
  const factory SurveyOption({
    @JsonKey(name: 'id_opcion') int? id,
    @JsonKey(name: 'texto_opcion') required String text,
    required int orden,
  }) = _SurveyOption;

  factory SurveyOption.fromJson(Map<String, dynamic> json) =>
      _$SurveyOptionFromJson(json);
}

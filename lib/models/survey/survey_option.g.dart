// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SurveyOption _$SurveyOptionFromJson(Map<String, dynamic> json) =>
    _SurveyOption(
      id: (json['id_opcion'] as num?)?.toInt(),
      text: json['texto_opcion'] as String,
      orden: (json['orden'] as num).toInt(),
    );

Map<String, dynamic> _$SurveyOptionToJson(_SurveyOption instance) =>
    <String, dynamic>{
      'id_opcion': instance.id,
      'texto_opcion': instance.text,
      'orden': instance.orden,
    };

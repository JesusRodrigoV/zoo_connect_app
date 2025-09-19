import 'package:freezed_annotation/freezed_annotation.dart';

class ISODateTimeConverter implements JsonConverter<DateTime, String> {
  const ISODateTimeConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime object) => object.toIso8601String();
}

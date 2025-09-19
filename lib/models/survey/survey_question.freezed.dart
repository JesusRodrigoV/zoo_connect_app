// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'survey_question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SurveyQuestion {

@JsonKey(name: 'id_pregunta') int? get id;@JsonKey(name: 'texto_pregunta') String get text;@JsonKey(name: 'es_opcion_unica') bool get esOpcionUnica; int? get orden; List<SurveyOption> get opciones;
/// Create a copy of SurveyQuestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurveyQuestionCopyWith<SurveyQuestion> get copyWith => _$SurveyQuestionCopyWithImpl<SurveyQuestion>(this as SurveyQuestion, _$identity);

  /// Serializes this SurveyQuestion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurveyQuestion&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.esOpcionUnica, esOpcionUnica) || other.esOpcionUnica == esOpcionUnica)&&(identical(other.orden, orden) || other.orden == orden)&&const DeepCollectionEquality().equals(other.opciones, opciones));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,esOpcionUnica,orden,const DeepCollectionEquality().hash(opciones));

@override
String toString() {
  return 'SurveyQuestion(id: $id, text: $text, esOpcionUnica: $esOpcionUnica, orden: $orden, opciones: $opciones)';
}


}

/// @nodoc
abstract mixin class $SurveyQuestionCopyWith<$Res>  {
  factory $SurveyQuestionCopyWith(SurveyQuestion value, $Res Function(SurveyQuestion) _then) = _$SurveyQuestionCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id_pregunta') int? id,@JsonKey(name: 'texto_pregunta') String text,@JsonKey(name: 'es_opcion_unica') bool esOpcionUnica, int? orden, List<SurveyOption> opciones
});




}
/// @nodoc
class _$SurveyQuestionCopyWithImpl<$Res>
    implements $SurveyQuestionCopyWith<$Res> {
  _$SurveyQuestionCopyWithImpl(this._self, this._then);

  final SurveyQuestion _self;
  final $Res Function(SurveyQuestion) _then;

/// Create a copy of SurveyQuestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? text = null,Object? esOpcionUnica = null,Object? orden = freezed,Object? opciones = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,esOpcionUnica: null == esOpcionUnica ? _self.esOpcionUnica : esOpcionUnica // ignore: cast_nullable_to_non_nullable
as bool,orden: freezed == orden ? _self.orden : orden // ignore: cast_nullable_to_non_nullable
as int?,opciones: null == opciones ? _self.opciones : opciones // ignore: cast_nullable_to_non_nullable
as List<SurveyOption>,
  ));
}

}


/// Adds pattern-matching-related methods to [SurveyQuestion].
extension SurveyQuestionPatterns on SurveyQuestion {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SurveyQuestion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SurveyQuestion() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SurveyQuestion value)  $default,){
final _that = this;
switch (_that) {
case _SurveyQuestion():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SurveyQuestion value)?  $default,){
final _that = this;
switch (_that) {
case _SurveyQuestion() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_pregunta')  int? id, @JsonKey(name: 'texto_pregunta')  String text, @JsonKey(name: 'es_opcion_unica')  bool esOpcionUnica,  int? orden,  List<SurveyOption> opciones)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SurveyQuestion() when $default != null:
return $default(_that.id,_that.text,_that.esOpcionUnica,_that.orden,_that.opciones);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_pregunta')  int? id, @JsonKey(name: 'texto_pregunta')  String text, @JsonKey(name: 'es_opcion_unica')  bool esOpcionUnica,  int? orden,  List<SurveyOption> opciones)  $default,) {final _that = this;
switch (_that) {
case _SurveyQuestion():
return $default(_that.id,_that.text,_that.esOpcionUnica,_that.orden,_that.opciones);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id_pregunta')  int? id, @JsonKey(name: 'texto_pregunta')  String text, @JsonKey(name: 'es_opcion_unica')  bool esOpcionUnica,  int? orden,  List<SurveyOption> opciones)?  $default,) {final _that = this;
switch (_that) {
case _SurveyQuestion() when $default != null:
return $default(_that.id,_that.text,_that.esOpcionUnica,_that.orden,_that.opciones);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SurveyQuestion implements SurveyQuestion {
  const _SurveyQuestion({@JsonKey(name: 'id_pregunta') this.id, @JsonKey(name: 'texto_pregunta') required this.text, @JsonKey(name: 'es_opcion_unica') required this.esOpcionUnica, this.orden, final  List<SurveyOption> opciones = const []}): _opciones = opciones;
  factory _SurveyQuestion.fromJson(Map<String, dynamic> json) => _$SurveyQuestionFromJson(json);

@override@JsonKey(name: 'id_pregunta') final  int? id;
@override@JsonKey(name: 'texto_pregunta') final  String text;
@override@JsonKey(name: 'es_opcion_unica') final  bool esOpcionUnica;
@override final  int? orden;
 final  List<SurveyOption> _opciones;
@override@JsonKey() List<SurveyOption> get opciones {
  if (_opciones is EqualUnmodifiableListView) return _opciones;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_opciones);
}


/// Create a copy of SurveyQuestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurveyQuestionCopyWith<_SurveyQuestion> get copyWith => __$SurveyQuestionCopyWithImpl<_SurveyQuestion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SurveyQuestionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurveyQuestion&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.esOpcionUnica, esOpcionUnica) || other.esOpcionUnica == esOpcionUnica)&&(identical(other.orden, orden) || other.orden == orden)&&const DeepCollectionEquality().equals(other._opciones, _opciones));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,esOpcionUnica,orden,const DeepCollectionEquality().hash(_opciones));

@override
String toString() {
  return 'SurveyQuestion(id: $id, text: $text, esOpcionUnica: $esOpcionUnica, orden: $orden, opciones: $opciones)';
}


}

/// @nodoc
abstract mixin class _$SurveyQuestionCopyWith<$Res> implements $SurveyQuestionCopyWith<$Res> {
  factory _$SurveyQuestionCopyWith(_SurveyQuestion value, $Res Function(_SurveyQuestion) _then) = __$SurveyQuestionCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id_pregunta') int? id,@JsonKey(name: 'texto_pregunta') String text,@JsonKey(name: 'es_opcion_unica') bool esOpcionUnica, int? orden, List<SurveyOption> opciones
});




}
/// @nodoc
class __$SurveyQuestionCopyWithImpl<$Res>
    implements _$SurveyQuestionCopyWith<$Res> {
  __$SurveyQuestionCopyWithImpl(this._self, this._then);

  final _SurveyQuestion _self;
  final $Res Function(_SurveyQuestion) _then;

/// Create a copy of SurveyQuestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? text = null,Object? esOpcionUnica = null,Object? orden = freezed,Object? opciones = null,}) {
  return _then(_SurveyQuestion(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,esOpcionUnica: null == esOpcionUnica ? _self.esOpcionUnica : esOpcionUnica // ignore: cast_nullable_to_non_nullable
as bool,orden: freezed == orden ? _self.orden : orden // ignore: cast_nullable_to_non_nullable
as int?,opciones: null == opciones ? _self._opciones : opciones // ignore: cast_nullable_to_non_nullable
as List<SurveyOption>,
  ));
}


}

// dart format on

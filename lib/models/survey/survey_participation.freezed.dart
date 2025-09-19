// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'survey_participation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SurveyAnswer {

@JsonKey(name: 'id_respuesta') int? get id;@JsonKey(name: 'pregunta_id') int get preguntaId;@JsonKey(name: 'opcion_id') int? get opcionId;@JsonKey(name: 'respuesta_texto') String? get respuestaTexto;
/// Create a copy of SurveyAnswer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurveyAnswerCopyWith<SurveyAnswer> get copyWith => _$SurveyAnswerCopyWithImpl<SurveyAnswer>(this as SurveyAnswer, _$identity);

  /// Serializes this SurveyAnswer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurveyAnswer&&(identical(other.id, id) || other.id == id)&&(identical(other.preguntaId, preguntaId) || other.preguntaId == preguntaId)&&(identical(other.opcionId, opcionId) || other.opcionId == opcionId)&&(identical(other.respuestaTexto, respuestaTexto) || other.respuestaTexto == respuestaTexto));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,preguntaId,opcionId,respuestaTexto);

@override
String toString() {
  return 'SurveyAnswer(id: $id, preguntaId: $preguntaId, opcionId: $opcionId, respuestaTexto: $respuestaTexto)';
}


}

/// @nodoc
abstract mixin class $SurveyAnswerCopyWith<$Res>  {
  factory $SurveyAnswerCopyWith(SurveyAnswer value, $Res Function(SurveyAnswer) _then) = _$SurveyAnswerCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id_respuesta') int? id,@JsonKey(name: 'pregunta_id') int preguntaId,@JsonKey(name: 'opcion_id') int? opcionId,@JsonKey(name: 'respuesta_texto') String? respuestaTexto
});




}
/// @nodoc
class _$SurveyAnswerCopyWithImpl<$Res>
    implements $SurveyAnswerCopyWith<$Res> {
  _$SurveyAnswerCopyWithImpl(this._self, this._then);

  final SurveyAnswer _self;
  final $Res Function(SurveyAnswer) _then;

/// Create a copy of SurveyAnswer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? preguntaId = null,Object? opcionId = freezed,Object? respuestaTexto = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,preguntaId: null == preguntaId ? _self.preguntaId : preguntaId // ignore: cast_nullable_to_non_nullable
as int,opcionId: freezed == opcionId ? _self.opcionId : opcionId // ignore: cast_nullable_to_non_nullable
as int?,respuestaTexto: freezed == respuestaTexto ? _self.respuestaTexto : respuestaTexto // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SurveyAnswer].
extension SurveyAnswerPatterns on SurveyAnswer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SurveyAnswer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SurveyAnswer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SurveyAnswer value)  $default,){
final _that = this;
switch (_that) {
case _SurveyAnswer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SurveyAnswer value)?  $default,){
final _that = this;
switch (_that) {
case _SurveyAnswer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_respuesta')  int? id, @JsonKey(name: 'pregunta_id')  int preguntaId, @JsonKey(name: 'opcion_id')  int? opcionId, @JsonKey(name: 'respuesta_texto')  String? respuestaTexto)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SurveyAnswer() when $default != null:
return $default(_that.id,_that.preguntaId,_that.opcionId,_that.respuestaTexto);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_respuesta')  int? id, @JsonKey(name: 'pregunta_id')  int preguntaId, @JsonKey(name: 'opcion_id')  int? opcionId, @JsonKey(name: 'respuesta_texto')  String? respuestaTexto)  $default,) {final _that = this;
switch (_that) {
case _SurveyAnswer():
return $default(_that.id,_that.preguntaId,_that.opcionId,_that.respuestaTexto);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id_respuesta')  int? id, @JsonKey(name: 'pregunta_id')  int preguntaId, @JsonKey(name: 'opcion_id')  int? opcionId, @JsonKey(name: 'respuesta_texto')  String? respuestaTexto)?  $default,) {final _that = this;
switch (_that) {
case _SurveyAnswer() when $default != null:
return $default(_that.id,_that.preguntaId,_that.opcionId,_that.respuestaTexto);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SurveyAnswer implements SurveyAnswer {
  const _SurveyAnswer({@JsonKey(name: 'id_respuesta') this.id, @JsonKey(name: 'pregunta_id') required this.preguntaId, @JsonKey(name: 'opcion_id') this.opcionId, @JsonKey(name: 'respuesta_texto') this.respuestaTexto});
  factory _SurveyAnswer.fromJson(Map<String, dynamic> json) => _$SurveyAnswerFromJson(json);

@override@JsonKey(name: 'id_respuesta') final  int? id;
@override@JsonKey(name: 'pregunta_id') final  int preguntaId;
@override@JsonKey(name: 'opcion_id') final  int? opcionId;
@override@JsonKey(name: 'respuesta_texto') final  String? respuestaTexto;

/// Create a copy of SurveyAnswer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurveyAnswerCopyWith<_SurveyAnswer> get copyWith => __$SurveyAnswerCopyWithImpl<_SurveyAnswer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SurveyAnswerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurveyAnswer&&(identical(other.id, id) || other.id == id)&&(identical(other.preguntaId, preguntaId) || other.preguntaId == preguntaId)&&(identical(other.opcionId, opcionId) || other.opcionId == opcionId)&&(identical(other.respuestaTexto, respuestaTexto) || other.respuestaTexto == respuestaTexto));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,preguntaId,opcionId,respuestaTexto);

@override
String toString() {
  return 'SurveyAnswer(id: $id, preguntaId: $preguntaId, opcionId: $opcionId, respuestaTexto: $respuestaTexto)';
}


}

/// @nodoc
abstract mixin class _$SurveyAnswerCopyWith<$Res> implements $SurveyAnswerCopyWith<$Res> {
  factory _$SurveyAnswerCopyWith(_SurveyAnswer value, $Res Function(_SurveyAnswer) _then) = __$SurveyAnswerCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id_respuesta') int? id,@JsonKey(name: 'pregunta_id') int preguntaId,@JsonKey(name: 'opcion_id') int? opcionId,@JsonKey(name: 'respuesta_texto') String? respuestaTexto
});




}
/// @nodoc
class __$SurveyAnswerCopyWithImpl<$Res>
    implements _$SurveyAnswerCopyWith<$Res> {
  __$SurveyAnswerCopyWithImpl(this._self, this._then);

  final _SurveyAnswer _self;
  final $Res Function(_SurveyAnswer) _then;

/// Create a copy of SurveyAnswer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? preguntaId = null,Object? opcionId = freezed,Object? respuestaTexto = freezed,}) {
  return _then(_SurveyAnswer(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,preguntaId: null == preguntaId ? _self.preguntaId : preguntaId // ignore: cast_nullable_to_non_nullable
as int,opcionId: freezed == opcionId ? _self.opcionId : opcionId // ignore: cast_nullable_to_non_nullable
as int?,respuestaTexto: freezed == respuestaTexto ? _self.respuestaTexto : respuestaTexto // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SurveyParticipation {

@JsonKey(name: 'id_participacion') int? get id;@JsonKey(name: 'encuesta_id') int get encuestaId;@JsonKey(name: 'usuario_id') int get usuarioId;@JsonKey(name: 'fecha_participacion') DateTime get fechaParticipacion; List<SurveyAnswer> get respuestas;
/// Create a copy of SurveyParticipation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurveyParticipationCopyWith<SurveyParticipation> get copyWith => _$SurveyParticipationCopyWithImpl<SurveyParticipation>(this as SurveyParticipation, _$identity);

  /// Serializes this SurveyParticipation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurveyParticipation&&(identical(other.id, id) || other.id == id)&&(identical(other.encuestaId, encuestaId) || other.encuestaId == encuestaId)&&(identical(other.usuarioId, usuarioId) || other.usuarioId == usuarioId)&&(identical(other.fechaParticipacion, fechaParticipacion) || other.fechaParticipacion == fechaParticipacion)&&const DeepCollectionEquality().equals(other.respuestas, respuestas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,encuestaId,usuarioId,fechaParticipacion,const DeepCollectionEquality().hash(respuestas));

@override
String toString() {
  return 'SurveyParticipation(id: $id, encuestaId: $encuestaId, usuarioId: $usuarioId, fechaParticipacion: $fechaParticipacion, respuestas: $respuestas)';
}


}

/// @nodoc
abstract mixin class $SurveyParticipationCopyWith<$Res>  {
  factory $SurveyParticipationCopyWith(SurveyParticipation value, $Res Function(SurveyParticipation) _then) = _$SurveyParticipationCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id_participacion') int? id,@JsonKey(name: 'encuesta_id') int encuestaId,@JsonKey(name: 'usuario_id') int usuarioId,@JsonKey(name: 'fecha_participacion') DateTime fechaParticipacion, List<SurveyAnswer> respuestas
});




}
/// @nodoc
class _$SurveyParticipationCopyWithImpl<$Res>
    implements $SurveyParticipationCopyWith<$Res> {
  _$SurveyParticipationCopyWithImpl(this._self, this._then);

  final SurveyParticipation _self;
  final $Res Function(SurveyParticipation) _then;

/// Create a copy of SurveyParticipation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? encuestaId = null,Object? usuarioId = null,Object? fechaParticipacion = null,Object? respuestas = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,encuestaId: null == encuestaId ? _self.encuestaId : encuestaId // ignore: cast_nullable_to_non_nullable
as int,usuarioId: null == usuarioId ? _self.usuarioId : usuarioId // ignore: cast_nullable_to_non_nullable
as int,fechaParticipacion: null == fechaParticipacion ? _self.fechaParticipacion : fechaParticipacion // ignore: cast_nullable_to_non_nullable
as DateTime,respuestas: null == respuestas ? _self.respuestas : respuestas // ignore: cast_nullable_to_non_nullable
as List<SurveyAnswer>,
  ));
}

}


/// Adds pattern-matching-related methods to [SurveyParticipation].
extension SurveyParticipationPatterns on SurveyParticipation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SurveyParticipation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SurveyParticipation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SurveyParticipation value)  $default,){
final _that = this;
switch (_that) {
case _SurveyParticipation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SurveyParticipation value)?  $default,){
final _that = this;
switch (_that) {
case _SurveyParticipation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_participacion')  int? id, @JsonKey(name: 'encuesta_id')  int encuestaId, @JsonKey(name: 'usuario_id')  int usuarioId, @JsonKey(name: 'fecha_participacion')  DateTime fechaParticipacion,  List<SurveyAnswer> respuestas)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SurveyParticipation() when $default != null:
return $default(_that.id,_that.encuestaId,_that.usuarioId,_that.fechaParticipacion,_that.respuestas);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_participacion')  int? id, @JsonKey(name: 'encuesta_id')  int encuestaId, @JsonKey(name: 'usuario_id')  int usuarioId, @JsonKey(name: 'fecha_participacion')  DateTime fechaParticipacion,  List<SurveyAnswer> respuestas)  $default,) {final _that = this;
switch (_that) {
case _SurveyParticipation():
return $default(_that.id,_that.encuestaId,_that.usuarioId,_that.fechaParticipacion,_that.respuestas);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id_participacion')  int? id, @JsonKey(name: 'encuesta_id')  int encuestaId, @JsonKey(name: 'usuario_id')  int usuarioId, @JsonKey(name: 'fecha_participacion')  DateTime fechaParticipacion,  List<SurveyAnswer> respuestas)?  $default,) {final _that = this;
switch (_that) {
case _SurveyParticipation() when $default != null:
return $default(_that.id,_that.encuestaId,_that.usuarioId,_that.fechaParticipacion,_that.respuestas);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SurveyParticipation implements SurveyParticipation {
  const _SurveyParticipation({@JsonKey(name: 'id_participacion') this.id, @JsonKey(name: 'encuesta_id') required this.encuestaId, @JsonKey(name: 'usuario_id') required this.usuarioId, @JsonKey(name: 'fecha_participacion') required this.fechaParticipacion, final  List<SurveyAnswer> respuestas = const []}): _respuestas = respuestas;
  factory _SurveyParticipation.fromJson(Map<String, dynamic> json) => _$SurveyParticipationFromJson(json);

@override@JsonKey(name: 'id_participacion') final  int? id;
@override@JsonKey(name: 'encuesta_id') final  int encuestaId;
@override@JsonKey(name: 'usuario_id') final  int usuarioId;
@override@JsonKey(name: 'fecha_participacion') final  DateTime fechaParticipacion;
 final  List<SurveyAnswer> _respuestas;
@override@JsonKey() List<SurveyAnswer> get respuestas {
  if (_respuestas is EqualUnmodifiableListView) return _respuestas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_respuestas);
}


/// Create a copy of SurveyParticipation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurveyParticipationCopyWith<_SurveyParticipation> get copyWith => __$SurveyParticipationCopyWithImpl<_SurveyParticipation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SurveyParticipationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurveyParticipation&&(identical(other.id, id) || other.id == id)&&(identical(other.encuestaId, encuestaId) || other.encuestaId == encuestaId)&&(identical(other.usuarioId, usuarioId) || other.usuarioId == usuarioId)&&(identical(other.fechaParticipacion, fechaParticipacion) || other.fechaParticipacion == fechaParticipacion)&&const DeepCollectionEquality().equals(other._respuestas, _respuestas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,encuestaId,usuarioId,fechaParticipacion,const DeepCollectionEquality().hash(_respuestas));

@override
String toString() {
  return 'SurveyParticipation(id: $id, encuestaId: $encuestaId, usuarioId: $usuarioId, fechaParticipacion: $fechaParticipacion, respuestas: $respuestas)';
}


}

/// @nodoc
abstract mixin class _$SurveyParticipationCopyWith<$Res> implements $SurveyParticipationCopyWith<$Res> {
  factory _$SurveyParticipationCopyWith(_SurveyParticipation value, $Res Function(_SurveyParticipation) _then) = __$SurveyParticipationCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id_participacion') int? id,@JsonKey(name: 'encuesta_id') int encuestaId,@JsonKey(name: 'usuario_id') int usuarioId,@JsonKey(name: 'fecha_participacion') DateTime fechaParticipacion, List<SurveyAnswer> respuestas
});




}
/// @nodoc
class __$SurveyParticipationCopyWithImpl<$Res>
    implements _$SurveyParticipationCopyWith<$Res> {
  __$SurveyParticipationCopyWithImpl(this._self, this._then);

  final _SurveyParticipation _self;
  final $Res Function(_SurveyParticipation) _then;

/// Create a copy of SurveyParticipation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? encuestaId = null,Object? usuarioId = null,Object? fechaParticipacion = null,Object? respuestas = null,}) {
  return _then(_SurveyParticipation(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,encuestaId: null == encuestaId ? _self.encuestaId : encuestaId // ignore: cast_nullable_to_non_nullable
as int,usuarioId: null == usuarioId ? _self.usuarioId : usuarioId // ignore: cast_nullable_to_non_nullable
as int,fechaParticipacion: null == fechaParticipacion ? _self.fechaParticipacion : fechaParticipacion // ignore: cast_nullable_to_non_nullable
as DateTime,respuestas: null == respuestas ? _self._respuestas : respuestas // ignore: cast_nullable_to_non_nullable
as List<SurveyAnswer>,
  ));
}


}

// dart format on

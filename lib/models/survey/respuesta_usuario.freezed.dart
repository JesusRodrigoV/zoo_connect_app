// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'respuesta_usuario.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RespuestaUsuario {

@JsonKey(name: 'id_respuesta') int get id;@JsonKey(name: 'participacion_id') int get participacionId;@JsonKey(name: 'pregunta_id') int get preguntaId;@JsonKey(name: 'opcion_id') int? get opcionId;@JsonKey(name: 'respuesta_texto') String? get respuestaTexto;
/// Create a copy of RespuestaUsuario
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RespuestaUsuarioCopyWith<RespuestaUsuario> get copyWith => _$RespuestaUsuarioCopyWithImpl<RespuestaUsuario>(this as RespuestaUsuario, _$identity);

  /// Serializes this RespuestaUsuario to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RespuestaUsuario&&(identical(other.id, id) || other.id == id)&&(identical(other.participacionId, participacionId) || other.participacionId == participacionId)&&(identical(other.preguntaId, preguntaId) || other.preguntaId == preguntaId)&&(identical(other.opcionId, opcionId) || other.opcionId == opcionId)&&(identical(other.respuestaTexto, respuestaTexto) || other.respuestaTexto == respuestaTexto));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,participacionId,preguntaId,opcionId,respuestaTexto);

@override
String toString() {
  return 'RespuestaUsuario(id: $id, participacionId: $participacionId, preguntaId: $preguntaId, opcionId: $opcionId, respuestaTexto: $respuestaTexto)';
}


}

/// @nodoc
abstract mixin class $RespuestaUsuarioCopyWith<$Res>  {
  factory $RespuestaUsuarioCopyWith(RespuestaUsuario value, $Res Function(RespuestaUsuario) _then) = _$RespuestaUsuarioCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id_respuesta') int id,@JsonKey(name: 'participacion_id') int participacionId,@JsonKey(name: 'pregunta_id') int preguntaId,@JsonKey(name: 'opcion_id') int? opcionId,@JsonKey(name: 'respuesta_texto') String? respuestaTexto
});




}
/// @nodoc
class _$RespuestaUsuarioCopyWithImpl<$Res>
    implements $RespuestaUsuarioCopyWith<$Res> {
  _$RespuestaUsuarioCopyWithImpl(this._self, this._then);

  final RespuestaUsuario _self;
  final $Res Function(RespuestaUsuario) _then;

/// Create a copy of RespuestaUsuario
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? participacionId = null,Object? preguntaId = null,Object? opcionId = freezed,Object? respuestaTexto = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,participacionId: null == participacionId ? _self.participacionId : participacionId // ignore: cast_nullable_to_non_nullable
as int,preguntaId: null == preguntaId ? _self.preguntaId : preguntaId // ignore: cast_nullable_to_non_nullable
as int,opcionId: freezed == opcionId ? _self.opcionId : opcionId // ignore: cast_nullable_to_non_nullable
as int?,respuestaTexto: freezed == respuestaTexto ? _self.respuestaTexto : respuestaTexto // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RespuestaUsuario].
extension RespuestaUsuarioPatterns on RespuestaUsuario {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RespuestaUsuario value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RespuestaUsuario() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RespuestaUsuario value)  $default,){
final _that = this;
switch (_that) {
case _RespuestaUsuario():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RespuestaUsuario value)?  $default,){
final _that = this;
switch (_that) {
case _RespuestaUsuario() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_respuesta')  int id, @JsonKey(name: 'participacion_id')  int participacionId, @JsonKey(name: 'pregunta_id')  int preguntaId, @JsonKey(name: 'opcion_id')  int? opcionId, @JsonKey(name: 'respuesta_texto')  String? respuestaTexto)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RespuestaUsuario() when $default != null:
return $default(_that.id,_that.participacionId,_that.preguntaId,_that.opcionId,_that.respuestaTexto);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_respuesta')  int id, @JsonKey(name: 'participacion_id')  int participacionId, @JsonKey(name: 'pregunta_id')  int preguntaId, @JsonKey(name: 'opcion_id')  int? opcionId, @JsonKey(name: 'respuesta_texto')  String? respuestaTexto)  $default,) {final _that = this;
switch (_that) {
case _RespuestaUsuario():
return $default(_that.id,_that.participacionId,_that.preguntaId,_that.opcionId,_that.respuestaTexto);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id_respuesta')  int id, @JsonKey(name: 'participacion_id')  int participacionId, @JsonKey(name: 'pregunta_id')  int preguntaId, @JsonKey(name: 'opcion_id')  int? opcionId, @JsonKey(name: 'respuesta_texto')  String? respuestaTexto)?  $default,) {final _that = this;
switch (_that) {
case _RespuestaUsuario() when $default != null:
return $default(_that.id,_that.participacionId,_that.preguntaId,_that.opcionId,_that.respuestaTexto);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RespuestaUsuario implements RespuestaUsuario {
  const _RespuestaUsuario({@JsonKey(name: 'id_respuesta') required this.id, @JsonKey(name: 'participacion_id') required this.participacionId, @JsonKey(name: 'pregunta_id') required this.preguntaId, @JsonKey(name: 'opcion_id') this.opcionId, @JsonKey(name: 'respuesta_texto') this.respuestaTexto});
  factory _RespuestaUsuario.fromJson(Map<String, dynamic> json) => _$RespuestaUsuarioFromJson(json);

@override@JsonKey(name: 'id_respuesta') final  int id;
@override@JsonKey(name: 'participacion_id') final  int participacionId;
@override@JsonKey(name: 'pregunta_id') final  int preguntaId;
@override@JsonKey(name: 'opcion_id') final  int? opcionId;
@override@JsonKey(name: 'respuesta_texto') final  String? respuestaTexto;

/// Create a copy of RespuestaUsuario
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RespuestaUsuarioCopyWith<_RespuestaUsuario> get copyWith => __$RespuestaUsuarioCopyWithImpl<_RespuestaUsuario>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RespuestaUsuarioToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RespuestaUsuario&&(identical(other.id, id) || other.id == id)&&(identical(other.participacionId, participacionId) || other.participacionId == participacionId)&&(identical(other.preguntaId, preguntaId) || other.preguntaId == preguntaId)&&(identical(other.opcionId, opcionId) || other.opcionId == opcionId)&&(identical(other.respuestaTexto, respuestaTexto) || other.respuestaTexto == respuestaTexto));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,participacionId,preguntaId,opcionId,respuestaTexto);

@override
String toString() {
  return 'RespuestaUsuario(id: $id, participacionId: $participacionId, preguntaId: $preguntaId, opcionId: $opcionId, respuestaTexto: $respuestaTexto)';
}


}

/// @nodoc
abstract mixin class _$RespuestaUsuarioCopyWith<$Res> implements $RespuestaUsuarioCopyWith<$Res> {
  factory _$RespuestaUsuarioCopyWith(_RespuestaUsuario value, $Res Function(_RespuestaUsuario) _then) = __$RespuestaUsuarioCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id_respuesta') int id,@JsonKey(name: 'participacion_id') int participacionId,@JsonKey(name: 'pregunta_id') int preguntaId,@JsonKey(name: 'opcion_id') int? opcionId,@JsonKey(name: 'respuesta_texto') String? respuestaTexto
});




}
/// @nodoc
class __$RespuestaUsuarioCopyWithImpl<$Res>
    implements _$RespuestaUsuarioCopyWith<$Res> {
  __$RespuestaUsuarioCopyWithImpl(this._self, this._then);

  final _RespuestaUsuario _self;
  final $Res Function(_RespuestaUsuario) _then;

/// Create a copy of RespuestaUsuario
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? participacionId = null,Object? preguntaId = null,Object? opcionId = freezed,Object? respuestaTexto = freezed,}) {
  return _then(_RespuestaUsuario(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,participacionId: null == participacionId ? _self.participacionId : participacionId // ignore: cast_nullable_to_non_nullable
as int,preguntaId: null == preguntaId ? _self.preguntaId : preguntaId // ignore: cast_nullable_to_non_nullable
as int,opcionId: freezed == opcionId ? _self.opcionId : opcionId // ignore: cast_nullable_to_non_nullable
as int?,respuestaTexto: freezed == respuestaTexto ? _self.respuestaTexto : respuestaTexto // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

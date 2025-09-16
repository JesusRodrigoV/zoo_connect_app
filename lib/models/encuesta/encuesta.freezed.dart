// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'encuesta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Encuesta {

 String get id; String get titulo; String get descripcion;@JsonKey(name: 'fecha_creacion') DateTime get fechaCreacion; List<String> get preguntas;
/// Create a copy of Encuesta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EncuestaCopyWith<Encuesta> get copyWith => _$EncuestaCopyWithImpl<Encuesta>(this as Encuesta, _$identity);

  /// Serializes this Encuesta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Encuesta&&(identical(other.id, id) || other.id == id)&&(identical(other.titulo, titulo) || other.titulo == titulo)&&(identical(other.descripcion, descripcion) || other.descripcion == descripcion)&&(identical(other.fechaCreacion, fechaCreacion) || other.fechaCreacion == fechaCreacion)&&const DeepCollectionEquality().equals(other.preguntas, preguntas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,titulo,descripcion,fechaCreacion,const DeepCollectionEquality().hash(preguntas));

@override
String toString() {
  return 'Encuesta(id: $id, titulo: $titulo, descripcion: $descripcion, fechaCreacion: $fechaCreacion, preguntas: $preguntas)';
}


}

/// @nodoc
abstract mixin class $EncuestaCopyWith<$Res>  {
  factory $EncuestaCopyWith(Encuesta value, $Res Function(Encuesta) _then) = _$EncuestaCopyWithImpl;
@useResult
$Res call({
 String id, String titulo, String descripcion,@JsonKey(name: 'fecha_creacion') DateTime fechaCreacion, List<String> preguntas
});




}
/// @nodoc
class _$EncuestaCopyWithImpl<$Res>
    implements $EncuestaCopyWith<$Res> {
  _$EncuestaCopyWithImpl(this._self, this._then);

  final Encuesta _self;
  final $Res Function(Encuesta) _then;

/// Create a copy of Encuesta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? titulo = null,Object? descripcion = null,Object? fechaCreacion = null,Object? preguntas = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titulo: null == titulo ? _self.titulo : titulo // ignore: cast_nullable_to_non_nullable
as String,descripcion: null == descripcion ? _self.descripcion : descripcion // ignore: cast_nullable_to_non_nullable
as String,fechaCreacion: null == fechaCreacion ? _self.fechaCreacion : fechaCreacion // ignore: cast_nullable_to_non_nullable
as DateTime,preguntas: null == preguntas ? _self.preguntas : preguntas // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Encuesta].
extension EncuestaPatterns on Encuesta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Encuesta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Encuesta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Encuesta value)  $default,){
final _that = this;
switch (_that) {
case _Encuesta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Encuesta value)?  $default,){
final _that = this;
switch (_that) {
case _Encuesta() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String titulo,  String descripcion, @JsonKey(name: 'fecha_creacion')  DateTime fechaCreacion,  List<String> preguntas)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Encuesta() when $default != null:
return $default(_that.id,_that.titulo,_that.descripcion,_that.fechaCreacion,_that.preguntas);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String titulo,  String descripcion, @JsonKey(name: 'fecha_creacion')  DateTime fechaCreacion,  List<String> preguntas)  $default,) {final _that = this;
switch (_that) {
case _Encuesta():
return $default(_that.id,_that.titulo,_that.descripcion,_that.fechaCreacion,_that.preguntas);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String titulo,  String descripcion, @JsonKey(name: 'fecha_creacion')  DateTime fechaCreacion,  List<String> preguntas)?  $default,) {final _that = this;
switch (_that) {
case _Encuesta() when $default != null:
return $default(_that.id,_that.titulo,_that.descripcion,_that.fechaCreacion,_that.preguntas);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Encuesta implements Encuesta {
  const _Encuesta({required this.id, required this.titulo, required this.descripcion, @JsonKey(name: 'fecha_creacion') required this.fechaCreacion, required final  List<String> preguntas}): _preguntas = preguntas;
  factory _Encuesta.fromJson(Map<String, dynamic> json) => _$EncuestaFromJson(json);

@override final  String id;
@override final  String titulo;
@override final  String descripcion;
@override@JsonKey(name: 'fecha_creacion') final  DateTime fechaCreacion;
 final  List<String> _preguntas;
@override List<String> get preguntas {
  if (_preguntas is EqualUnmodifiableListView) return _preguntas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_preguntas);
}


/// Create a copy of Encuesta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EncuestaCopyWith<_Encuesta> get copyWith => __$EncuestaCopyWithImpl<_Encuesta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EncuestaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Encuesta&&(identical(other.id, id) || other.id == id)&&(identical(other.titulo, titulo) || other.titulo == titulo)&&(identical(other.descripcion, descripcion) || other.descripcion == descripcion)&&(identical(other.fechaCreacion, fechaCreacion) || other.fechaCreacion == fechaCreacion)&&const DeepCollectionEquality().equals(other._preguntas, _preguntas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,titulo,descripcion,fechaCreacion,const DeepCollectionEquality().hash(_preguntas));

@override
String toString() {
  return 'Encuesta(id: $id, titulo: $titulo, descripcion: $descripcion, fechaCreacion: $fechaCreacion, preguntas: $preguntas)';
}


}

/// @nodoc
abstract mixin class _$EncuestaCopyWith<$Res> implements $EncuestaCopyWith<$Res> {
  factory _$EncuestaCopyWith(_Encuesta value, $Res Function(_Encuesta) _then) = __$EncuestaCopyWithImpl;
@override @useResult
$Res call({
 String id, String titulo, String descripcion,@JsonKey(name: 'fecha_creacion') DateTime fechaCreacion, List<String> preguntas
});




}
/// @nodoc
class __$EncuestaCopyWithImpl<$Res>
    implements _$EncuestaCopyWith<$Res> {
  __$EncuestaCopyWithImpl(this._self, this._then);

  final _Encuesta _self;
  final $Res Function(_Encuesta) _then;

/// Create a copy of Encuesta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? titulo = null,Object? descripcion = null,Object? fechaCreacion = null,Object? preguntas = null,}) {
  return _then(_Encuesta(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titulo: null == titulo ? _self.titulo : titulo // ignore: cast_nullable_to_non_nullable
as String,descripcion: null == descripcion ? _self.descripcion : descripcion // ignore: cast_nullable_to_non_nullable
as String,fechaCreacion: null == fechaCreacion ? _self.fechaCreacion : fechaCreacion // ignore: cast_nullable_to_non_nullable
as DateTime,preguntas: null == preguntas ? _self._preguntas : preguntas // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'survey.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Survey {

@JsonKey(name: 'id_encuesta') int? get id;@JsonKey(name: 'titulo') String get titulo;@JsonKey(name: 'descripcion') String get descripcion;@JsonKey(name: 'fecha_inicio')@ISODateTimeConverter() DateTime get fechaInicio;@JsonKey(name: 'fecha_fin')@ISODateTimeConverter() DateTime get fechaFin;@JsonKey(name: 'is_active', defaultValue: true) bool get isActive;@JsonKey(name: 'preguntas') List<SurveyQuestion> get preguntas;
/// Create a copy of Survey
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurveyCopyWith<Survey> get copyWith => _$SurveyCopyWithImpl<Survey>(this as Survey, _$identity);

  /// Serializes this Survey to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Survey&&(identical(other.id, id) || other.id == id)&&(identical(other.titulo, titulo) || other.titulo == titulo)&&(identical(other.descripcion, descripcion) || other.descripcion == descripcion)&&(identical(other.fechaInicio, fechaInicio) || other.fechaInicio == fechaInicio)&&(identical(other.fechaFin, fechaFin) || other.fechaFin == fechaFin)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other.preguntas, preguntas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,titulo,descripcion,fechaInicio,fechaFin,isActive,const DeepCollectionEquality().hash(preguntas));

@override
String toString() {
  return 'Survey(id: $id, titulo: $titulo, descripcion: $descripcion, fechaInicio: $fechaInicio, fechaFin: $fechaFin, isActive: $isActive, preguntas: $preguntas)';
}


}

/// @nodoc
abstract mixin class $SurveyCopyWith<$Res>  {
  factory $SurveyCopyWith(Survey value, $Res Function(Survey) _then) = _$SurveyCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id_encuesta') int? id,@JsonKey(name: 'titulo') String titulo,@JsonKey(name: 'descripcion') String descripcion,@JsonKey(name: 'fecha_inicio')@ISODateTimeConverter() DateTime fechaInicio,@JsonKey(name: 'fecha_fin')@ISODateTimeConverter() DateTime fechaFin,@JsonKey(name: 'is_active', defaultValue: true) bool isActive,@JsonKey(name: 'preguntas') List<SurveyQuestion> preguntas
});




}
/// @nodoc
class _$SurveyCopyWithImpl<$Res>
    implements $SurveyCopyWith<$Res> {
  _$SurveyCopyWithImpl(this._self, this._then);

  final Survey _self;
  final $Res Function(Survey) _then;

/// Create a copy of Survey
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? titulo = null,Object? descripcion = null,Object? fechaInicio = null,Object? fechaFin = null,Object? isActive = null,Object? preguntas = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,titulo: null == titulo ? _self.titulo : titulo // ignore: cast_nullable_to_non_nullable
as String,descripcion: null == descripcion ? _self.descripcion : descripcion // ignore: cast_nullable_to_non_nullable
as String,fechaInicio: null == fechaInicio ? _self.fechaInicio : fechaInicio // ignore: cast_nullable_to_non_nullable
as DateTime,fechaFin: null == fechaFin ? _self.fechaFin : fechaFin // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,preguntas: null == preguntas ? _self.preguntas : preguntas // ignore: cast_nullable_to_non_nullable
as List<SurveyQuestion>,
  ));
}

}


/// Adds pattern-matching-related methods to [Survey].
extension SurveyPatterns on Survey {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Survey value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Survey() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Survey value)  $default,){
final _that = this;
switch (_that) {
case _Survey():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Survey value)?  $default,){
final _that = this;
switch (_that) {
case _Survey() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_encuesta')  int? id, @JsonKey(name: 'titulo')  String titulo, @JsonKey(name: 'descripcion')  String descripcion, @JsonKey(name: 'fecha_inicio')@ISODateTimeConverter()  DateTime fechaInicio, @JsonKey(name: 'fecha_fin')@ISODateTimeConverter()  DateTime fechaFin, @JsonKey(name: 'is_active', defaultValue: true)  bool isActive, @JsonKey(name: 'preguntas')  List<SurveyQuestion> preguntas)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Survey() when $default != null:
return $default(_that.id,_that.titulo,_that.descripcion,_that.fechaInicio,_that.fechaFin,_that.isActive,_that.preguntas);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_encuesta')  int? id, @JsonKey(name: 'titulo')  String titulo, @JsonKey(name: 'descripcion')  String descripcion, @JsonKey(name: 'fecha_inicio')@ISODateTimeConverter()  DateTime fechaInicio, @JsonKey(name: 'fecha_fin')@ISODateTimeConverter()  DateTime fechaFin, @JsonKey(name: 'is_active', defaultValue: true)  bool isActive, @JsonKey(name: 'preguntas')  List<SurveyQuestion> preguntas)  $default,) {final _that = this;
switch (_that) {
case _Survey():
return $default(_that.id,_that.titulo,_that.descripcion,_that.fechaInicio,_that.fechaFin,_that.isActive,_that.preguntas);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id_encuesta')  int? id, @JsonKey(name: 'titulo')  String titulo, @JsonKey(name: 'descripcion')  String descripcion, @JsonKey(name: 'fecha_inicio')@ISODateTimeConverter()  DateTime fechaInicio, @JsonKey(name: 'fecha_fin')@ISODateTimeConverter()  DateTime fechaFin, @JsonKey(name: 'is_active', defaultValue: true)  bool isActive, @JsonKey(name: 'preguntas')  List<SurveyQuestion> preguntas)?  $default,) {final _that = this;
switch (_that) {
case _Survey() when $default != null:
return $default(_that.id,_that.titulo,_that.descripcion,_that.fechaInicio,_that.fechaFin,_that.isActive,_that.preguntas);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Survey implements Survey {
  const _Survey({@JsonKey(name: 'id_encuesta') this.id, @JsonKey(name: 'titulo') required this.titulo, @JsonKey(name: 'descripcion') required this.descripcion, @JsonKey(name: 'fecha_inicio')@ISODateTimeConverter() required this.fechaInicio, @JsonKey(name: 'fecha_fin')@ISODateTimeConverter() required this.fechaFin, @JsonKey(name: 'is_active', defaultValue: true) required this.isActive, @JsonKey(name: 'preguntas') final  List<SurveyQuestion> preguntas = const []}): _preguntas = preguntas;
  factory _Survey.fromJson(Map<String, dynamic> json) => _$SurveyFromJson(json);

@override@JsonKey(name: 'id_encuesta') final  int? id;
@override@JsonKey(name: 'titulo') final  String titulo;
@override@JsonKey(name: 'descripcion') final  String descripcion;
@override@JsonKey(name: 'fecha_inicio')@ISODateTimeConverter() final  DateTime fechaInicio;
@override@JsonKey(name: 'fecha_fin')@ISODateTimeConverter() final  DateTime fechaFin;
@override@JsonKey(name: 'is_active', defaultValue: true) final  bool isActive;
 final  List<SurveyQuestion> _preguntas;
@override@JsonKey(name: 'preguntas') List<SurveyQuestion> get preguntas {
  if (_preguntas is EqualUnmodifiableListView) return _preguntas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_preguntas);
}


/// Create a copy of Survey
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurveyCopyWith<_Survey> get copyWith => __$SurveyCopyWithImpl<_Survey>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SurveyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Survey&&(identical(other.id, id) || other.id == id)&&(identical(other.titulo, titulo) || other.titulo == titulo)&&(identical(other.descripcion, descripcion) || other.descripcion == descripcion)&&(identical(other.fechaInicio, fechaInicio) || other.fechaInicio == fechaInicio)&&(identical(other.fechaFin, fechaFin) || other.fechaFin == fechaFin)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other._preguntas, _preguntas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,titulo,descripcion,fechaInicio,fechaFin,isActive,const DeepCollectionEquality().hash(_preguntas));

@override
String toString() {
  return 'Survey(id: $id, titulo: $titulo, descripcion: $descripcion, fechaInicio: $fechaInicio, fechaFin: $fechaFin, isActive: $isActive, preguntas: $preguntas)';
}


}

/// @nodoc
abstract mixin class _$SurveyCopyWith<$Res> implements $SurveyCopyWith<$Res> {
  factory _$SurveyCopyWith(_Survey value, $Res Function(_Survey) _then) = __$SurveyCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id_encuesta') int? id,@JsonKey(name: 'titulo') String titulo,@JsonKey(name: 'descripcion') String descripcion,@JsonKey(name: 'fecha_inicio')@ISODateTimeConverter() DateTime fechaInicio,@JsonKey(name: 'fecha_fin')@ISODateTimeConverter() DateTime fechaFin,@JsonKey(name: 'is_active', defaultValue: true) bool isActive,@JsonKey(name: 'preguntas') List<SurveyQuestion> preguntas
});




}
/// @nodoc
class __$SurveyCopyWithImpl<$Res>
    implements _$SurveyCopyWith<$Res> {
  __$SurveyCopyWithImpl(this._self, this._then);

  final _Survey _self;
  final $Res Function(_Survey) _then;

/// Create a copy of Survey
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? titulo = null,Object? descripcion = null,Object? fechaInicio = null,Object? fechaFin = null,Object? isActive = null,Object? preguntas = null,}) {
  return _then(_Survey(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,titulo: null == titulo ? _self.titulo : titulo // ignore: cast_nullable_to_non_nullable
as String,descripcion: null == descripcion ? _self.descripcion : descripcion // ignore: cast_nullable_to_non_nullable
as String,fechaInicio: null == fechaInicio ? _self.fechaInicio : fechaInicio // ignore: cast_nullable_to_non_nullable
as DateTime,fechaFin: null == fechaFin ? _self.fechaFin : fechaFin // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,preguntas: null == preguntas ? _self._preguntas : preguntas // ignore: cast_nullable_to_non_nullable
as List<SurveyQuestion>,
  ));
}


}

// dart format on

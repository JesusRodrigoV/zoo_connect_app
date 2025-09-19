// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'survey_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SurveyOption implements DiagnosticableTreeMixin {

@JsonKey(name: 'id_opcion') int? get id;@JsonKey(name: 'texto_opcion') String get text; int get orden;
/// Create a copy of SurveyOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurveyOptionCopyWith<SurveyOption> get copyWith => _$SurveyOptionCopyWithImpl<SurveyOption>(this as SurveyOption, _$identity);

  /// Serializes this SurveyOption to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SurveyOption'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('text', text))..add(DiagnosticsProperty('orden', orden));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurveyOption&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.orden, orden) || other.orden == orden));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,orden);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SurveyOption(id: $id, text: $text, orden: $orden)';
}


}

/// @nodoc
abstract mixin class $SurveyOptionCopyWith<$Res>  {
  factory $SurveyOptionCopyWith(SurveyOption value, $Res Function(SurveyOption) _then) = _$SurveyOptionCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id_opcion') int? id,@JsonKey(name: 'texto_opcion') String text, int orden
});




}
/// @nodoc
class _$SurveyOptionCopyWithImpl<$Res>
    implements $SurveyOptionCopyWith<$Res> {
  _$SurveyOptionCopyWithImpl(this._self, this._then);

  final SurveyOption _self;
  final $Res Function(SurveyOption) _then;

/// Create a copy of SurveyOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? text = null,Object? orden = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,orden: null == orden ? _self.orden : orden // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SurveyOption].
extension SurveyOptionPatterns on SurveyOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SurveyOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SurveyOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SurveyOption value)  $default,){
final _that = this;
switch (_that) {
case _SurveyOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SurveyOption value)?  $default,){
final _that = this;
switch (_that) {
case _SurveyOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_opcion')  int? id, @JsonKey(name: 'texto_opcion')  String text,  int orden)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SurveyOption() when $default != null:
return $default(_that.id,_that.text,_that.orden);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_opcion')  int? id, @JsonKey(name: 'texto_opcion')  String text,  int orden)  $default,) {final _that = this;
switch (_that) {
case _SurveyOption():
return $default(_that.id,_that.text,_that.orden);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id_opcion')  int? id, @JsonKey(name: 'texto_opcion')  String text,  int orden)?  $default,) {final _that = this;
switch (_that) {
case _SurveyOption() when $default != null:
return $default(_that.id,_that.text,_that.orden);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SurveyOption with DiagnosticableTreeMixin implements SurveyOption {
  const _SurveyOption({@JsonKey(name: 'id_opcion') this.id, @JsonKey(name: 'texto_opcion') required this.text, required this.orden});
  factory _SurveyOption.fromJson(Map<String, dynamic> json) => _$SurveyOptionFromJson(json);

@override@JsonKey(name: 'id_opcion') final  int? id;
@override@JsonKey(name: 'texto_opcion') final  String text;
@override final  int orden;

/// Create a copy of SurveyOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurveyOptionCopyWith<_SurveyOption> get copyWith => __$SurveyOptionCopyWithImpl<_SurveyOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SurveyOptionToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SurveyOption'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('text', text))..add(DiagnosticsProperty('orden', orden));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurveyOption&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.orden, orden) || other.orden == orden));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,orden);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SurveyOption(id: $id, text: $text, orden: $orden)';
}


}

/// @nodoc
abstract mixin class _$SurveyOptionCopyWith<$Res> implements $SurveyOptionCopyWith<$Res> {
  factory _$SurveyOptionCopyWith(_SurveyOption value, $Res Function(_SurveyOption) _then) = __$SurveyOptionCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id_opcion') int? id,@JsonKey(name: 'texto_opcion') String text, int orden
});




}
/// @nodoc
class __$SurveyOptionCopyWithImpl<$Res>
    implements _$SurveyOptionCopyWith<$Res> {
  __$SurveyOptionCopyWithImpl(this._self, this._then);

  final _SurveyOption _self;
  final $Res Function(_SurveyOption) _then;

/// Create a copy of SurveyOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? text = null,Object? orden = null,}) {
  return _then(_SurveyOption(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,orden: null == orden ? _self.orden : orden // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

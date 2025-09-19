// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'usuario.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Usuario {

@JsonKey(name: 'id') int get idUsuario;@JsonKey(name: 'email') String get email;@JsonKey(name: 'username') String get nombreUsuario;@JsonKey(name: 'photo_url') String? get fotoUrl;@JsonKey(name: 'is_active') bool get esActivo;@JsonKey(name: 'role_id', fromJson: Rol.fromId) Rol get rol;@JsonKey(name: 'created_at', fromJson: Usuario._dateFromString) DateTime get createdAt;
/// Create a copy of Usuario
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UsuarioCopyWith<Usuario> get copyWith => _$UsuarioCopyWithImpl<Usuario>(this as Usuario, _$identity);

  /// Serializes this Usuario to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Usuario&&(identical(other.idUsuario, idUsuario) || other.idUsuario == idUsuario)&&(identical(other.email, email) || other.email == email)&&(identical(other.nombreUsuario, nombreUsuario) || other.nombreUsuario == nombreUsuario)&&(identical(other.fotoUrl, fotoUrl) || other.fotoUrl == fotoUrl)&&(identical(other.esActivo, esActivo) || other.esActivo == esActivo)&&(identical(other.rol, rol) || other.rol == rol)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,idUsuario,email,nombreUsuario,fotoUrl,esActivo,rol,createdAt);

@override
String toString() {
  return 'Usuario(idUsuario: $idUsuario, email: $email, nombreUsuario: $nombreUsuario, fotoUrl: $fotoUrl, esActivo: $esActivo, rol: $rol, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $UsuarioCopyWith<$Res>  {
  factory $UsuarioCopyWith(Usuario value, $Res Function(Usuario) _then) = _$UsuarioCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') int idUsuario,@JsonKey(name: 'email') String email,@JsonKey(name: 'username') String nombreUsuario,@JsonKey(name: 'photo_url') String? fotoUrl,@JsonKey(name: 'is_active') bool esActivo,@JsonKey(name: 'role_id', fromJson: Rol.fromId) Rol rol,@JsonKey(name: 'created_at', fromJson: Usuario._dateFromString) DateTime createdAt
});




}
/// @nodoc
class _$UsuarioCopyWithImpl<$Res>
    implements $UsuarioCopyWith<$Res> {
  _$UsuarioCopyWithImpl(this._self, this._then);

  final Usuario _self;
  final $Res Function(Usuario) _then;

/// Create a copy of Usuario
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? idUsuario = null,Object? email = null,Object? nombreUsuario = null,Object? fotoUrl = freezed,Object? esActivo = null,Object? rol = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
idUsuario: null == idUsuario ? _self.idUsuario : idUsuario // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,nombreUsuario: null == nombreUsuario ? _self.nombreUsuario : nombreUsuario // ignore: cast_nullable_to_non_nullable
as String,fotoUrl: freezed == fotoUrl ? _self.fotoUrl : fotoUrl // ignore: cast_nullable_to_non_nullable
as String?,esActivo: null == esActivo ? _self.esActivo : esActivo // ignore: cast_nullable_to_non_nullable
as bool,rol: null == rol ? _self.rol : rol // ignore: cast_nullable_to_non_nullable
as Rol,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Usuario].
extension UsuarioPatterns on Usuario {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Usuario value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Usuario() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Usuario value)  $default,){
final _that = this;
switch (_that) {
case _Usuario():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Usuario value)?  $default,){
final _that = this;
switch (_that) {
case _Usuario() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int idUsuario, @JsonKey(name: 'email')  String email, @JsonKey(name: 'username')  String nombreUsuario, @JsonKey(name: 'photo_url')  String? fotoUrl, @JsonKey(name: 'is_active')  bool esActivo, @JsonKey(name: 'role_id', fromJson: Rol.fromId)  Rol rol, @JsonKey(name: 'created_at', fromJson: Usuario._dateFromString)  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Usuario() when $default != null:
return $default(_that.idUsuario,_that.email,_that.nombreUsuario,_that.fotoUrl,_that.esActivo,_that.rol,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int idUsuario, @JsonKey(name: 'email')  String email, @JsonKey(name: 'username')  String nombreUsuario, @JsonKey(name: 'photo_url')  String? fotoUrl, @JsonKey(name: 'is_active')  bool esActivo, @JsonKey(name: 'role_id', fromJson: Rol.fromId)  Rol rol, @JsonKey(name: 'created_at', fromJson: Usuario._dateFromString)  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Usuario():
return $default(_that.idUsuario,_that.email,_that.nombreUsuario,_that.fotoUrl,_that.esActivo,_that.rol,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  int idUsuario, @JsonKey(name: 'email')  String email, @JsonKey(name: 'username')  String nombreUsuario, @JsonKey(name: 'photo_url')  String? fotoUrl, @JsonKey(name: 'is_active')  bool esActivo, @JsonKey(name: 'role_id', fromJson: Rol.fromId)  Rol rol, @JsonKey(name: 'created_at', fromJson: Usuario._dateFromString)  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Usuario() when $default != null:
return $default(_that.idUsuario,_that.email,_that.nombreUsuario,_that.fotoUrl,_that.esActivo,_that.rol,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Usuario implements Usuario {
  const _Usuario({@JsonKey(name: 'id') required this.idUsuario, @JsonKey(name: 'email') required this.email, @JsonKey(name: 'username') required this.nombreUsuario, @JsonKey(name: 'photo_url') this.fotoUrl, @JsonKey(name: 'is_active') required this.esActivo, @JsonKey(name: 'role_id', fromJson: Rol.fromId) required this.rol, @JsonKey(name: 'created_at', fromJson: Usuario._dateFromString) required this.createdAt});
  factory _Usuario.fromJson(Map<String, dynamic> json) => _$UsuarioFromJson(json);

@override@JsonKey(name: 'id') final  int idUsuario;
@override@JsonKey(name: 'email') final  String email;
@override@JsonKey(name: 'username') final  String nombreUsuario;
@override@JsonKey(name: 'photo_url') final  String? fotoUrl;
@override@JsonKey(name: 'is_active') final  bool esActivo;
@override@JsonKey(name: 'role_id', fromJson: Rol.fromId) final  Rol rol;
@override@JsonKey(name: 'created_at', fromJson: Usuario._dateFromString) final  DateTime createdAt;

/// Create a copy of Usuario
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UsuarioCopyWith<_Usuario> get copyWith => __$UsuarioCopyWithImpl<_Usuario>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UsuarioToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Usuario&&(identical(other.idUsuario, idUsuario) || other.idUsuario == idUsuario)&&(identical(other.email, email) || other.email == email)&&(identical(other.nombreUsuario, nombreUsuario) || other.nombreUsuario == nombreUsuario)&&(identical(other.fotoUrl, fotoUrl) || other.fotoUrl == fotoUrl)&&(identical(other.esActivo, esActivo) || other.esActivo == esActivo)&&(identical(other.rol, rol) || other.rol == rol)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,idUsuario,email,nombreUsuario,fotoUrl,esActivo,rol,createdAt);

@override
String toString() {
  return 'Usuario(idUsuario: $idUsuario, email: $email, nombreUsuario: $nombreUsuario, fotoUrl: $fotoUrl, esActivo: $esActivo, rol: $rol, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$UsuarioCopyWith<$Res> implements $UsuarioCopyWith<$Res> {
  factory _$UsuarioCopyWith(_Usuario value, $Res Function(_Usuario) _then) = __$UsuarioCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') int idUsuario,@JsonKey(name: 'email') String email,@JsonKey(name: 'username') String nombreUsuario,@JsonKey(name: 'photo_url') String? fotoUrl,@JsonKey(name: 'is_active') bool esActivo,@JsonKey(name: 'role_id', fromJson: Rol.fromId) Rol rol,@JsonKey(name: 'created_at', fromJson: Usuario._dateFromString) DateTime createdAt
});




}
/// @nodoc
class __$UsuarioCopyWithImpl<$Res>
    implements _$UsuarioCopyWith<$Res> {
  __$UsuarioCopyWithImpl(this._self, this._then);

  final _Usuario _self;
  final $Res Function(_Usuario) _then;

/// Create a copy of Usuario
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? idUsuario = null,Object? email = null,Object? nombreUsuario = null,Object? fotoUrl = freezed,Object? esActivo = null,Object? rol = null,Object? createdAt = null,}) {
  return _then(_Usuario(
idUsuario: null == idUsuario ? _self.idUsuario : idUsuario // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,nombreUsuario: null == nombreUsuario ? _self.nombreUsuario : nombreUsuario // ignore: cast_nullable_to_non_nullable
as String,fotoUrl: freezed == fotoUrl ? _self.fotoUrl : fotoUrl // ignore: cast_nullable_to_non_nullable
as String?,esActivo: null == esActivo ? _self.esActivo : esActivo // ignore: cast_nullable_to_non_nullable
as bool,rol: null == rol ? _self.rol : rol // ignore: cast_nullable_to_non_nullable
as Rol,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

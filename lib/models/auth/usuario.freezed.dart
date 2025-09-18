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

@JsonKey(name: 'Id_usuario') int get idUsuario;@JsonKey(name: 'Nombre_usuario') String get nombre;@JsonKey(name: 'Email') String get email;@JsonKey(name: 'Password') String get password;@JsonKey(name: 'Created_at') DateTime get createdAt;@JsonKey(name: 'ROLES_Id_rol', fromJson: Rol.fromId, toJson: _rolToId) Rol get rol;@JsonKey(name: 'Foto_url') String get fotoUrl;@JsonKey(name: 'Is_active') bool get isActive;@JsonKey(name: 'Updated_at') DateTime get updatedAt;
/// Create a copy of Usuario
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UsuarioCopyWith<Usuario> get copyWith => _$UsuarioCopyWithImpl<Usuario>(this as Usuario, _$identity);

  /// Serializes this Usuario to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Usuario&&(identical(other.idUsuario, idUsuario) || other.idUsuario == idUsuario)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.rol, rol) || other.rol == rol)&&(identical(other.fotoUrl, fotoUrl) || other.fotoUrl == fotoUrl)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,idUsuario,nombre,email,password,createdAt,rol,fotoUrl,isActive,updatedAt);

@override
String toString() {
  return 'Usuario(idUsuario: $idUsuario, nombre: $nombre, email: $email, password: $password, createdAt: $createdAt, rol: $rol, fotoUrl: $fotoUrl, isActive: $isActive, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $UsuarioCopyWith<$Res>  {
  factory $UsuarioCopyWith(Usuario value, $Res Function(Usuario) _then) = _$UsuarioCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'Id_usuario') int idUsuario,@JsonKey(name: 'Nombre_usuario') String nombre,@JsonKey(name: 'Email') String email,@JsonKey(name: 'Password') String password,@JsonKey(name: 'Created_at') DateTime createdAt,@JsonKey(name: 'ROLES_Id_rol', fromJson: Rol.fromId, toJson: _rolToId) Rol rol,@JsonKey(name: 'Foto_url') String fotoUrl,@JsonKey(name: 'Is_active') bool isActive,@JsonKey(name: 'Updated_at') DateTime updatedAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? idUsuario = null,Object? nombre = null,Object? email = null,Object? password = null,Object? createdAt = null,Object? rol = null,Object? fotoUrl = null,Object? isActive = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
idUsuario: null == idUsuario ? _self.idUsuario : idUsuario // ignore: cast_nullable_to_non_nullable
as int,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,rol: null == rol ? _self.rol : rol // ignore: cast_nullable_to_non_nullable
as Rol,fotoUrl: null == fotoUrl ? _self.fotoUrl : fotoUrl // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'Id_usuario')  int idUsuario, @JsonKey(name: 'Nombre_usuario')  String nombre, @JsonKey(name: 'Email')  String email, @JsonKey(name: 'Password')  String password, @JsonKey(name: 'Created_at')  DateTime createdAt, @JsonKey(name: 'ROLES_Id_rol', fromJson: Rol.fromId, toJson: _rolToId)  Rol rol, @JsonKey(name: 'Foto_url')  String fotoUrl, @JsonKey(name: 'Is_active')  bool isActive, @JsonKey(name: 'Updated_at')  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Usuario() when $default != null:
return $default(_that.idUsuario,_that.nombre,_that.email,_that.password,_that.createdAt,_that.rol,_that.fotoUrl,_that.isActive,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'Id_usuario')  int idUsuario, @JsonKey(name: 'Nombre_usuario')  String nombre, @JsonKey(name: 'Email')  String email, @JsonKey(name: 'Password')  String password, @JsonKey(name: 'Created_at')  DateTime createdAt, @JsonKey(name: 'ROLES_Id_rol', fromJson: Rol.fromId, toJson: _rolToId)  Rol rol, @JsonKey(name: 'Foto_url')  String fotoUrl, @JsonKey(name: 'Is_active')  bool isActive, @JsonKey(name: 'Updated_at')  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Usuario():
return $default(_that.idUsuario,_that.nombre,_that.email,_that.password,_that.createdAt,_that.rol,_that.fotoUrl,_that.isActive,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'Id_usuario')  int idUsuario, @JsonKey(name: 'Nombre_usuario')  String nombre, @JsonKey(name: 'Email')  String email, @JsonKey(name: 'Password')  String password, @JsonKey(name: 'Created_at')  DateTime createdAt, @JsonKey(name: 'ROLES_Id_rol', fromJson: Rol.fromId, toJson: _rolToId)  Rol rol, @JsonKey(name: 'Foto_url')  String fotoUrl, @JsonKey(name: 'Is_active')  bool isActive, @JsonKey(name: 'Updated_at')  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Usuario() when $default != null:
return $default(_that.idUsuario,_that.nombre,_that.email,_that.password,_that.createdAt,_that.rol,_that.fotoUrl,_that.isActive,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Usuario implements Usuario {
  const _Usuario({@JsonKey(name: 'Id_usuario') required this.idUsuario, @JsonKey(name: 'Nombre_usuario') required this.nombre, @JsonKey(name: 'Email') required this.email, @JsonKey(name: 'Password') required this.password, @JsonKey(name: 'Created_at') required this.createdAt, @JsonKey(name: 'ROLES_Id_rol', fromJson: Rol.fromId, toJson: _rolToId) required this.rol, @JsonKey(name: 'Foto_url') required this.fotoUrl, @JsonKey(name: 'Is_active') this.isActive = true, @JsonKey(name: 'Updated_at') required this.updatedAt});
  factory _Usuario.fromJson(Map<String, dynamic> json) => _$UsuarioFromJson(json);

@override@JsonKey(name: 'Id_usuario') final  int idUsuario;
@override@JsonKey(name: 'Nombre_usuario') final  String nombre;
@override@JsonKey(name: 'Email') final  String email;
@override@JsonKey(name: 'Password') final  String password;
@override@JsonKey(name: 'Created_at') final  DateTime createdAt;
@override@JsonKey(name: 'ROLES_Id_rol', fromJson: Rol.fromId, toJson: _rolToId) final  Rol rol;
@override@JsonKey(name: 'Foto_url') final  String fotoUrl;
@override@JsonKey(name: 'Is_active') final  bool isActive;
@override@JsonKey(name: 'Updated_at') final  DateTime updatedAt;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Usuario&&(identical(other.idUsuario, idUsuario) || other.idUsuario == idUsuario)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.rol, rol) || other.rol == rol)&&(identical(other.fotoUrl, fotoUrl) || other.fotoUrl == fotoUrl)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,idUsuario,nombre,email,password,createdAt,rol,fotoUrl,isActive,updatedAt);

@override
String toString() {
  return 'Usuario(idUsuario: $idUsuario, nombre: $nombre, email: $email, password: $password, createdAt: $createdAt, rol: $rol, fotoUrl: $fotoUrl, isActive: $isActive, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$UsuarioCopyWith<$Res> implements $UsuarioCopyWith<$Res> {
  factory _$UsuarioCopyWith(_Usuario value, $Res Function(_Usuario) _then) = __$UsuarioCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'Id_usuario') int idUsuario,@JsonKey(name: 'Nombre_usuario') String nombre,@JsonKey(name: 'Email') String email,@JsonKey(name: 'Password') String password,@JsonKey(name: 'Created_at') DateTime createdAt,@JsonKey(name: 'ROLES_Id_rol', fromJson: Rol.fromId, toJson: _rolToId) Rol rol,@JsonKey(name: 'Foto_url') String fotoUrl,@JsonKey(name: 'Is_active') bool isActive,@JsonKey(name: 'Updated_at') DateTime updatedAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? idUsuario = null,Object? nombre = null,Object? email = null,Object? password = null,Object? createdAt = null,Object? rol = null,Object? fotoUrl = null,Object? isActive = null,Object? updatedAt = null,}) {
  return _then(_Usuario(
idUsuario: null == idUsuario ? _self.idUsuario : idUsuario // ignore: cast_nullable_to_non_nullable
as int,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,rol: null == rol ? _self.rol : rol // ignore: cast_nullable_to_non_nullable
as Rol,fotoUrl: null == fotoUrl ? _self.fotoUrl : fotoUrl // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

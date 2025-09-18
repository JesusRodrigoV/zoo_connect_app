// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Usuario _$UsuarioFromJson(Map<String, dynamic> json) => _Usuario(
  idUsuario: (json['Id_usuario'] as num).toInt(),
  nombre: json['Nombre_usuario'] as String,
  email: json['Email'] as String,
  password: json['Password'] as String,
  createdAt: DateTime.parse(json['Created_at'] as String),
  rol: Rol.fromId((json['ROLES_Id_rol'] as num).toInt()),
  fotoUrl: json['Foto_url'] as String,
  isActive: json['Is_active'] as bool? ?? true,
  updatedAt: DateTime.parse(json['Updated_at'] as String),
);

Map<String, dynamic> _$UsuarioToJson(_Usuario instance) => <String, dynamic>{
  'Id_usuario': instance.idUsuario,
  'Nombre_usuario': instance.nombre,
  'Email': instance.email,
  'Password': instance.password,
  'Created_at': instance.createdAt.toIso8601String(),
  'ROLES_Id_rol': _rolToId(instance.rol),
  'Foto_url': instance.fotoUrl,
  'Is_active': instance.isActive,
  'Updated_at': instance.updatedAt.toIso8601String(),
};

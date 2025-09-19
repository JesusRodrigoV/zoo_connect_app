// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Usuario _$UsuarioFromJson(Map<String, dynamic> json) => _Usuario(
  idUsuario: (json['id'] as num).toInt(),
  email: json['email'] as String,
  nombreUsuario: json['username'] as String,
  fotoUrl: json['photo_url'] as String?,
  esActivo: json['is_active'] as bool,
  rol: Rol.fromId((json['role_id'] as num).toInt()),
  createdAt: Usuario._dateFromString(json['created_at'] as String),
);

Map<String, dynamic> _$UsuarioToJson(_Usuario instance) => <String, dynamic>{
  'id': instance.idUsuario,
  'email': instance.email,
  'username': instance.nombreUsuario,
  'photo_url': instance.fotoUrl,
  'is_active': instance.esActivo,
  'role_id': _$RolEnumMap[instance.rol]!,
  'created_at': instance.createdAt.toIso8601String(),
};

const _$RolEnumMap = {
  Rol.administrador: 'administrador',
  Rol.visitante: 'visitante',
  Rol.cuidador: 'cuidador',
  Rol.veterinario: 'veterinario',
};

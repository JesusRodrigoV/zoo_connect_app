import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zoo_connect_app/models/auth/rol.dart';

part 'usuario.freezed.dart';
part 'usuario.g.dart';

@freezed
abstract class Usuario with _$Usuario {
  const factory Usuario({
    @JsonKey(name: 'Id_usuario') required int idUsuario,
    @JsonKey(name: 'Nombre_usuario') required String nombre,
    @JsonKey(name: 'Email') required String email,
    @JsonKey(name: 'Password') required String password,
    @JsonKey(name: 'Created_at') required DateTime createdAt,
    @JsonKey(name: 'ROLES_Id_rol', fromJson: Rol.fromId, toJson: _rolToId)
    required Rol rol,
    @JsonKey(name: 'Foto_url') required String fotoUrl,
    @JsonKey(name: 'Is_active') @Default(true) bool isActive,
    @JsonKey(name: 'Updated_at') required DateTime updatedAt,
  }) = _Usuario;

  factory Usuario.fromJson(Map<String, dynamic> json) =>
      _$UsuarioFromJson(json);
}

int _rolToId(Rol rol) => rol.id;

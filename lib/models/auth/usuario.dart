import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zoo_connect_app/models/auth/rol.dart';

part 'usuario.freezed.dart';
part 'usuario.g.dart';

@freezed
abstract class Usuario with _$Usuario {
  const factory Usuario({
    @JsonKey(name: 'id') required int idUsuario,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'username') required String nombreUsuario,
    @JsonKey(name: 'photo_url') String? fotoUrl,
    @JsonKey(name: 'is_active') required bool esActivo,
    @JsonKey(name: 'role_id', fromJson: Rol.fromId) required Rol rol,
    @JsonKey(name: 'created_at', fromJson: Usuario._dateFromString)
    required DateTime createdAt,
  }) = _Usuario;

  factory Usuario.fromJson(Map<String, dynamic> json) =>
      _$UsuarioFromJson(json);

  static DateTime _dateFromString(String date) =>
      DateTime.parse(date).toLocal();
}

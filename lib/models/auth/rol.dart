enum Rol {
  usuario(1),
  administrador(2);

  final int id;
  const Rol(this.id);

  static Rol fromId(int id) {
    return Rol.values.firstWhere(
      (rol) => rol.id == id,
      orElse: () => throw ArgumentError('ID de rol no válido: $id'),
    );
  }
}

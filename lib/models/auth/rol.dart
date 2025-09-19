enum Rol {
  administrador(1),
  visitante(2),
  cuidador(3),
  veterinario(4);

  final int id;
  const Rol(this.id);

  String get nombre {
    final nombre = name.toLowerCase();
    return nombre[0].toUpperCase() + nombre.substring(1);
  }

  static Rol fromId(int id) {
    return Rol.values.firstWhere(
      (rol) => rol.id == id,
      orElse: () => throw ArgumentError('ID de rol no válido: $id'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:zoo_connect_app/models/auth/usuario.dart';
import 'package:zoo_connect_app/screens/settings/settings.dart';

class PerfilPage extends StatelessWidget {
  final Usuario usuario;

  const PerfilPage({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final ahora = DateTime.now();

    final diferencia = ahora.difference(usuario.createdAt);

    String textoFecha;
    if (diferencia.inDays < 30) {
      textoFecha = 'Miembro nuevo';
    } else if (diferencia.inDays < 365) {
      final meses = (diferencia.inDays / 30).floor();
      textoFecha = 'Miembro desde hace $meses mes${meses > 1 ? 'es' : ''}';
    } else {
      final anios = (diferencia.inDays / 365).floor();
      textoFecha = 'Miembro desde hace $anios año${anios > 1 ? 's' : ''}';
    }

    if (usuario.rol.id != 1) {
      final anios = (diferencia.inDays / 365).floor();
      textoFecha =
          '${usuario.rol.name} desde hace $anios año${anios > 1 ? 's' : ''}';
      if (diferencia.inDays < 365) {
        final meses = (diferencia.inDays / 30).floor();
        textoFecha =
            '${usuario.rol.name} desde hace $meses mes${meses > 1 ? 'es' : ''}';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mi Perfil",
          style: TextStyle(color: colors.primary, fontSize: 15),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            ),
            icon: Icon(Icons.settings),
            tooltip: 'Ajustes',
          ),
          IconButton(
            icon: Icon(Icons.logout_sharp),
            hoverColor: Colors.red.withAlpha(200),
            tooltip: 'Cerrar Sesion',
            onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Cerrar Sesión"),
                  content: const Text("¡Has cerrado sesión!"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Aceptar"),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: colors.primary.withAlpha(255),
                  width: 3,
                ),
                image: usuario.fotoUrl.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(usuario.fotoUrl),
                        fit: BoxFit.cover,
                      )
                    : null,
                color: Colors.grey[300],
              ),
              child: usuario.fotoUrl.isEmpty
                  ? const Icon(Icons.person, size: 40, color: Colors.grey)
                  : null,
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: colors.surfaceContainer,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      usuario.nombre,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.beenhere, color: colors.primary, size: 20),
                        const SizedBox(width: 8),
                        Row(
                          children: [
                            Text(
                              textoFecha,
                              style: TextStyle(
                                fontSize: 14,
                                color: colors.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem("88", 'Quiz', colors),
                        _buildStatItem("45", 'Puntos', colors),
                        _buildStatItem("12", 'Encuestas', colors),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _buildActionButton(
                            "Edit",
                            false,
                            colors,
                            () {},
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildActionButton(
                            'Share',
                            false,
                            colors,
                            () {},
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.more_horiz),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    _buildMenuItem('Statistic Profile', colors),
                    const SizedBox(height: 16),
                    _buildMenuItem('Job Statistic', colors),
                    const SizedBox(height: 32),
                    _buildMenuItem('Job Statistic', colors),
                    const SizedBox(height: 32),
                    _buildMenuItem('Job Statistic', colors),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'About Me',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: colors.onSurfaceVariant.withAlpha(200),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit_outlined,
                            color: colors.onSurfaceVariant.withAlpha(200),
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {},
                        child: Text(
                          "Cerrar Sesión",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String number, String label, ColorScheme colors) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: colors.onSurfaceVariant.withAlpha(220),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 14, color: colors.onSurface)),
      ],
    );
  }

  Widget _buildActionButton(
    String text,
    bool isPrimary,
    ColorScheme colors,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? colors.primaryContainer : colors.onPrimary,
        foregroundColor: isPrimary ? colors.onPrimaryContainer : colors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        minimumSize: const Size.fromHeight(45),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      child: Text(text),
    );
  }

  Widget _buildMenuItem(String title, ColorScheme colors) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colors.onSurfaceVariant.withAlpha(200),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: colors.onSurface.withAlpha(200),
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: colors.onSurface.withAlpha(200),
            size: 20,
          ),
        ],
      ),
    );
  }
}

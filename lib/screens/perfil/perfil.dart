import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/models/auth/rol.dart';
import 'package:zoo_connect_app/models/auth/usuario.dart';
import 'package:zoo_connect_app/screens/settings/settings.dart';
import 'package:zoo_connect_app/screens/user_stats/user_stats_page.dart';
import 'package:zoo_connect_app/screens/user_stats/user_participations_page.dart';
import 'package:zoo_connect_app/widgets/dialogs/logout_dialog.dart';

class PerfilPage extends ConsumerWidget {
  final Usuario usuario;

  const PerfilPage({super.key, required this.usuario});

  String calcularTiempoMiembro(DateTime fechaCreacion, Rol rol) {
    final ahora = DateTime.now();

    if (fechaCreacion.isAfter(ahora)) {
      return rol.id != 2 ? '${rol.nombre} nuevo' : 'Miembro nuevo';
    }

    final diferencia = ahora.difference(fechaCreacion);
    final dias = diferencia.inDays;

    String pluralizar(int numero, String singular, String plural) {
      return '$numero ${numero == 1 ? singular : plural}';
    }

    String tiempoBase;
    if (dias < 30) {
      tiempoBase = 'nuevo';
    } else if (dias < 365) {
      final meses = (dias / 30).floor();
      tiempoBase = 'desde hace ${pluralizar(meses, "mes", "meses")}';
    } else {
      final anos = (dias / 365).floor();
      tiempoBase = 'desde hace ${pluralizar(anos, "año", "años")}';
    }

    return rol.id != 2 ? '${rol.nombre} $tiempoBase' : 'Miembro $tiempoBase';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    print(usuario.rol.id);
    final textoFecha = calcularTiempoMiembro(usuario.createdAt, usuario.rol);

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
              builder: (context) => const LogoutDialog(),
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
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: colors.primary.withAlpha(150),
                  width: 3,
                ),
                image: usuario.fotoUrl != null
                    ? DecorationImage(
                        image: NetworkImage(usuario.fotoUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
                color: Colors.grey[300],
              ),
              child: usuario.fotoUrl == null
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
                      usuario.nombreUsuario,
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
                    _buildMenuItem(
                      'Mis Estadísticas',
                      colors,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserStatsPage(usuario: usuario),
                        ),
                      ),
                      icon: Icons.bar_chart,
                    ),
                    const SizedBox(height: 16),

                    _buildMenuItem(
                      'Mis Participaciones',
                      colors,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UserParticipationsPage(usuario: usuario),
                        ),
                      ),
                      icon: Icons.history,
                    ),
                    const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => const LogoutDialog(),
                        ),
                        child: Text(
                          "Cerrar Sesión",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.white,
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

  Widget _buildMenuItem(
    String title,
    ColorScheme colors, {
    VoidCallback? onTap,
    IconData? icon,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
            Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, color: colors.primary, size: 24),
                  const SizedBox(width: 12),
                ],
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: colors.onSurface.withAlpha(200),
                  ),
                ),
              ],
            ),
            Icon(
              Icons.chevron_right,
              color: colors.onSurface.withAlpha(200),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

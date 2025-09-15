import 'package:flutter/material.dart';

class ZooNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;

  const ZooNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return NavigationBar(
      onDestinationSelected: onDestinationSelected,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      indicatorColor: colorScheme.primaryContainer,
      selectedIndex: selectedIndex,
      destinations: const [
        NavigationDestination(
          selectedIcon: Icon(Icons.home_filled),
          icon: Icon(Icons.home_outlined),
          label: 'Inicio',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.quiz_outlined),
          icon: Icon(Icons.quiz),
          label: 'Quiz',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.person_2_outlined),
          icon: Icon(Icons.person_2),
          label: 'Perfil',
        ),
      ],
    );
  }
}

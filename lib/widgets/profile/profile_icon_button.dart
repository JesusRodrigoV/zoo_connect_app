import 'package:flutter/material.dart';

class ProfileIconButton extends StatefulWidget {
  const ProfileIconButton({super.key});

  @override
  State<ProfileIconButton> createState() => _ProfileIconButtonState();
}

class _ProfileIconButtonState extends State<ProfileIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      onPressed: () {},
      icon: const Icon(Icons.person),
    );
  }
}

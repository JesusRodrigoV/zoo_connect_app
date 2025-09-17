import 'package:flutter/material.dart';

class AnimalDia extends StatefulWidget {
  const AnimalDia({super.key});

  @override
  State<AnimalDia> createState() => _AnimalDiaState();
}

class _AnimalDiaState extends State<AnimalDia> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      children: [
        Text(
          "Animal del dia",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: colors.primary,
          ),
        ),
        SizedBox(height: 5),
        Stack(
          alignment: const Alignment(0.6, 0.6),
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(25),
              child: Image(image: AssetImage('assets/images/imagen_dia.png')),
            ),
            Container(
              width: 115,
              height: 40,
              decoration: BoxDecoration(
                color: colors.onPrimary.withAlpha(200),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(200),
                    spreadRadius: 3,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),

              child: FilledButton(onPressed: () {}, child: Text("Participa")),
            ),
          ],
        ),
      ],
    );
  }
}

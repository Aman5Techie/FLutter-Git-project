import 'package:flutter/material.dart';

class Card_below_icons extends StatelessWidget {
  const Card_below_icons({super.key, required this.icon, required this.info});
  final IconData icon;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: Colors.white,
        ),

        const SizedBox(
          width: 6,
        ),

        Text(
          info,
          style: const TextStyle(color: Colors.white),
        )
        
      ],
    );
  }
}

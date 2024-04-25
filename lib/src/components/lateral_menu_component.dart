import 'package:flutter/material.dart';

class LateralMenuComponent extends StatelessWidget {
  final String placeholder;
  final VoidCallback onTap; // Define un VoidCallback onTap
  const LateralMenuComponent(
      {Key? key, required this.placeholder, required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Asigna el onTap proporcionado
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey[200],
        ),
        margin: const EdgeInsets.only(bottom: 5, left: 3.0, right: 3.0),
        child: ListTile(
          title: Text(placeholder),
          leading: Icon(Icons.sports_soccer),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CardTitle extends StatelessWidget {
  CardTitle({
    super.key,
    required this.title,
  });
  String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

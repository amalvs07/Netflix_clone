import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants.dart';

class AppBarWidgets extends StatelessWidget {
  AppBarWidgets({super.key, required this.title});
  String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        KWidth,
        Text(
          title,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ),
        const Spacer(),
        const Icon(
          Icons.cast,
          color: Colors.white,
          size: 30,
        ),
        KWidth,
        Container(
          color: Colors.blue,
          width: 30,
          height: 30,
        ),
        KWidth
      ],
    );
  }
}

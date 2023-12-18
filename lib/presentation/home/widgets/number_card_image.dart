import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';

class NumberCardImageWidgets extends StatelessWidget {
  final String imageUrl;
  NumberCardImageWidgets({super.key, required this.index, required this.imageUrl});
  int index;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            SizedBox(
              width: 50,
              height: 150,
            ),
            Container(
              width: 130,
              height: 250,
              decoration: BoxDecoration(
                  image:  DecorationImage(
                    image: NetworkImage(
                      imageUrl,
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(7)),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          top: 45,
          left: 30,
          child: BorderedText(
            strokeWidth: 9.0,
            strokeColor: kWhiteColor,
            child: Text(
              "${index + 1}",
              style: TextStyle(
                  fontSize: 140,
                  color: KBlackColor,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  decorationColor: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

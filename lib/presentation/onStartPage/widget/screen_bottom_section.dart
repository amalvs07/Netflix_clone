import 'package:flutter/material.dart';


import '../../../core/colors/colors.dart';
import '../../../core/constants.dart';


class BottomSection extends StatelessWidget {
  const BottomSection({
    Key? key, required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
         Text(
          title,
          style:const TextStyle(
            letterSpacing: 2,
            fontSize: 28,
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.bold,
          ),
        ),
        KHeight20,
        const Padding(
          padding:  EdgeInsets.symmetric(horizontal:  40.0),
          child:  Text(
            "    Netflix is a subscription-based streaming service that allows our   members to watch TV shows and                 movies...",
            style: TextStyle(
              fontSize: 16,
              
              color: KGreyColor,
            ),
          ),
        ),
        KHeight20,
      ],
    );
  }
}


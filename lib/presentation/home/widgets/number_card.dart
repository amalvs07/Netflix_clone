import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../widgets/card_title.dart';
import 'number_card_image.dart';

class NumberCardWidgets extends StatelessWidget {
  final List<String> posterPath;
  NumberCardWidgets({super.key, required this.titleCard, required this.posterPath});
  String titleCard;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardTitle(
            title: titleCard,
          ),
          KHeight,
          LimitedBox(
            maxHeight: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                posterPath.length,
                (index) => NumberCardImageWidgets(
                  index: index, imageUrl: posterPath[index],
                ),
              ),
            ),
          ),
          KHeight,
        ],
      ),
    );
  }
}

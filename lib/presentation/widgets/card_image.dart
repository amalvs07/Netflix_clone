import 'package:flutter/material.dart';

import '../search/widgets/search_widget.dart';

class CardContainerWidgets extends StatelessWidget {
  final String ImageHomeUrl;
  const CardContainerWidgets({
    super.key, required this.ImageHomeUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 130,
        height: 250,
        decoration: BoxDecoration(
            image:  DecorationImage(
              image: NetworkImage(
                ImageHomeUrl,
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(7)),
      ),
    );
  }
}

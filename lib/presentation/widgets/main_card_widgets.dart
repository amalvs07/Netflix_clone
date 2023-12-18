import 'package:flutter/material.dart';

import '../../core/constants.dart';
import 'card_image.dart';
import 'card_title.dart';

class MainCardWidgets extends StatelessWidget {
 final List<String> ImageUrlHomePostList;
  MainCardWidgets({
    super.key,
    required this.MainTile, required this.ImageUrlHomePostList,
  });
  String MainTile;
  

  @override
  Widget build(BuildContext context) {
    List _k;
   
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardTitle(
            title: MainTile,
          ),
          KHeight,
          LimitedBox(
            maxHeight: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                ImageUrlHomePostList.length,
                
                (index) =>  CardContainerWidgets(ImageHomeUrl: ImageUrlHomePostList[index],),
              ),
            ),
          ),
          KHeight,
        ],
      ),
    );
  }
}

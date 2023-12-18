import 'package:flutter/material.dart';

import '../../core/colors/colors.dart';

class VideoPlayerWidgets extends StatelessWidget {

  final String PosterPath;
  const VideoPlayerWidgets({
    super.key, required this.PosterPath,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Expanded(
          child: SizedBox(
            width: double.infinity,
            height: 200,
            child: Image.network(
              PosterPath,width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 10,
          child: CircleAvatar(
            backgroundColor: KBlackColor,
            radius: 20,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.volume_off,
                color: kWhiteColor,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

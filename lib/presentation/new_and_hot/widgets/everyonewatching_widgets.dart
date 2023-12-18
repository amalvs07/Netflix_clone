import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants.dart';

import '../../../core/colors/colors.dart';
import '../../fast_laughs/widgets/video_item_list.dart';
import '../../widgets/videoplayer_widgets.dart';

class EveryoneWatchingWidgets extends StatelessWidget {
  final String posterPath;
  final String movieName;
  final String description;
  const EveryoneWatchingWidgets(
      {super.key,
      required this.posterPath,
      required this.movieName,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KHeight,
            Text(
              movieName,
              style:const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            KHeight,
            Text(
              description,
              maxLines: 4,
              style:const TextStyle(color: KGreyColor),
            ),
            KHeight,
            VideoPlayerWidgets( PosterPath: posterPath,),
            KHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                VideoActionWidgets(
                  iconData: Icons.share,
                  title: 'Share',
                ),
                VideoActionWidgets(
                  iconData: Icons.add,
                  title: 'My List',
                ),
                VideoActionWidgets(
                  iconData: Icons.play_arrow,
                  title: 'Play',
                ),
                KWidth,
              ],
            )
          ],
        ),
      ),
    );
  }
}

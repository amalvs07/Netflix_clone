import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants.dart';
import '../../fast_laughs/widgets/video_item_list.dart';
import '../../widgets/videoplayer_widgets.dart';

class ComingSoonMovieWidgets extends StatelessWidget {
  final String id;
  final String month;
  final String day;
  final String posterPath;
  final String movieName;
  final String description;

  const ComingSoonMovieWidgets({
    super.key,
    required this.size,
    required this.id,
    required this.month,
    required this.day,
    required this.posterPath,
    required this.movieName,
    required this.description,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 430,
          child: Column(
            children: [
              Text(
                month,
                style: const TextStyle(fontSize: 20, color: Colors.grey),
              ),
              Text(
                day,
                style: const TextStyle(
                    fontSize: 30,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(
          width: size.width - 55,
          height: 450,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VideoPlayerWidgets(
                PosterPath: posterPath,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      movieName,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  VideoActionWidgets(
                    iconData: Icons.safety_check,
                    title: 'Remind Me',
                  ),
                  VideoActionWidgets(
                    iconData: Icons.info,
                    title: 'Info',
                  ),
                ],
              ),
              Text("Coming on $day $month"),
              KHeight,
              Text(movieName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
              KHeight,
              Text(
                description,
                maxLines: 5,
                style: const TextStyle(color: KGreyColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

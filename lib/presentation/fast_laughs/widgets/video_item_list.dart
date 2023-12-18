import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/fash_laugh/fast_laugh_bloc.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/domain/downloads/models/downloads.dart';
import 'package:netflix_clone/presentation/fast_laughs/widgets/videoWidgets.dart';
import 'package:netflix_clone/presentation/search/widgets/search_widget.dart';
import 'package:share_plus/share_plus.dart';

ValueNotifier<Set<int>> likedVideoIdNotifer = ValueNotifier({});

ValueNotifier<Set<int>> AddListNotifer = ValueNotifier({});

ValueNotifier<Set<int>> PlayPauseNotifer = ValueNotifier({});

class VideoListItemInheritedWidgets extends InheritedWidget {
  final Widget widget;
  final Downloads downloadsData;

  const VideoListItemInheritedWidgets(this.widget, this.downloadsData,
      {super.key})
      : super(child: widget);

  @override
  bool updateShouldNotify(covariant VideoListItemInheritedWidgets oldWidget) {
    return oldWidget.downloadsData != downloadsData;
  }

  static VideoListItemInheritedWidgets? of(BuildContext buildContext) {
    return buildContext
        .dependOnInheritedWidgetOfExactType<VideoListItemInheritedWidgets>();
  }
}

class VideoListItem extends StatelessWidget {
  final int index;
  VideoListItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final posterPath =
        VideoListItemInheritedWidgets.of(context)?.downloadsData.posterPath;

    final VideoURL = DummyvideoUrls[index % DummyvideoUrls.length];
    
    return Stack(
      children: [
        VideoPlayerWidget(
          VideoURL: VideoURL,
          onStateChanged: (bool) {},
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //left side
                // CircleAvatar(
                //   backgroundColor: KBlackColor,
                //   radius: 30,
                //   child: IconButton(
                //     onPressed: () {},
                //     icon: Icon(
                //       Icons.volume_off,
                //       color: kWhiteColor,
                //       size: 30,
                //     ),
                //   ),
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      backgroundImage: posterPath == null
                          ? NetworkImage(imageURL)
                          : NetworkImage('$imageAppendUrl$posterPath'),
                      radius: 30,
                    ),
                    ValueListenableBuilder(
                      valueListenable: likedVideoIdNotifer,
                      builder: (BuildContext con, Set<int> newLikedLists,
                          Widget? _) {
                        final _index = index;
                        if (newLikedLists.contains(_index)) {
                          return GestureDetector(
                            onTap: () {
                              // BlocProvider.of<FastLaughBloc>(context).add(UnlikeVideo(id: _index));
                              likedVideoIdNotifer.value.remove(_index);
                              likedVideoIdNotifer.notifyListeners();
                            },
                            child: VideoActionWidgets(
                              iconData: Icons.favorite_outlined,
                              title: 'Liked',
                            ),
                          );
                        }
                        return GestureDetector(
                          onTap: (() {
                            //    BlocProvider.of<FastLaughBloc>(context).add(LikeVideo(id: _index));

                            likedVideoIdNotifer.value.add(_index);
                            likedVideoIdNotifer.notifyListeners();
                          }),
                          child: VideoActionWidgets(
                            iconData: Icons.emoji_emotions,
                            title: 'LOL',
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                        valueListenable: AddListNotifer,
                        builder: (BuildContext con, Set<int> NewAddLists,
                            Widget? _) {
                          final _index = index;
                          if (NewAddLists.contains(_index)) {
                            return GestureDetector(
                              onTap: () {
                                AddListNotifer.value.remove(_index);
                                AddListNotifer.notifyListeners();
                              },
                              child: VideoActionWidgets(
                                iconData: Icons.done_rounded,
                                title: 'Added',
                              ),
                            );
                          } else {
                            return GestureDetector(
                              onTap: () {
                                AddListNotifer.value.add(_index);
                                AddListNotifer.notifyListeners();
                              },
                              child: VideoActionWidgets(
                                iconData: Icons.add,
                                title: 'My List',
                              ),
                            );
                          }
                        }),
                    GestureDetector(
                      onTap: () {
                        final movieImagename =
                            VideoListItemInheritedWidgets.of(context)
                                ?.downloadsData
                                .posterPath;
                        if (movieImagename != null) {
                          Share.share(movieImagename);
                        }
                      },
                      child: VideoActionWidgets(
                        iconData: Icons.share,
                        title: 'Share',
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: PlayPauseNotifer,
                      builder: (BuildContext con, Set<int> PlayPauseList,
                          Widget? _) {
                        final _index = index;
                        if (PlayPauseList.contains(_index)) {
                          return GestureDetector(
                            onTap: () {
                              PlayPauseNotifer.value.remove(_index);
                              PlayPauseNotifer.notifyListeners();
                            },
                            child: VideoActionWidgets(
                              iconData: Icons.pause_outlined,
                              title: 'Pause',
                            ),
                            
                          );
                        } else {
                          return GestureDetector(
                            onTap: () {
                              PlayPauseNotifer.value.add(_index);
                              PlayPauseNotifer.notifyListeners();
                            },
                            
                            child: VideoActionWidgets(
                              iconData: Icons.play_arrow,
                              title: 'Play',
                            ),
                          );
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class VideoActionWidgets extends StatelessWidget {
  VideoActionWidgets({
    super.key,
    required this.iconData,
    required this.title,
  });
  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Icon(
            iconData,
            color: kWhiteColor,
            size: 30,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

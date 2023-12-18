import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/home/home_bloc.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/home/widgets/number_card.dart';
import 'package:netflix_clone/presentation/widgets/network_error.dart';
import 'dart:math';
import '../fast_laughs/widgets/video_item_list.dart';
import '../widgets/card_image.dart';
import '../widgets/card_title.dart';
import '../widgets/main_card_widgets.dart';

ValueNotifier<bool> ScrollvalueNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: ScrollvalueNotifier,
          builder: (BuildContext context, index, _) {
            return NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                final ScrollDirection direction = notification.direction;
                print(direction);
                if (direction == ScrollDirection.reverse) {
                  ScrollvalueNotifier.value = false;
                } else {
                  ScrollvalueNotifier.value = false;
                }
                return true;
              },
              child: Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () async {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        BlocProvider.of<HomeBloc>(context)
                            .add(const GetHomeScreenData());
                      });
                    },
                    child: BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          );
                        } else if (state.hasError) {
                          return const NetworkErrorWidget();
                        } else if (state.pastYearMovieList.isEmpty ||
                            state.trendingMovieList.isEmpty ||
                            state.tenseDramaMovieList.isEmpty ||
                            state.southIndianMovieList.isEmpty ||
                            state.trendingTvList.isEmpty) {
                          return const Center(
                            child: Text("Something went wrong ! List Empty"),
                          );
                        } else {
                          final _releasePastYear =
                              state.pastYearMovieList.map((e) {
                            return '$imageAppendUrl${e.posterPath}';
                          }).toList();
                          _releasePastYear.shuffle();

                          final _trendingMovieList =
                              state.trendingMovieList.map((e) {
                            return '$imageAppendUrl${e.posterPath}';
                          }).toList();
                          _trendingMovieList.shuffle();

                          final _tenseDrama =
                              state.tenseDramaMovieList.map((e) {
                            return '$imageAppendUrl${e.posterPath}';
                          }).toList();
                          _tenseDrama.shuffle();

                          final _southInidan =
                              state.southIndianMovieList.map((e) {
                            return '$imageAppendUrl${e.posterPath}';
                          }).toList();
                          _southInidan.shuffle();

                          final _trendinTvList = state.trendingTvList.map((e) {
                            return '$imageAppendUrl${e.posterPath}';
                          }).toList();
                          _trendinTvList.shuffle();

                          Random random = new Random();
                          int randomNumber = random.nextInt(19);

                          print(randomNumber);

                          final _PosterImage =
                              '$imageAppendUrl${state.southIndianMovieList[randomNumber].posterPath}';

                          return ListView(
                            children: [
                              MainPageFrontScreen(
                                imageUrl: _PosterImage,
                              ),
                              MainCardWidgets(
                                MainTile: "Released in the last year",
                                ImageUrlHomePostList:
                                    _releasePastYear.sublist(0, 15),
                              ),
                              MainCardWidgets(
                                  MainTile: "Trending Now",
                                  ImageUrlHomePostList:
                                      _trendingMovieList.sublist(0, 15)),
                              NumberCardWidgets(
                                titleCard: "Top 10 TV shows in india today",
                                posterPath: _trendinTvList.sublist(0, 10),
                              ),
                              MainCardWidgets(
                                  MainTile: "Tense Dramas",
                                  ImageUrlHomePostList:
                                      _tenseDrama.sublist(0, 15)),
                              MainCardWidgets(
                                  MainTile: "South Indian Cinemas",
                                  ImageUrlHomePostList:
                                      _southInidan.sublist(0, 15)),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                  ScrollvalueNotifier.value == true
                      ? AnimatedContainer(
                          duration: const Duration(milliseconds: 1000),
                          width: double.infinity,
                          height: 65,
                          color: Colors.black.withOpacity(0.3),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  KWidth,
                                  Image.network(
                                    "https://www.freepnglogos.com/uploads/netflix-logo-app-png-16.png",
                                    width: 40,
                                    height: 40,
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.cast,
                                    color: kWhiteColor,
                                    size: 30,
                                  ),
                                  KWidth,
                                  Container(
                                    width: 30,
                                    height: 30,
                                    color: Colors.blue,
                                  ),
                                  KWidth,
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "TV Shows",
                                    style: KTextStyle,
                                  ),
                                  Text(
                                    "Movies",
                                    style: KTextStyle,
                                  ),
                                  Text(
                                    "Categeries",
                                    style: KTextStyle,
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      : KHeight
                ],
              ),
            );
          }),
    );
  }
}

class MainPageFrontScreen extends StatelessWidget {
  final String imageUrl;
  const MainPageFrontScreen({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 600,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(imageUrl),
          )),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              VideoActionWidgets(
                iconData: Icons.add,
                title: 'My List',
              ),
              TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kWhiteColor),
                ),
                onPressed: () {},
                icon: const Icon(
                  Icons.play_arrow,
                  color: KBlackColor,
                ),
                label: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Play",
                    style: TextStyle(
                      color: KBlackColor,
                    ),
                  ),
                ),
              ),
              VideoActionWidgets(
                iconData: Icons.info,
                title: 'Info',
              ),
            ],
          ),
        )
      ],
    );
  }
}

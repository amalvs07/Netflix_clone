import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:netflix_clone/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/presentation/new_and_hot/widgets/comingsoon_widgets.dart';
import 'package:netflix_clone/presentation/new_and_hot/widgets/everyonewatching_widgets.dart';
import 'package:netflix_clone/presentation/widgets/network_error.dart';

import '../../core/constants.dart';
import '../fast_laughs/widgets/video_item_list.dart';
import '../widgets/videoplayer_widgets.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({super.key});

  @override
  Widget build(BuildContext context) {
   
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "New & Hot",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: kWhiteColor
              ),
            ),
            actions: [
              const Icon(
                Icons.cast,
                size: 30,
                color: kWhiteColor,
              ),
              KWidth,
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                color: Colors.blue,
                width: 30,
                height: 30,
              ),
              KWidth,
            ],
            bottom: TabBar(
              labelColor: KBlackColor,
              isScrollable: true,
              unselectedLabelColor: kWhiteColor,
              labelStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              indicator: BoxDecoration(
                color: kWhiteColor,
                borderRadius: KBorder20,
              ),
              tabs: const [
                Tab(
                  text: "🍿Coming Soon",
                ),
                Tab(
                  text: "👀 Everyone's Watching",
                )
              ],
            ),
          ),
        ),
        body: const TabBarView(children: [
          CommingSoonList(
            key: Key("coming_soon"),
          ),
          EveryOneWatchingListss(),
        ]),
      ),
    );
  }
}

class CommingSoonList extends StatelessWidget {
  const CommingSoonList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const LoadDataInCommingSoon());
    });

    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInCommingSoon());
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const NetworkErrorWidget();
          } else if (state.commingSoonList.isEmpty) {
            return const Center(
              child: Text("Empty"),
            );
          } else {
            return ListView.builder(
              itemCount: state.commingSoonList.length,
              itemBuilder: (context, index) {
                final movie = state.commingSoonList[index];

                if (movie.id == null) {
                  return const SizedBox();
                }
                String month = '';
                String day = '';

                try {
                  final _date = DateTime.parse(movie.releaseDate!);
                  final formatedDate = DateFormat.yMMMMd('en_US').format(_date);
                  month = formatedDate
                      .split(" ")
                      .first
                      .substring(0, 3)
                      .toUpperCase();
                  day = movie.releaseDate!.split("-")[1];
                } catch (_) {
                  month = '';
                  day = '';
                }

                return ComingSoonMovieWidgets(
                  size: size,
                  id: movie.id.toString(),
                  month: month,
                  day: day,
                  posterPath: "$imageAppendUrl${movie.posterPath}",
                  movieName: movie.originalTitle ?? "No Title",
                  description: movie.overview ?? "No Description",
                );
              },
            );
          }
        },
      ),
    );
  }
}

class EveryOneWatchingListss extends StatelessWidget {
  const EveryOneWatchingListss({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const LoadDataInEveryOneWatching());
    });
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInEveryOneWatching());
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const NetworkErrorWidget();
          } else if (state.EveryOneIsWatchingList.isEmpty) {
            return const Center(
              child: Text("Empty"),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: state.EveryOneIsWatchingList.length,
              itemBuilder: (context, index) {
                final TV = state.EveryOneIsWatchingList[index];

                if (TV.id == null) {
                  return const SizedBox();
                }

                return EveryoneWatchingWidgets(
                  posterPath: "$imageAppendUrl${TV.posterPath}",
                  movieName: TV.originalName ?? "No Title",
                  description: TV.overview ?? "No Description",
                );
              },
            );
          }
        },
      ),
    );
  }
}

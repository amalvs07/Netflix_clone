import 'dart:math';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/downloads/downloads_bloc.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/widgets/app_bar_widgets.dart';

class ScreenDownloads extends StatelessWidget {
  ScreenDownloads({super.key});
  final _widgetList = [const _SmartDownloads(), Section2(), const Section3()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarWidgets(
          title: "Downloads",
        ),
      ),
      backgroundColor: BackGroundColor,
      body: SafeArea(
          child: ListView.separated(
        padding: EdgeInsets.all(10),
        itemBuilder: (ctx, index) => _widgetList[index],
        separatorBuilder: (ctx, index) => SizedBox(
          height: 25,
        ),
        itemCount: _widgetList.length,
      )),
    );
  }
}

class Section2 extends StatelessWidget {
  Section2({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<DownloadsBloc>(context)
          .add(const DownloadsEvent.getDownloadsImage());
    });

    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const Text(
            "Introducing Downloads for you",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          KHeight,
          const Text(
            "We will download a personalised selection of movies and shows for you, so there's always something to watch on your device",
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          BlocBuilder<DownloadsBloc, DownloadsState>(
            builder: (context, state) {
              if (state.downloads == null || state.downloads!.isEmpty) {
                return SizedBox(
                  width: size.width,
                  height: size.width,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return SizedBox(
                width: size.width,
                height: size.width,
                child: state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Stack(
                        alignment: Alignment.center,
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: size.width * 0.4,
                              backgroundColor: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          DownloadsImageWidgets(
                            margin: const EdgeInsets.only(
                              left: 180,
                              bottom: 50,
                            ),
                            imagelist:
                                '$imageAppendUrl${state.downloads?[0].posterPath}',
                            angle: 25,
                            size: Size(size.width * 0.43, size.width * 0.58),
                          ),
                          DownloadsImageWidgets(
                            margin: const EdgeInsets.only(
                              right: 180,
                              bottom: 50,
                            ),
                            imagelist:
                                '$imageAppendUrl${state.downloads?[1].posterPath}',
                            angle: -25,
                            size: Size(size.width * 0.43, size.width * 0.58),
                          ),
                          DownloadsImageWidgets(
                            margin: const EdgeInsets.only(left: 0, top: 20),
                            radius: 10,
                            imagelist:
                                '$imageAppendUrl${state.downloads?[2].posterPath}',
                            size: Size(size.width * 0.54, size.width * 0.88),
                          ),
                        ],
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Section3 extends StatelessWidget {
  const Section3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: MaterialButton(
            onPressed: () {},
            color: KButtonColorBlue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
              5,
            )),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Set up",
                style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        KHeight,
        MaterialButton(
          onPressed: () {},
          color: kWhiteColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
            5,
          )),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "See what you can download",
              style: TextStyle(
                  color: KBlackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}

class _SmartDownloads extends StatelessWidget {
  const _SmartDownloads({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        KWidth,
        Icon(
          Icons.settings,
          color: kWhiteColor,
        ),
        KWidth,
        Text("Smart Downloads")
      ],
    );
  }
}

class DownloadsImageWidgets extends StatelessWidget {
  const DownloadsImageWidgets({
    super.key,
    this.angle = 0,
    required this.margin,
    required this.imagelist,
    required this.size,
    this.radius = 7,
  });

  final double angle;
  final String imagelist;
  final EdgeInsets margin;
  final Size size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * pi / 180,
      child: Container(
        margin: margin,
        width: size.width * 0.9,
        height: size.width * 1.23,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  imagelist,
                ))),
      ),
    );
  }
}

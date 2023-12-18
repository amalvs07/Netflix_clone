import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/fash_laugh/fast_laugh_bloc.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/fast_laughs/widgets/video_item_list.dart';
import 'package:netflix_clone/presentation/widgets/network_error.dart';

class ScreenFastLaughs extends StatelessWidget {
  const ScreenFastLaughs({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<FastLaughBloc>(context).add(const Initialize());
    });

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
             WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<FastLaughBloc>(context).add(const Initialize());
    });
          },
          child: BlocBuilder<FastLaughBloc, FastLaughState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );
              } else if (state.isError) {
                return const NetworkErrorWidget();
              } else if (state.videoList.isEmpty) {
                return const Center(
                  child: Text("Video List Empty"),
                );
              } else {
            List  _k=state.videoList.toList();
            _k.shuffle();
                return PageView(
                  scrollDirection: Axis.vertical,
                  children: List.generate(_k.length, (index) {
                    return VideoListItemInheritedWidgets(
                      VideoListItem(
                        index: index,
                        key: Key(index.toString()),
                      ),
                      _k[index],
                    );
                  }),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}


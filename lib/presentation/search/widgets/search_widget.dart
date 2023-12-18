import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/search/search_bloc.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/search/widgets/title.dart';

const imageURL =
    "https://www.themoviedb.org/t/p/original/mXLOHHc1Zeuwsl4xYKjKh2280oL.jpg";

class SearchResults extends StatelessWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchTitle(
          title: "Movies & TV",
        ),
        KHeight,
        Expanded(
            child: GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1 / 1.4,
          children: List.generate(
            21,
            (index) {
              return BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  final movie = state.searchResultMovie[index];
                  return MainCard(
                    ImageURLNEW: '$imageAppendUrl${movie.posterPath}',
                  );
                },
              );
            },
          ),
        )),
      ],
    );
  }
}

class MainCard extends StatelessWidget {
  final String ImageURLNEW;
  MainCard({super.key, required this.ImageURLNEW});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              ImageURLNEW,
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(7)),
    );
  }
}

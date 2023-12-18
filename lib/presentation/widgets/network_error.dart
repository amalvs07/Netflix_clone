import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';

class NetworkErrorWidget extends StatelessWidget {
  const NetworkErrorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cell_tower_rounded,
              size: 30.0,
              color: kWhiteColor,
            ),
            KHeight,
            Text(
              "Oops!",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: KGreyColor),
            ),
            KHeight,
            Text(
              "No Internet Connection",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kWhiteColor),
            ),
            KHeight,
          ]),
    );
  }
}

import 'package:flutter/material.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class BottamNavigationWidgets extends StatelessWidget {
  const BottamNavigationWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: indexChangeNotifier,
        builder: (BuildContext context, int newindex, _) => BottomNavigationBar(
              currentIndex: newindex,
              onTap: (index) {
                indexChangeNotifier.value = index;
              },
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              selectedFontSize: 15,
              
              unselectedFontSize: 12,
              backgroundColor: Colors.black,
              iconSize: 25,
              selectedIconTheme: IconThemeData(
                color: Colors.white,
              ),
              unselectedIconTheme: IconThemeData(
                color: Colors.grey,
              ),
              items:const [
                BottomNavigationBarItem(
                 
                    icon: Icon(
                      Icons.home,
                    ),
                    label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.collections,
                    ),
                    label: "New & Hot"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.emoji_emotions,
                    ),
                    label: "Fast Laughs"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search,
                    ),
                    label: "Search"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.download,
                    ),
                    label: "Downloads"),
              ],
            ));
  }
}

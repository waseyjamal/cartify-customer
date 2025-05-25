import 'package:cartify/bottomNavigationBar/cartScreen.dart';
import 'package:cartify/bottomNavigationBar/historyScreen.dart';
import 'package:cartify/bottomNavigationBar/mainScreen.dart';
import 'package:cartify/bottomNavigationBar/profileScreen.dart';
import 'package:flutter/material.dart';


class bottomNavigationBar extends StatefulWidget {
  const bottomNavigationBar({super.key});

  @override
  State<bottomNavigationBar> createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<bottomNavigationBar> {
  int pageIndex = 0;

  final pages = [
    mainScreen(),
    historyScreen(),
    cartScreen(),
    profileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The expression pages[pageIndex] is used to determine which widget (screen)
      // should be displayed in the body of the Scaffold.
      body: pages[pageIndex],
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          // color: const Color.fromARGB(255, 116, 10, 187),
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              icon: Icon(
                Icons.home_outlined,
                color: pageIndex == 0 ? Colors.black : Colors.black45,
                size: 35,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              icon: Icon(
                Icons.history,
                color: pageIndex == 1 ? Colors.black : Colors.black45,
                size: 35,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              icon: Icon(
                Icons.shopping_cart,
                color: pageIndex == 2 ? Colors.black : Colors.black45,
                size: 35,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 3;
                });
              },
              icon: Icon(
                Icons.person_outline,
                color: pageIndex == 3 ? Colors.black : Colors.black45,
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


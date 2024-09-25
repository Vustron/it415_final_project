// utils
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:babysitterapp/utils/get_icons.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';

// actions
import 'package:babysitterapp/actions/navbar/goto_page.dart';

// screens
import 'search.dart';
import 'home.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() => _currentIndex = index);
        },
        children: const <Widget>[
          HomeScreen(),
          Center(child: Text('1')),
          Center(child: Text('2')),
          Center(child: Text('3')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          gotoPage(context, const SearchScreen());
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
        child: const HugeIcon(
          icon: HugeIcons.strokeRoundedSearch01,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: List<IconData>.generate(
          4,
          (int index) => getIcon(index, index == _currentIndex),
        ),
        activeIndex: _currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 10,
        rightCornerRadius: 10,
        onTap: _onItemTapped,
        iconSize: 30,
        activeColor: Colors.lightBlue,
        splashColor: Colors.lightBlue.withOpacity(0.2),
        splashRadius: 30,
        height: 65,
        shadow: const BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 6,
          spreadRadius: 0.5,
          color: Colors.grey,
        ),
      ),
    );
  }
}

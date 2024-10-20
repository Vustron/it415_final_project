// utils
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:babysitterapp/core/constants/views_list.dart';
import 'package:babysitterapp/core/helper/get_icons.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';

// actions
import 'package:babysitterapp/core/helper/goto_page.dart';

// screens
import 'package:babysitterapp/views/search/search.dart';

class BottomNavbarView extends StatefulWidget {
  const BottomNavbarView({super.key});

  @override
  State<BottomNavbarView> createState() => _BottomNavbarViewState();
}

class _BottomNavbarViewState extends State<BottomNavbarView> {
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
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() => _currentIndex = index);
        },
        children: screens,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToPage(context, const SearchScreen(), 'rightToLeftWithFade');
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

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/core/constants.dart';
import 'package:babysitterapp/core/helpers.dart';

import 'package:babysitterapp/views/search.dart';

class BottomNavbarView extends HookWidget {
  const BottomNavbarView({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> currentIndex = useState(0);
    final PageController pageController = usePageController();

    void onItemTapped(int index) {
      currentIndex.value = index;
      pageController.jumpToPage(index);
    }

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (int index) {
          currentIndex.value = index;
        },
        children: screens,
      ),
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: FloatingActionButton(
          onPressed: () {
            goToPage(context, const SearchView(), 'rightToLeftWithFade');
          },
          shape: const CircleBorder(),
          backgroundColor: Colors.white,
          child: const Icon(
            FluentIcons.search_24_regular,
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: List<IconData>.generate(
          4,
          (int index) => getIcon(index, index == currentIndex.value),
        ),
        activeIndex: currentIndex.value,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 10,
        rightCornerRadius: 10,
        onTap: onItemTapped,
        iconSize: 30,
        activeColor: const Color(0xFF1686AA),
        splashColor: const Color(0xFF1686AA).withOpacity(0.2),
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

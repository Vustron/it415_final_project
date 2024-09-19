// utils
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

// screens
import 'home.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  int indxpage = 0;

  //set pagenav
  late PageController pageCon;
  @override
  void initState() {
    super.initState();
    pageCon = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageCon.dispose();
  }

  void navigationTapped(int page) {
    pageCon.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      indxpage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: pageCon,
        onPageChanged: onPageChanged,
        //use as widget scaffold✅
        children: const <Widget>[
          HomeScreen(),
          Center(child: Text('1')),
          Center(child: Text('2')),
          Center(child: Text('3')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        backgroundColor: Colors.white,
        child: const HugeIcon(
          icon: HugeIcons.strokeRoundedSearch01,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        splashRadius: 45,
        leftCornerRadius: 10,
        rightCornerRadius: 10,
        notchSmoothness: NotchSmoothness.softEdge,
        splashColor: Colors.deepPurple,
        iconSize: 30,
        activeColor: Colors.deepPurple,
        height: 65,
        gapLocation: GapLocation.center,
        //icons nav
        icons: const <IconData>[
          HugeIcons.strokeRoundedHome11,
          HugeIcons.strokeRoundedMapsLocation01,
          HugeIcons.strokeRoundedNotification02,
          HugeIcons.strokeRoundedUserCircle,
        ],
        activeIndex: indxpage,
        onTap: navigationTapped,
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

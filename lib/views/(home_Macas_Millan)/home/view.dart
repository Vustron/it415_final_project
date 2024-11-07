import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/core/helper/goto_page.dart';
import 'package:babysitterapp/core/constants/assets.dart';
import 'package:babysitterapp/core/constants/styles.dart';

import 'widgets/toprated_babysitter.dart';
import 'widgets/toprate_card.dart';
import 'widgets/card_nearby.dart';
import 'widgets/nearby.dart';

import 'package:babysitterapp/views/(settings_JK_Gerald)/settings/view.dart';
import 'package:babysitterapp/views/(booking_runa)/booking/view.dart';

class HomeView extends HookWidget with GlobalStyles {
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> currentIndex = useState(0);
    final CarouselSliderController carouselController =
        useMemoized(() => CarouselSliderController());

    final List<Widget> babysitterCards = List<Widget>.generate(
      10,
      (int index) => babySitterCardNearby(context),
    );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        leading: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: CircleAvatar(
            backgroundImage: AssetImage(avatar2),
          ),
        ),
        centerTitle: false,
        title: Text(
          'Hello Arvin Sison!',
          style: headerStyle.copyWith(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              goToPage(context, const BookingView(), 'rightToLeftWithFade');
            },
            icon: const Icon(
              FluentIcons.person_add_16_regular,
              color: Colors.black,
              size: 31,
            ),
          ),
          IconButton(
            onPressed: () {
              goToPage(context, const SettingsView(), 'rightToLeftWithFade');
            },
            icon: const Icon(
              FluentIcons.settings_16_filled,
              color: Colors.black,
              size: 31,
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(GlobalStyles.defaultPadding),
            child: Center(
              child: Column(
                children: <Widget>[
                  titleBabySitterNearby(),
                  //carousel
                  //many types of carousel based on package
                  CarouselSlider(
                    carouselController: carouselController,
                    items: babysitterCards,
                    options: CarouselOptions(
                        height: 250,
                        enableInfiniteScroll: false,
                        enlargeCenterPage: true,
                        onPageChanged:
                            (int index, CarouselPageChangedReason reason) {
                          currentIndex.value = index;
                        }),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: babysitterCards
                        .asMap()
                        .entries
                        .map((MapEntry<int, Widget> entry) {
                      return GestureDetector(
                        onTap: () =>
                            carouselController.animateToPage(entry.key),
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(
                                currentIndex.value == entry.key ? 0.9 : 0.4),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  titleTopRatedBabySitter(),
                  topRatedBabySitterCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

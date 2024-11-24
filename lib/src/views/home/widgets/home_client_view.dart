import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/views.dart';

class HomeClientView extends StatelessWidget with GlobalStyles {
  HomeClientView({
    super.key,
    this.defaultPadding = GlobalStyles.defaultPadding,
    this.carouselController,
    this.babysitterCards = const <Widget>[],
    this.currentIndex,
  });

  final double defaultPadding;
  final CarouselSliderController? carouselController;
  final List<Widget> babysitterCards;
  final ValueNotifier<int>? currentIndex;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Center(
            child: Column(
              children: <Widget>[
                titleBabySitterNearby(),
                if (babysitterCards.isNotEmpty) ...<Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.30,
                    child: CarouselSlider(
                      carouselController: carouselController,
                      items: babysitterCards,
                      options: CarouselOptions(
                        enlargeFactor: 0.20,
                        enableInfiniteScroll: false,
                        enlargeCenterPage: true,
                        onPageChanged:
                            (int index, CarouselPageChangedReason reason) {
                          currentIndex?.value = index;
                        },
                      ),
                    ),
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
                            carouselController?.animateToPage(entry.key),
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: GlobalStyles.primaryButtonColor.withOpacity(
                              currentIndex?.value == entry.key ? 0.9 : 0.4,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
                titleTopRatedBabySitter(),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return topRatedBabySitterCard(
                      networkImage: networkImage1,
                      nameUser: 'Ms. Kara',
                      ratePhp: '200',
                      starCount: '5.0',
                      reviewsCount: '999',
                    );
                  },
                ),
                const SizedBox(height: 15)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

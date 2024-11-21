import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

class HomeClientView extends HookConsumerWidget with GlobalStyles {
  HomeClientView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthState authState = ref.watch(authControllerProvider);
    final ValueNotifier<int> currentIndex = useState(0);
    final CarouselSliderController carouselController =
        CarouselSliderController();

    final List<Widget> babysitterCards = List<Widget>.generate(
      5,
      (int index) => babySitterCardNearby(
        context,
        networkImage: networkImage1,
        nameUser: 'Ms. Kara',
        ratePhp: '200',
        locationUser: 'Panabo City',
        starCount: '5.0',
        userBio:
            'lorem ispium lorem ispium lorem ispium lorem ispium lorem ispium lorem ispium lorem ispium',
        name: '',
        number: '',
        image: '',
      ),
    );

    Widget buildTitle(UserAccount? user) {
      if (user == null) {
        return const Text('Guest Mode');
      }
      if (user.role != 'Client') {
        return const Text('Dashboard');
      }

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Hello ${user.name}!',
            style: headerStyle.copyWith(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          Text(
            'Location: ${user.address}',
            maxLines: 1,
            style: const TextStyle(fontSize: 10),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: buildTitle(authState.user),
        actions: <Widget>[
          if (authState.user?.role == 'Client')
            IconButton(
              onPressed: () => CustomRouter.navigateToWithTransition(
                BookingView(),
                'rightToLeftWithFade',
              ),
              icon: const Icon(
                FluentIcons.person_add_16_regular,
                color: Colors.black,
                size: 31,
              ),
            ),
          IconButton(
            onPressed: () => CustomRouter.navigateToWithTransition(
              SettingsView(),
              'rightToLeftWithFade',
            ),
            icon: const Icon(
              FluentIcons.settings_16_filled,
              color: Colors.black,
              size: 31,
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: authState.user == null
          ? const CircularProgressIndicator()
          : authState.user!.role == 'Client'
              ? ListView(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.all(GlobalStyles.defaultPadding),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            titleBabySitterNearby(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.30,
                              child: CarouselSlider(
                                carouselController: carouselController,
                                items: babysitterCards,
                                options: CarouselOptions(
                                  enlargeFactor: 0.20,
                                  enableInfiniteScroll: false,
                                  enlargeCenterPage: true,
                                  onPageChanged: (int index,
                                      CarouselPageChangedReason reason) {
                                    currentIndex.value = index;
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
                                  onTap: () => carouselController
                                      .animateToPage(entry.key),
                                  child: Container(
                                    width: 8.0,
                                    height: 8.0,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black.withOpacity(
                                        currentIndex.value == entry.key
                                            ? 0.9
                                            : 0.4,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            titleTopRatedBabySitter(),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 5,
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
                )
              : HomeBabysitterView(
                  username: authState.user!.name ?? '',
                  userImg: authState.user!.profileImg ?? '',
                  location: authState.user!.address ?? '',
                ),
    );
  }
}

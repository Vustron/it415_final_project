import 'package:babysitterapp/views/(home_Macas_Millan)/home_babysitter/views.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/controllers/auth_controller.dart';

import 'package:babysitterapp/core/constants.dart';
import 'package:babysitterapp/core/helpers.dart';
import 'package:babysitterapp/core/state.dart';

import 'package:babysitterapp/models/user_account.dart';

import 'package:babysitterapp/views/settings.dart';
import 'package:babysitterapp/views/booking.dart';
import 'package:babysitterapp/views/home.dart';

class HomeView extends HookConsumerWidget with GlobalStyles {
  HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<int> currentIndex = useState(0);
    final CarouselSliderController carouselController =
        CarouselSliderController();
    final List<Widget> babysitterCards = List<Widget>.generate(
      5,
      (int index) => babySitterCardNearby(
        context,
        networkImage:
            'https://images.unsplash.com/photo-1631947430066-48c30d57b943?q=80&w=1432&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
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

    final AuthenticationState authState = ref.watch(authController);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        leading: authState.maybeWhen(
          authenticated: (UserAccount user) => user.role == 'Client'
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: CircleAvatar(
                    backgroundImage:
                        (user.profileImg != null && user.profileImg!.isNotEmpty)
                            ? NetworkImage(user.profileImg!)
                            : const AssetImage(avatar2) as ImageProvider,
                  ),
                )
              : null,
          orElse: () => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: CircleAvatar(
              backgroundImage: AssetImage(avatar2),
            ),
          ),
        ),
        centerTitle: false,
        title: authState.maybeWhen(
          authenticated: (UserAccount user) => user.role == 'Client'
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    authState.maybeWhen(
                      authenticated: (UserAccount user) => Text(
                        'Hello ${user.name}!',
                        style: headerStyle.copyWith(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      loading: () => const CircularProgressIndicator(),
                      orElse: () => const Text('Hello Guest!'),
                    ),
                    authState.maybeWhen(
                      authenticated: (UserAccount user) => Text(
                        'Location: ${user.address}',
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      loading: () => const CircularProgressIndicator(),
                      orElse: () => const Text('Hello Guest!'),
                    ),
                  ],
                )
              : const Text('Dashboard'),
          orElse: () => const Text('Guest Mode'),
        ),
        actions: <Widget>[
          authState.maybeWhen(
            authenticated: (UserAccount user) => user.role == 'Client'
                ? IconButton(
                    onPressed: () {
                      goToPage(context, BookingView(), 'rightToLeftWithFade');
                    },
                    icon: const Icon(
                      FluentIcons.person_add_16_regular,
                      color: Colors.black,
                      size: 31,
                    ),
                  )
                : const SizedBox.shrink(),
            orElse: () => const SizedBox.shrink(),
          ),
          IconButton(
            onPressed: () {
              goToPage(context, SettingsView(), 'rightToLeftWithFade');
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
      body: authState.maybeWhen(
        authenticated: (UserAccount user) => user.role == 'Client'
            ? ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(GlobalStyles.defaultPadding),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          titleBabySitterNearby(),
                          //carousel
                          //many types of carousel based on package
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
                                  }),
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
                                    carouselController.animateToPage(entry.key),
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
                                            : 0.4),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          titleTopRatedBabySitter(),
                          //use .toString() if the datatype is different
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index) {
                              return topRatedBabySitterCard(
                                networkImage:
                                    'https://images.unsplash.com/photo-1631947430066-48c30d57b943?q=80&w=1432&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
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
            : DashboardBabySitter(
                username: user.name,
                userImg: user.profileImg.toString(),
                location: user.address.toString(),
              ),
        orElse: () => const CircularProgressIndicator(),
      ),
    );
  }
}

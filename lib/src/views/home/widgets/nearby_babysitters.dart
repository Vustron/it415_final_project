import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants/styles.dart';
import 'package:babysitterapp/src/controllers.dart';
import 'package:babysitterapp/src/components.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

class NearbyBabysitters extends HookWidget with GlobalStyles {
  NearbyBabysitters({
    super.key,
    required this.authController,
    required this.primaryButtonColor,
  });

  final AuthController authController;
  final Color primaryButtonColor;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> currentIndex = useState(0);
    final CarouselSliderController carouselController =
        useMemoized(() => CarouselSliderController());

    final Stream<List<UserAccount>> babysittersStream =
        useMemoized(() => authController.getBabysittersStream());
    final AsyncSnapshot<List<UserAccount>> snapshot =
        useStream(babysittersStream);

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CircularProgressIndicator(
          color: GlobalStyles.primaryButtonColor,
        ),
      );
    }

    if (snapshot.hasError) {
      return Center(
        child: Text('Error: ${snapshot.error}'),
      );
    }

    final List<UserAccount> users = snapshot.data ?? <UserAccount>[];
    if (users.isEmpty) {
      return const Center(
        child: Text('No babysitters found'),
      );
    }

    return Column(
      children: <Widget>[
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Nearby babysitters',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: GlobalStyles.primaryButtonColor,
                ),
              ),
              TextButton(
                onPressed: () {
                  CustomRouter.navigateToWithTransition(
                    const AllBabysittersView(),
                    'rightToLeftWithFade',
                  );
                },
                child: const Text(
                  'See all',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        CarouselSlider.builder(
          carouselController: carouselController,
          itemCount: users.length,
          options: CarouselOptions(
            height: 100,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            initialPage: currentIndex.value,
            enableInfiniteScroll: users.length > 1,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            autoPlayCurve: Curves.easeInOutCubic,
            enlargeCenterPage: true,
            onPageChanged: (int index, CarouselPageChangedReason reason) {
              if (reason != CarouselPageChangedReason.controller) {
                currentIndex.value = index;
              }
            },
            scrollDirection: Axis.horizontal,
            pageSnapping: true,
            pauseAutoPlayOnTouch: true,
            pauseAutoPlayOnManualNavigate: true,
          ),
          itemBuilder: (BuildContext context, int index, int realIndex) {
            final UserAccount user = users[index];
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: currentIndex.value == index ? 1.0 : 0.7,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CachedAvatar(
                      imageUrl: user.profileImg,
                      radius: 25,
                      showOnlineStatus: true,
                      isOnline: user.onlineStatus,
                      showVerificationStatus: true,
                      isVerified: user.emailVerified != null &&
                          user.validIdVerified != null,
                    ),
                    title: Text(
                      user.name ?? 'No Name',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(user.address ?? 'No Address'),
                    onTap: () {
                      // Handle selection
                    },
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              users.asMap().entries.map((MapEntry<int, UserAccount> entry) {
            return GestureDetector(
              onTap: () => carouselController.animateToPage(
                entry.key,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
              ),
              child: Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: GlobalStyles.primaryButtonColor.withOpacity(
                    currentIndex.value == entry.key ? 0.9 : 0.4,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants/styles.dart';
import 'package:babysitterapp/src/controllers.dart';
import 'package:babysitterapp/src/components.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

final StateNotifierProvider<BabysittersCacheNotifier, List<UserAccount>>
    babysittersCacheProvider =
    StateNotifierProvider<BabysittersCacheNotifier, List<UserAccount>>(
        (StateNotifierProviderRef<BabysittersCacheNotifier, List<UserAccount>>
            ref) {
  return BabysittersCacheNotifier();
});

class BabysittersCacheNotifier extends StateNotifier<List<UserAccount>> {
  BabysittersCacheNotifier() : super(<UserAccount>[]);

  void updateBabysitters(List<UserAccount> babysitters) {
    state = <UserAccount>[...babysitters];
  }
}

class HomeClientView extends HookConsumerWidget with GlobalStyles {
  HomeClientView({
    super.key,
    required this.authController,
    required this.primaryButtonColor,
  });

  final AuthController authController;
  final Color primaryButtonColor;

  final List<Map<String, dynamic>> babysittingAdvice = <Map<String, dynamic>>[
    <String, dynamic>{
      'title': 'Safety First',
      'description':
          'Always keep emergency contacts handy and know basic first aid',
      'icon': Icons.health_and_safety,
    },
    <String, dynamic>{
      'title': 'Establish Routine',
      'description':
          'Maintain consistent meal and sleep schedules for children',
      'icon': Icons.schedule,
    },
    <String, dynamic>{
      'title': 'Engage & Play',
      'description':
          'Mix educational activities with fun games to keep children active',
      'icon': Icons.toys,
    },
    <String, dynamic>{
      'title': 'Stay Connected',
      'description': "Keep parents updated about their child's activities",
      'icon': Icons.message,
    },
    <String, dynamic>{
      'title': 'Be Prepared',
      'description': 'Have backup activities ready for unexpected situations',
      'icon': Icons.library_books,
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<int> currentIndex = useState(0);
    final ValueNotifier<int> adviceIndex = useState(0);
    final CarouselSliderController carouselController =
        useMemoized(() => CarouselSliderController());
    final CarouselSliderController adviceController =
        useMemoized(() => CarouselSliderController());

    final List<UserAccount> cachedBabysitters =
        ref.watch(babysittersCacheProvider);

    final Stream<List<UserAccount>> babysittersStream = useMemoized(
      () => authController
          .getBabysittersStream()
          .map((List<UserAccount> babysitters) {
        ref
            .read(babysittersCacheProvider.notifier)
            .updateBabysitters(babysitters);
        return babysitters;
      }),
      <Object?>[],
    );
    final AsyncSnapshot<List<UserAccount>> snapshot =
        useStream(babysittersStream);

    if (snapshot.connectionState == ConnectionState.waiting &&
        cachedBabysitters.isEmpty) {
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

    final List<UserAccount> users = snapshot.data ?? cachedBabysitters;
    if (users.isEmpty) {
      return const Center(
        child: Text('No babysitters found'),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 30),
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
              viewportFraction: 0.8,
              initialPage: currentIndex.value,
              enableInfiniteScroll: users.length > 1,
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
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        user.address ?? 'No Address',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.message_rounded,
                          color: GlobalStyles.primaryButtonColor,
                        ),
                        onPressed: () {
                          CustomRouter.navigateToWithTransition(
                            MessageDetailScreen(
                              name: user.name ?? 'No Name',
                              number: user.phoneNumber ?? '',
                              image: user.profileImg ?? '',
                              recipientId: user.id ?? '',
                            ),
                            'rightToLeftWithFade',
                          );
                        },
                      ),
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
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Divider(thickness: 1.0),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.lightbulb,
                  color: GlobalStyles.primaryButtonColor,
                  size: 24,
                ),
                SizedBox(width: 8),
                Text(
                  'Babysitting Tips',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: GlobalStyles.primaryButtonColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          CarouselSlider.builder(
            carouselController: adviceController,
            itemCount: babysittingAdvice.length,
            options: CarouselOptions(
              height: 180,
              viewportFraction: 0.8,
              initialPage: adviceIndex.value,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 6),
              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
              autoPlayCurve: Curves.easeInOutCubic,
              enlargeCenterPage: true,
              onPageChanged: (int index, CarouselPageChangedReason reason) {
                if (reason != CarouselPageChangedReason.controller) {
                  adviceIndex.value = index;
                }
              },
            ),
            itemBuilder: (BuildContext context, int index, int realIndex) {
              final Map<String, dynamic> advice = babysittingAdvice[index];
              return AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: adviceIndex.value == index ? 1.0 : 0.7,
                child: Card(
                  elevation: 4,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            advice['icon'] as IconData,
                            color: GlobalStyles.primaryButtonColor,
                            size: 32,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            advice['title'] as String,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: GlobalStyles.primaryButtonColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            advice['description'] as String,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: babysittingAdvice
                .asMap()
                .entries
                .map((MapEntry<int, Map<String, dynamic>> entry) {
              return GestureDetector(
                onTap: () => adviceController.animateToPage(
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
                      adviceIndex.value == entry.key ? 0.9 : 0.4,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

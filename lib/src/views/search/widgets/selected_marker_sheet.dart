import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

class SelectedMarkerSheet extends HookConsumerWidget with GlobalStyles {
  SelectedMarkerSheet({
    super.key,
    required this.markerData,
    required this.clientPosition,
  });

  final MarkerData markerData;
  final LatLng clientPosition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isExpanded = useState(false);
    final AnimationController slideController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    final AnimationController fadeController = useAnimationController(
      duration: const Duration(milliseconds: 400),
    );

    final double slideAnimation = useAnimation(
      CurvedAnimation(
        parent: slideController,
        curve: Curves.easeOutCubic,
      ),
    );

    useAnimation(
      CurvedAnimation(
        parent: fadeController,
        curve: Curves.easeIn,
      ),
    );

    useEffect(() {
      slideController.forward();
      fadeController.forward();
      return null;
    }, <Object?>[]);

    Widget buildInfoRow(String label, String? value) {
      if (value == null) return const SizedBox.shrink();
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 100,
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      );
    }

    Widget buildChipList(String label, List<String>? items) {
      if (items == null || items.isEmpty) return const SizedBox.shrink();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                items.map((String item) => Chip(label: Text(item))).toList(),
          ),
          const SizedBox(height: 16),
        ],
      );
    }

    return Transform.translate(
      offset: Offset(0, 200 * (1 - slideAnimation)),
      child: FadeTransition(
        opacity: fadeController,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: isExpanded.value ? 600 : 200,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Profile Section
                      Row(
                        children: <Widget>[
                          Hero(
                            tag: 'marker_${markerData.user.profileImg}',
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey[200],
                              backgroundImage: markerData.user.profileImg !=
                                      null
                                  ? NetworkImage(markerData.user.profileImg!)
                                  : null,
                              child: markerData.user.profileImg == null
                                  ? const Icon(Icons.person,
                                      size: 30, color: Colors.grey)
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  markerData.user.name ?? 'Anonymous',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (markerData.user.hourlyRate != null)
                                  Text(
                                    '₱${markerData.user.hourlyRate}/hr',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: GlobalStyles.primaryButtonColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Location Info
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Row(
                          children: <Widget>[
                            const Icon(
                              FluentIcons.location_24_regular,
                              color: GlobalStyles.primaryButtonColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${calculateDistance(
                                clientPosition,
                                markerData.position,
                              ).toStringAsFixed(1)} km away',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      if (isExpanded.value) ...<Widget>[
                        const SizedBox(height: 24),

                        const Text(
                          'Basic Information',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        buildInfoRow('Experience',
                            markerData.user.babysittingExperience),
                        buildInfoRow('Gender', markerData.user.gender),
                        buildInfoRow('Languages',
                            markerData.user.languagesSpeak?.join(', ')),

                        const SizedBox(height: 24),

                        // Experience Section
                        const Text(
                          'Experience & Preferences',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        buildChipList(
                            'Age Groups', markerData.user.experienceWithAges),
                        buildChipList('Comfortable With',
                            markerData.user.comfortableWith),
                        buildChipList('Preferred Locations',
                            markerData.user.preferredBabysittingLocation),
                        const SizedBox(height: 16),
                        const Text(
                          'Availability',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        buildChipList(
                            'Available On', markerData.user.availability),
                        const SizedBox(height: 16),
                        const Text(
                          'Additional Information',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        buildInfoRow(
                            "Has Driver's License",
                            markerData.user.hasDrivingLicense ?? true
                                ? 'Yes'
                                : 'No'),
                        buildInfoRow('Has Car',
                            markerData.user.hasCar ?? true ? 'Yes' : 'No'),
                        buildInfoRow('Has Children',
                            markerData.user.hasChildren ?? true ? 'Yes' : 'No'),
                        buildInfoRow('Smoker',
                            markerData.user.isSmoker ?? true ? 'Yes' : 'No'),
                      ],

                      const SizedBox(height: 20),

                      if (!isExpanded.value) ...<Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => isExpanded.value = true,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      GlobalStyles.primaryButtonColor,
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                ),
                                child: const Text('View Profile'),
                              ),
                            ),
                          ],
                        ),
                      ] else ...<Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => isExpanded.value = false,
                                style: OutlinedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                ),
                                child: const Text('Show Less'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  final String phoneNumber =
                                      markerData.user.phoneNumber ?? '';
                                  final String name =
                                      markerData.user.name ?? 'Anonymous';
                                  final String image =
                                      markerData.user.profileImg ?? '';
                                  final String userId =
                                      markerData.user.id ?? '';

                                  if (userId.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Cannot message this user'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                    return;
                                  }

                                  CustomRouter.navigateToWithTransition(
                                    MessageDetailScreen(
                                      name: name,
                                      number: phoneNumber,
                                      image: image,
                                      recipientId: userId,
                                    ),
                                    'fade',
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      GlobalStyles.primaryButtonColor,
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                ),
                                child: const Text('Message'),
                              ),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

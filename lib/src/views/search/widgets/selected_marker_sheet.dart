import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';

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
                height: isExpanded.value ? 400 : 200,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Hero(
                            tag: 'marker_${markerData.image}',
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(markerData.image),
                              backgroundColor: Colors.grey[200],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'Jane Doe',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    const Icon(
                                      FluentIcons.star_24_filled,
                                      size: 16,
                                      color: Colors.amber,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '4.8',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
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
                        const SizedBox(height: 20),
                        const Text(
                          'About',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Experienced babysitter with 5 years of experience caring for children of all ages. CPR certified and first aid trained.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            _buildStat(
                              FluentIcons.heart_24_regular,
                              '50+',
                              'Happy Clients',
                            ),
                            _buildStat(
                              FluentIcons.clock_24_regular,
                              '200+',
                              'Hours',
                            ),
                            _buildStat(
                              FluentIcons.calendar_24_regular,
                              '2 yrs',
                              'Experience',
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 20),
                      Center(
                        child: TextButton(
                          onPressed: () => isExpanded.value = !isExpanded.value,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                isExpanded.value ? 'Show less' : 'Show more',
                                style: const TextStyle(
                                  color: GlobalStyles.primaryButtonColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                isExpanded.value
                                    ? FluentIcons.chevron_up_24_regular
                                    : FluentIcons.chevron_down_24_regular,
                                color: GlobalStyles.primaryButtonColor,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
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

  Widget _buildStat(IconData icon, String value, String label) {
    return Column(
      children: <Widget>[
        Icon(icon, color: GlobalStyles.primaryButtonColor),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

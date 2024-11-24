import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/models/marker.dart';
import 'package:babysitterapp/src/providers.dart';

class MarkerIcon extends HookWidget {
  const MarkerIcon({
    super.key,
    required this.images,
    required this.color,
    required this.markerData,
  });

  final String images;
  final Color color;
  final MarkerData markerData;

  @override
  Widget build(BuildContext context) {
    final AnimationController pulseController = useAnimationController(
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    final Animation<double> pulseAnimation =
        Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: pulseController,
        curve: Curves.easeInOut,
      ),
    );

    return Consumer(builder: (BuildContext context, WidgetRef ref, _) {
      final MarkerData? selectedMarker = ref.watch(selectedMarkerService);
      final bool isSelected = selectedMarker == markerData;

      return GestureDetector(
        onTap: () {
          ref.read(selectedMarkerService.notifier).state =
              isSelected ? null : markerData;
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            if (isSelected)
              AnimatedBuilder(
                animation: pulseAnimation,
                builder: (BuildContext context, Widget? child) {
                  return Transform.scale(
                    scale: pulseAnimation.value,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: color,
                          width: 2,
                        ),
                      ),
                    ),
                  );
                },
              ),
            Container(
              width: 70,
              height: 70,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : color,
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(
                        color: Colors.white,
                        width: 2,
                      )
                    : null,
              ),
              child: ClipOval(
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(images),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

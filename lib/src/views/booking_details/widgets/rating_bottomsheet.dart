import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/components.dart';
import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/services.dart';

class RatingBottomSheet extends HookConsumerWidget {
  const RatingBottomSheet({
    super.key,
    required this.onSubmit,
  });

  final void Function(double rating, String comment) onSubmit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<double> rating = useState(0);
    final ValueNotifier<double> hoverRating = useState(0);
    final TextEditingController commentController = useTextEditingController();
    final Toast toast = ref.watch(toastService);

    String getRatingText(double value) {
      switch (value.toInt()) {
        case 1:
          return 'Poor';
        case 2:
          return 'Fair';
        case 3:
          return 'Good';
        case 4:
          return 'Very Good';
        case 5:
          return 'Excellent';
        default:
          return 'Rate your experience';
      }
    }

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 4,
                  width: 40,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Rate Babysitter',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  getRatingText(rating.value),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: List<Widget>.generate(
                      5,
                      (int index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: MouseRegion(
                          onEnter: (_) => hoverRating.value = index + 1.0,
                          onExit: (_) => hoverRating.value = 0,
                          child: AnimatedScale(
                            scale: index <
                                    (hoverRating.value > 0
                                        ? hoverRating.value
                                        : rating.value)
                                ? 1.2
                                : 1.0,
                            duration: const Duration(milliseconds: 200),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 24,
                                minHeight: 24,
                                maxWidth: 24,
                                maxHeight: 24,
                              ),
                              icon: Icon(
                                index <
                                        (hoverRating.value > 0
                                            ? hoverRating.value
                                            : rating.value)
                                    ? FluentIcons.star_24_filled
                                    : FluentIcons.star_24_regular,
                                color: Colors.amber,
                                size: 20, // Reduced icon size
                              ),
                              onPressed: () => rating.value = index + 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                CustomTextInput(
                  controller: commentController,
                  hintText: 'Share details of your experience...',
                  fieldLabel: 'Your Review',
                  maxLines: 3,
                  borderRadius: 12,
                  isRequired: false,
                  minLength: 10,
                  maxLength: 500,
                  onChanged: (_) {},
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    OutlinedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        FluentIcons.dismiss_24_regular,
                        size: 20,
                      ),
                      label: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        side: BorderSide(
                          color: Colors.grey[300]!,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (rating.value == 0) {
                          toast.show(
                            context: context,
                            title: 'Error',
                            message: 'Please select a rating',
                            type: 'error',
                          );
                          return;
                        }
                        onSubmit(rating.value, commentController.text);
                      },
                      icon: const Icon(FluentIcons.send_24_filled, size: 20),
                      label: const Text(
                        'Submit Review',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

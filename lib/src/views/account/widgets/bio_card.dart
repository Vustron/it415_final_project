import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/models.dart';

class BioCard extends HookWidget with GlobalStyles {
  BioCard({
    super.key,
    required this.primaryButtonColor,
    required this.authState,
  });

  final Color primaryButtonColor;
  final AuthState authState;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isExpanded = useState(false);
    final int kMaxLines = useMemoized(() => 3);
    final int kCharacterLimit = useMemoized(() => 100);

    final String description = authState.user!.description!;
    final bool isLongText = description.length > kCharacterLimit;
    final String hourlyRate = NumberFormat.currency(
      symbol: '₱',
      decimalDigits: 2,
    ).format(num.tryParse(authState.user?.hourlyRate.toString() ?? '0') ?? 0);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Bio section
            const Row(
              children: <Widget>[
                Icon(
                  FluentIcons.text_description_24_regular,
                  size: 20,
                  color: GlobalStyles.primaryButtonColor,
                ),
                SizedBox(width: 8),
                Text(
                  'Bio',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            AnimatedCrossFade(
              firstChild: Text(
                description,
                maxLines: kMaxLines,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  height: 1.5,
                  fontSize: 15,
                ),
                textAlign: TextAlign.justify,
              ),
              secondChild: Text(
                description,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  height: 1.5,
                  fontSize: 15,
                ),
                textAlign: TextAlign.justify,
              ),
              crossFadeState: isExpanded.value
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
            if (isLongText) ...<Widget>[
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => isExpanded.value = !isExpanded.value,
                child: Text(
                  isExpanded.value ? 'Show less' : 'Read more',
                  style: const TextStyle(
                    color: GlobalStyles.primaryButtonColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],

            if (authState.user!.role == 'Babysitter') ...<Widget>[
              const SizedBox(height: 16),
              Divider(color: Colors.grey.shade200),
              const SizedBox(height: 16),
              Row(
                children: <Widget>[
                  const Icon(
                    FluentIcons.money_24_regular,
                    size: 20,
                    color: GlobalStyles.primaryButtonColor,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Hourly Rate',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '$hourlyRate/hr',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: GlobalStyles.primaryButtonColor,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

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

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          size: 20,
          color: GlobalStyles.primaryButtonColor,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 18, color: GlobalStyles.primaryButtonColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$label: $value',
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBooleanItem(IconData icon, String label, bool? value) {
    if (value == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 18,
            color: GlobalStyles.primaryButtonColor,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: value ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
            ),
            child: Text(
              value ? 'Yes' : 'No',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: value ? Colors.green.shade700 : Colors.red.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isExpanded = useState(false);
    final int kMaxLines = useMemoized(() => 3);
    final int kCharacterLimit = useMemoized(() => 100);

    final UserAccount user = authState.user!;
    final String description = user.description ?? 'No description available';
    final bool isLongText = description.length > kCharacterLimit;
    final String hourlyRate = NumberFormat.currency(
      symbol: '₱',
      decimalDigits: 2,
    ).format(num.tryParse(user.hourlyRate ?? '0') ?? 0);

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
            _buildSectionTitle('Bio', FluentIcons.text_description_24_regular),
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
            const SizedBox(height: 16),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 16),
            _buildSectionTitle(
                'Personal Details', FluentIcons.person_24_regular),
            const SizedBox(height: 12),
            _buildDetailItem(
                FluentIcons.person_24_regular, 'Gender', user.gender),
            if (user.birthDate != null)
              _buildDetailItem(
                FluentIcons.calendar_24_regular,
                'Age',
                '${DateTime.now().year - user.birthDate!.year} years old',
              ),
            if (user.role == 'Babysitter') ...<Widget>[
              const SizedBox(height: 16),
              Divider(color: Colors.grey.shade200),
              const SizedBox(height: 16),
              _buildSectionTitle(
                  'Babysitting Experience', FluentIcons.book_24_regular),
              const SizedBox(height: 12),
              _buildDetailItem(
                FluentIcons.clock_24_regular,
                'Experience',
                user.babysittingExperience,
              ),
              if (user.experienceWithAges?.isNotEmpty ?? false)
                _buildDetailItem(
                  FluentIcons.people_24_regular,
                  'Age Groups',
                  user.experienceWithAges!.join(', '),
                ),
              if (user.languagesSpeak?.isNotEmpty ?? false)
                _buildDetailItem(
                  FluentIcons.translate_24_regular,
                  'Languages',
                  user.languagesSpeak!.join(', '),
                ),
              if (user.comfortableWith?.isNotEmpty ?? false)
                _buildDetailItem(
                  FluentIcons.checkmark_circle_24_regular,
                  'Comfortable With',
                  user.comfortableWith!.join(', '),
                ),
              const SizedBox(height: 16),
              Divider(color: Colors.grey.shade200),
              const SizedBox(height: 16),
              _buildSectionTitle(
                'Preferences & Details',
                FluentIcons.options_24_regular,
              ),
              const SizedBox(height: 12),
              _buildBooleanItem(
                FluentIcons.vehicle_car_24_regular,
                'Has Driving License',
                user.hasDrivingLicense,
              ),
              _buildBooleanItem(
                FluentIcons.vehicle_car_24_regular,
                'Has Car',
                user.hasCar,
              ),
              _buildBooleanItem(
                FluentIcons.people_24_regular,
                'Has Children',
                user.hasChildren,
              ),
              _buildBooleanItem(
                FluentIcons.prohibited_24_regular,
                'Non-Smoker',
                user.isSmoker != null ? !user.isSmoker! : null,
              ),
              if (user.preferredBabysittingLocation?.isNotEmpty ?? false)
                _buildDetailItem(
                  FluentIcons.location_24_regular,
                  'Preferred Locations',
                  user.preferredBabysittingLocation!.join(', '),
                ),
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

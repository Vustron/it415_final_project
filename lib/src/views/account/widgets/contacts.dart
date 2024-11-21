import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/models.dart';

class Contacts extends StatelessWidget {
  const Contacts({super.key, required this.user});

  final UserAccount user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Contacts',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: <Widget>[
            const SizedBox(width: 18),
            const Icon(
              Icons.phone,
              color: GlobalStyles.primaryButtonColor,
              size: 30,
            ),
            const SizedBox(width: 14),
            Text(
              user.phoneNumber != null && user.phoneNumber!.isNotEmpty
                  ? user.phoneNumber!
                  : 'No phone number yet',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        Row(
          children: <Widget>[
            const SizedBox(width: 18),
            const Icon(
              Icons.facebook,
              color: GlobalStyles.primaryButtonColor,
              size: 30,
            ),
            const SizedBox(width: 14),
            Text(
              user.name ?? 'No name provided',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 22),
        Row(
          children: <Widget>[
            const SizedBox(width: 18),
            const Icon(
              Icons.my_location_outlined,
              color: GlobalStyles.primaryButtonColor,
              size: 30,
            ),
            const SizedBox(width: 14),
            Text(
              user.address != null && user.address!.isNotEmpty
                  ? user.address!
                  : 'No address yet',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

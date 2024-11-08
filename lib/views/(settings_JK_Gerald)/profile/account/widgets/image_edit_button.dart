import 'package:babysitterapp/core/helper/goto_page.dart';
import 'package:babysitterapp/models/user_account.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/core/constants/assets.dart';
import 'package:babysitterapp/core/constants/styles.dart';

import 'package:babysitterapp/views/(settings_JK_Gerald)/profile/edit_account/view.dart';

class AccountImageEditButton extends StatelessWidget {
  const AccountImageEditButton({super.key, required this.user});

  final UserAccount user;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: user.profileImg != null
                  ? NetworkImage(user.profileImg!)
                  : const AssetImage(avatar2) as ImageProvider,
              radius: 50,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user.email,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          children: <Widget>[
            // const Text(
            //   '₱ 300/hr',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            const SizedBox(height: 3),
            ElevatedButton.icon(
              onPressed: () {
                goToPage(context, const EditBabySitterProfile(),
                    'rightToLeftWithFade');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    GlobalStyles.primaryButtonColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              icon: const Icon(Icons.edit),
              label: const Text(
                'Edit Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

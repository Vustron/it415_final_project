import 'package:babysitterapp/core/constants/assets.dart';
import 'package:babysitterapp/core/constants/styles.dart';
import 'package:babysitterapp/views/babysitter_profile/account/edit_account/view.dart';
import 'package:flutter/material.dart';

class AccountImageEditButton extends StatelessWidget {
  const AccountImageEditButton({super.key});

  @override
  Widget build(BuildContext context) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // PROFILE AND RATE PER HOUR
        Row(
          children: <Widget>[
            Image.asset(
              avatar2,
              width: 100,
              height: 100,
            ),
            const SizedBox(width: 8),
            const Column(
              children: <Widget>[
                Text(
                  'Arvin Sison',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                Text(
                  'arvinsison@gmail.com',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ],
            ),
          ],
        ),

        Column(
          children: <Widget>[
            const Text(
              '₱ 300/hr',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 3),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) =>
                        const EditBabySitterProfile(),
                  ),
                );
              },
              style: ButtonStyle(
                iconSize: const WidgetStatePropertyAll<double>(12),
                maximumSize:
                    const WidgetStatePropertyAll<Size>(Size.fromWidth(100)),
                backgroundColor: const WidgetStatePropertyAll<Color>(
                    GlobalStyles.primaryButtonColor),
                shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
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
                  fontSize: 10,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

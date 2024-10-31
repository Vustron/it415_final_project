import 'package:babysitterapp/core/constants/styles.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget with GlobalStyles {
  LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.logout, color: Colors.white),
          label: const Text('Log out', style: TextStyle(color: Colors.white)),
          style: TextButton.styleFrom(
            backgroundColor: GlobalStyles.primaryButtonColor,
            padding: const EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

class EditAccountView extends HookConsumerWidget with GlobalStyles {
  EditAccountView({super.key, required this.user});
  final UserAccount? user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isLoading = useState(false);
    final double profileCompletion = calculateProfileCompletion(user!);
    final Future<void> Function(Map<String, dynamic> p1) onSubmit =
        useProfileSubmit(
      ref: ref,
      context: context,
      user: user,
      isLoading: isLoading,
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              ProfileCompletion(profileCompletion: profileCompletion),
              ProfileForm(
                user: user ??
                    UserAccount(
                      id: '',
                      name: '',
                      address: '',
                      addressLatitude: '',
                      addressLongitude: '',
                      phoneNumber: '',
                      email: '',
                      provider: '',
                      profileImg: '',
                      description: '',
                      gender: '',
                      birthDate: null,
                      hourlyRate: '',
                      role: '',
                      onlineStatus: false,
                      emailVerified: null,
                      validIdVerified: null,
                      validId: '',
                      validIdFront: '',
                      validIdBack: '',
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                onSubmit: onSubmit,
                isLoading: isLoading,
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
